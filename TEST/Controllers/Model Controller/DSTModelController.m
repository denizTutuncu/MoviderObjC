//
//  DSTModelController.m
//  TEST
//
//  Created by Deniz Tutuncu on 2/15/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

#import "DSTModelController.h"

@implementation DSTModelController

static NSString * const api_key = @"08617466ca90470470df3f866a00dda1";
static NSString * const baseImageUrl = @"http://image.tmdb.org/t/p/w500";

+ (instancetype)sharedController;
{
    static DSTModelController*sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[DSTModelController alloc] init];
    });
    return sharedController;
}

+ (NSURL *)baseURL
{
    return [NSURL URLWithString:@"https://api.themoviedb.org/3/search/movie"];
}

- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^) (NSArray<DSTMovie *> *movies, NSError *error))completion;
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:[DSTModelController baseURL] resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:@"api_key" value: api_key];
    NSURLQueryItem *queryItem2 = [NSURLQueryItem queryItemWithName:@"query" value: searchTerm]; ///< searchTerm need to add
    urlComponents.queryItems = @[queryItem, queryItem2];
    
    NSURL *searchURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSLog(@"no data returned from the task");
            completion(nil, error);
            return;
        }
        NSDictionary *TLdDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if(!TLdDictionary || ![TLdDictionary isKindOfClass:[NSDictionary class]]){
            NSLog(@"JSONDictionary is not dicitionary class");
            completion(nil, error);
            return;
        }
        
        NSMutableArray<DSTMovie *> *postsArray = [NSMutableArray new];
        NSArray *resultsArray = TLdDictionary[@"results"];
        
        for (NSDictionary *movieDictionary in resultsArray) {
            
            DSTMovie *movie = [[DSTMovie alloc] initWithDictionary: movieDictionary];
            
            [postsArray addObject: movie];
            NSLog(@"%@",postsArray);
            
        }
        completion(postsArray, nil);
        
    }]resume];
    
}

-(void)fetchImageForMovie:(DSTMovie *)movie completion:(void (^)(UIImage *))completion
{
    NSURL *baseURL = [NSURL URLWithString: baseImageUrl];
    NSURL *searchURL = [baseURL URLByAppendingPathComponent: movie.imageAsString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil);
            return;
        }
        
        if (!data) {
            completion(nil);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        
        completion(image);
    }] resume];
}
@end
