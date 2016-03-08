//
//  Post.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "Post.h"

#import "Photo.h"

@implementation Post

- (id)initWithDictionary:(NSDictionary*)dict {
    if (self = [super init]) {
        _type = dict[@"type"];
        _format = dict[@"format"];
        _tags = [NSArray arrayWithArray:dict[@"tags"]];
        _regularBody = dict[@"regular-body"];
        _regularTitle = dict[@"regular-title"];
        _quoteText = dict[@"quote-text"];
        _quoteSource = dict[@"quote-source"];
        _photoCaption = dict[@"photo-caption"];
        //_postId = dict[@"id"];
        _photos = [self photosWithDict:dict];
        
        return self;
    }
    
    return nil;
}

- (NSArray*)photosWithDict:(NSDictionary*)dict {
    NSMutableArray* photos = [NSMutableArray array];
    
    /*for (NSString *key in dict) {
        if ([key rangeOfString:@"photo-url-"].location != NSNotFound) {
            NSMutableString* mutableString = [NSMutableString stringWithString:key];
            
            [mutableString deleteCharactersInRange:NSMakeRange(0, 10)];
        }
    }*/
    
    NSArray* photoset = dict[@"photos"];
    
    NSLog(@"************************\n\n\n");
    for (id elem in photoset) {
        NSLog(@"%@", elem);
    };
    /*[dict enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* url, BOOL *stop){
        if ([key rangeOfString:@"photo-url-"].location != NSNotFound) {
            NSMutableString* mutableString = [NSMutableString stringWithString:key];
            
            [mutableString deleteCharactersInRange:NSMakeRange(0, 10)];
            
            Photo* photo = [[Photo alloc] initWithUrl:[NSURL URLWithString:url] andWidth:[mutableString integerValue]];
            [photos addObject:photo];
        }
    }];
    
    NSArray *sorted = [photos sortedArrayUsingComparator:^(Photo* obj1, Photo* obj2){
        if (obj1.width < obj2.width) {
                return (NSComparisonResult)NSOrderedAscending;
        } else if (obj1.width > obj2.width) {
                return (NSComparisonResult)NSOrderedDescending;
         }
        
        return (NSComparisonResult)NSOrderedSame;
    }];*/
    
    return nil;//sorted;
}

@end
