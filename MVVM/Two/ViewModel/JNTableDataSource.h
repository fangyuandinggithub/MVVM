//
//  JNTableDataSource.h
//  MVVM
//
//  Created by fangyuan ding on 2019/12/16.
//  Copyright © 2019年 fangyuan ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface JNTableDataSource : NSObject<UITableViewDataSource>

- (instancetype)initWithCellIdentifier:(NSString *)identifier configure:(void (^) (id cell, id  model, NSIndexPath *indexPath)) configure;

@property (nonatomic, strong)NSArray *datas;

@end

NS_ASSUME_NONNULL_END
