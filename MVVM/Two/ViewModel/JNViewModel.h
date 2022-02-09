//
//  JNViewModel.h
//  MVVM
//
//  Created by fangyuan ding on 2019/12/16.
//  Copyright © 2019年 fangyuan ding. All rights reserved.
//

#import "JNBaseViewModel.h"
#import "JNModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JNViewModel : JNBaseViewModel

@property (nonatomic, copy)NSString *selectName;//被选中

@property (nonatomic, strong)NSMutableArray *datas;


- (void)refreshAction;


@end

NS_ASSUME_NONNULL_END
