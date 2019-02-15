//
//  DSTMovie.m
//  TEST
//
//  Created by Deniz Tutuncu on 2/15/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

#import "DSTMovie.h"

@implementation DSTMovie

-(instancetype) initWithTitle:(NSString *)title rating:(NSInteger)rating overview:(NSString *)overview imageAsString:(NSString *)imageAsString
{
    self = [super init];
    if (self) {
        
        _title = [title copy];
        _rating = rating;
        _overview = [overview copy];
        _imageAsString = [imageAsString copy];
    }
    return self;
}
-(instancetype) initWithDictionary:(NSDictionary *)dictionary

{
    NSString *title = dictionary[@"title"];
    NSInteger rating = [dictionary[[DSTMovie ratingKey]] intValue];
    NSString *overview = dictionary[@"overview"];
    NSString *imageAsString = dictionary[[DSTMovie imageAsString]];
    
    return [self initWithTitle:title rating:rating overview:overview imageAsString:imageAsString];
}

+ (NSString *)imageAsString
{
    return @"poster_path";
}

+ (NSString *)ratingKey
{
    return @"popularity";
}
@end
