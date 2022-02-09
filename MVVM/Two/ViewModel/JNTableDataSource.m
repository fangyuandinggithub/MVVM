//
//  JNTableDataSource.m
//  MVVM
//
//  Created by fangyuan ding on 2019/12/16.
//  Copyright © 2019年 fangyuan ding. All rights reserved.
//

#import "JNTableDataSource.h"
#import "JNTableViewCell.h"
#import "JNViewModel.h"
@interface JNTableDataSource ()

@property (nonatomic, copy)void (^ configure) (id cell, id model, NSIndexPath *indexPath);

@property (nonatomic, copy)NSString *identifier;

@end

@implementation JNTableDataSource


- (instancetype)initWithCellIdentifier:(NSString *)identifier configure:(void (^)(id _Nonnull, id _Nonnull, NSIndexPath * _Nonnull))configure{
    self = [super init];
    if(self){
        _identifier = identifier;
        _configure = configure;
    }
    return self;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier];
    if(cell == nil){
        cell = [[JNTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.identifier];
    }
    if (self.configure) {
        self.configure(cell, self.datas[indexPath.row], indexPath);
    }
        
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
@end
