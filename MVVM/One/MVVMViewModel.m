//
//  MVVMViewModel.m
//  MVVM
//
//  Created by fangyuan ding on 2019/12/16.
//  Copyright © 2019年 fangyuan ding. All rights reserved.
//

#import "MVVMViewModel.h"

@implementation MVVMViewModel

- (instancetype)init{
    if(self = [super init]){
        //观察值的变化
        [self addObserver:self forKeyPath:@"contentKey" options:(NSKeyValueObservingOptionNew) context:nil];
    }
    return self;
}
- (void)loadData{
    //异步全局队列
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1];
        NSArray *array = @[@"转账",@"信用卡",@"充值中心",@"蚂蚁借呗",@"电影票",@"滴滴出行",@"城市服务",@"蚂蚁森林"];
        dispatch_async(dispatch_get_main_queue(), ^{//回到主线程
            self.successBlock(array);
            
        });
    });
}

#pragma mark -KVO回调

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSString *contentKey = change[NSKeyValueChangeNewKey];
    NSLog(@"检测到的数据变化=%@",contentKey);
     NSArray *array = @[@"转账",@"信用卡",@"充值中心",@"蚂蚁借呗",@"电影票",@"滴滴出行",@"城市服务",@"蚂蚁森林"];
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
    NSLog(@"before:%@",mArray);
    @synchronized (self) {
        [mArray removeObject:contentKey];
    }
     NSLog(@"after:%@",mArray);
    self.successBlock(mArray);
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"contentKey"];
}
@end
