//
//  JNViewController.m
//  MVVM
//
//  Created by fangyuan ding on 2019/12/16.
//  Copyright © 2019年 fangyuan ding. All rights reserved.
//

#import "JNViewController.h"
#import "JNViewModel.h"
#import "JNTableViewCell.h"
#import "JNTableDataSource.h"
@interface JNViewController ()<UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UIButton *refreshBtn;

@property (nonatomic, strong)JNTableDataSource *dataSource;// 封装dataSource

@property (nonatomic, strong)JNViewModel *viewModel;//数据来源

@end

@implementation JNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self bindModel];
    [self setupSubViews];
    
   
}
- (void)bindModel{
    __weak typeof(self) weakSelf = self;
    //3
    self.dataSource = [[JNTableDataSource alloc]initWithCellIdentifier:@"cellid" configure:^(JNTableViewCell *cell, JNModel *model, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = model.name;
        cell.detailTextLabel.text = model.idNumber;
    }];
    //2
    self.viewModel = [[JNViewModel alloc]initWithSucc:^(id  _Nonnull datas) {
        weakSelf.refreshBtn.hidden = YES;
        weakSelf.dataSource.datas = datas;
        [self.tableView reloadData];
    } fail:^{
        
    }];
    
}
#pragma mark --setup subViews
- (void)setupSubViews{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    self.refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    [self.refreshBtn setTitle:@"加载数据" forState:UIControlStateNormal];
    [self.refreshBtn setTitle:@"加载中..." forState:UIControlStateDisabled];
    [self.refreshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.refreshBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.refreshBtn.center = self.view.center;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.refreshBtn];
    
    [self.refreshBtn addTarget:self action:@selector(refreshBtnAction) forControlEvents:UIControlEventTouchUpInside];
}
//1
- (void)refreshBtnAction{
    self.refreshBtn.enabled = NO;
    [self.viewModel refreshAction];
}
#pragma mark -UITabelViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JNModel *model = self.viewModel.datas[indexPath.row];
    self.viewModel.selectName = model.name;
}
@end
