//
//  JNViewModel.m
//  MVVM
//
//  Created by fangyuan ding on 2019/12/16.
//  Copyright © 2019年 fangyuan ding. All rights reserved.
//

#import "JNViewModel.h"

@interface JNViewModel ()

@property (nonatomic, copy)succ succ;//请求成功

@property (nonatomic, copy)fail fail;//请求失败

@end

@implementation JNViewModel


- (instancetype)initWithSucc:(succ)succ fail:(fail)fail{
    self = [super init];
    if(self){
        _succ = succ;
        _fail = fail;
        _datas = [NSMutableArray new];
        //KVO
        [self addObserver:self forKeyPath:@"selectName" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
//监听数据的变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSString *selectName = change[NSKeyValueChangeNewKey];
    // synchronized 这个主要是考虑多线程的程序，这个指令可以将{ } 内的代码限制在一个线程执行，如果某个线程没有执行完，其他的线程如果需要执行就得等着
    @synchronized (self) {
        //遍历查找相同的数据返回对应的索引
        NSInteger index = [self.datas indexOfObjectPassingTest:^BOOL(JNModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [obj.name isEqualToString:selectName];
        }];
        [self.datas removeObjectAtIndex:index];
    }
    
    if(self.succ){
        self.succ(self.datas);
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"selectName" context:nil];
}

- (void)refreshAction{
    //模拟请求
    [[NSOperationQueue new] addOperationWithBlock:^{//异步处理数据
        @synchronized (self) {
            [self.datas removeAllObjects];
            for(int i = 0 ;i < 30 ; i++){
                JNModel *model = [[JNModel alloc]init];
                model.name = [NSString stringWithFormat:@"test%d",i];
                model.idNumber = [NSString stringWithFormat:@"atTest%d",i];
                [self.datas addObject:model];
            }
        }
        sleep(2.0);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{//回到主队列更新UI
            if(self.succ){
                self.succ(self.datas);
            }
        }];
    }];
}
@end
