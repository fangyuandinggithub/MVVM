//
//  MVVMViewModel.h
//  MVVM
//
//  Created by fangyuan ding on 2019/12/16.
//  Copyright © 2019年 fangyuan ding. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVVMViewModel : BaseViewModel

@property (nonatomic, copy)NSString *contentKey;

- (void)loadData;

@end

NS_ASSUME_NONNULL_END
