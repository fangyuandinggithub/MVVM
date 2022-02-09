//
//  BaseViewModel.m
//  MVVM
//
//  Created by fangyuan ding on 2019/12/16.
//  Copyright © 2019年 fangyuan ding. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (void)initWithBlock:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    _successBlock = successBlock;
    _failBlock = failBlock;
}

@end
