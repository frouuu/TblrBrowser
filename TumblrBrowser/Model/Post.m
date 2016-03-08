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
    
    NSArray* photoset = dict[@"photos"];
    
    for (NSDictionary* elem in photoset) {
        NSMutableDictionary* urls = [NSMutableDictionary dictionary];
        [elem enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL *stop){
            if ([key rangeOfString:@"photo-url-"].location != NSNotFound) {
                NSMutableString* mutableString = [NSMutableString stringWithString:key];
            
                [mutableString deleteCharactersInRange:NSMakeRange(0, 10)];
            
                NSString* urlString = elem[key];
                NSURL* url = [NSURL URLWithString:urlString];
                [urls setObject:url forKey:mutableString];
            }
        }];
        
        NSNumber* widthNb = elem[@"width"];
        NSNumber* heightNb = elem[@"height"];
        
        Photo* photo = [[Photo alloc] initWithUrls:urls width:[widthNb intValue] height:[heightNb intValue]];
        [photos addObject:photo];
    };
    
    return photos;
}

@end
