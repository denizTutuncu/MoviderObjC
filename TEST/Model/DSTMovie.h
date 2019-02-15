//
//  DSTMovie.h
//  TEST
//
//  Created by Deniz Tutuncu on 2/15/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSTMovie : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, readonly) NSInteger rating;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, copy, readonly) NSString *imageAsString;

-(instancetype) initWithTitle:(NSString *)title rating:(NSInteger)rating overview:(NSString *)overview imageAsString:(NSString *)imageAsString;

-(instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
