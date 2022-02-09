//
//  BaseViewModel.h
//  MVVM
//
//  Created by fangyuan ding on 2019/12/16.
//  Copyright © 2019年 fangyuan ding. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock) (id data);

typedef void (^FailBlock) (id data);

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModel : NSObject{
    
@public  NSString *name;
}

@property (nonatomic, copy)SuccessBlock successBlock;

@property (nonatomic, copy)FailBlock failBlock;

- (void)initWithBlock:(SuccessBlock) successBlock fail:(FailBlock) failBlock;





@end

NS_ASSUME_NONNULL_END
