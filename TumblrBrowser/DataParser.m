//
//  DataParser.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/11/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "DataParser.h"

#import "Post.h"


@implementation DataParser

+ (NSArray*)postArrayWithData:(NSData*)data error:(NSError**)error {
    // responseData is not JSON, there is some javascript "var tumblr_api_read = " at the beginning and ";" at the end
    NSMutableString *str = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if ([str rangeOfString:@"var tumblr_api_read = "].location == NSNotFound) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Data not valid", @"")};
        *error = [NSError errorWithDomain:@"TumblrDataErrorDomain" code:-1 userInfo:userInfo];
        
        return nil;
    }
    
    [str deleteCharactersInRange:NSMakeRange(0, 22)];
    [str deleteCharactersInRange:NSMakeRange([str length]-1, 1)];
    
    // now we have JSON
    NSData* dataWithoutJavascript = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError* err = nil;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:dataWithoutJavascript
                          options:NSJSONReadingAllowFragments
                          error:&err];
    
    if (err) {
        *error = [NSError errorWithDomain:err.domain code:err.code userInfo:err.userInfo];
        return nil;
    }
    
    NSMutableArray* mutablePosts = [NSMutableArray array];
    
    for (NSDictionary* postData in [json objectForKey:@"posts"]) {
        Post* post = [[Post alloc] initWithDictionary:postData];
        [mutablePosts addObject:post];
    }
    
    return mutablePosts;
}

@end
