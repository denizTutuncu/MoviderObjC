//
//  DSTModelController.h
//  TEST
//
//  Created by Deniz Tutuncu on 2/15/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DSTMovie.h"
@class DSTMovie;

NS_ASSUME_NONNULL_BEGIN

@interface DSTModelController : NSObject
+ (instancetype)sharedController;

- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^) (NSArray<DSTMovie *> *posts, NSError *error))completion;

- (void)fetchImageForMovie:(DSTMovie *)recipe completion:(void (^)(UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
