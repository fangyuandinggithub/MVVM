//
//  MVVMViewController.m
//  MVVM
//
//  Created by fangyuan ding on 2019/12/16.
//  Copyright © 2019年 fangyuan ding. All rights reserved.
//

#import "MVVMViewController.h"
#import "MVVMViewModel.h"
#import "MVVMView.h"
#import "JNViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static NSString *const reuserId = @"reuserId";

@interface MVVMViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)MVVMViewModel *vm;

@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addleftItem];
    [self addRightItem];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.vm = [[MVVMViewModel alloc]init];
    __weak typeof(self) weakSelf = self;
    [self.vm initWithBlock:^(id data) {
        NSArray *array = data;
        MVVMView *headView = [[MVVMView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (array.count + 1)/4 *50) ];
        [headView headViewWithData:array];
        weakSelf.tableView.tableHeaderView = headView;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:array];
        [weakSelf.tableView reloadData];
    } fail:^(id data) {
        
    }];
   
}
- (void)addleftItem{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)addRightItem{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"Go" style:UIBarButtonItemStylePlain target:self action:@selector(go)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)refresh{
    //第一种 本页面数据请求
    [self.vm loadData];
    
}

- (void)go{
    //页面跳转
    JNViewController *vc = [[JNViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserId forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
#pragma mark -tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //vm设置了点击监听
    self.vm.contentKey = self.dataArray[indexPath.row];
    NSLog(@"contentKey=%@",self.vm.contentKey);
  
}

#pragma mark -lazy

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor  = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserId];
        
    }
    return _tableView;
}


@end
