//
//  JNBaseViewModel.h
//  MVVM
//
//  Created by fangyuan ding on 2019/12/16.
//  Copyright © 2019年 fangyuan ding. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^succ) (id datas);

typedef void (^fail) (void);

@interface JNBaseViewModel : NSObject

- (instancetype)initWithSucc:(succ) succ fail:(fail)fail;

@end

NS_ASSUME_NONNULL_END
