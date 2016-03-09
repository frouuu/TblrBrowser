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
        _type = [dict[@"type"] isKindOfClass:[NSString class]] ? dict[@"type"] : @"";
        _tags = [dict[@"tags"] isKindOfClass:[NSArray class]] ? dict[@"tags"] : nil;
        _regularBody = [dict[@"regular-body"] isKindOfClass:[NSString class]] ? dict[@"regular-body"] : @"";
        _regularTitle = [dict[@"regular-title"] isKindOfClass:[NSString class]] ? dict[@"regular-title"] : @"";
        _quoteText = [dict[@"quote-text"] isKindOfClass:[NSString class]] ? dict[@"quote-text"] : @"";
        _quoteSource = [dict[@"quote-source"] isKindOfClass:[NSString class]] ? dict[@"quote-source"] : @"";
        _photoCaption = [dict[@"photo-caption"] isKindOfClass:[NSString class]] ? dict[@"photo-caption"] : @"";
        _photos = [_type isEqualToString:@"photo"] ? [self photosWithDict:dict] : nil;
        
        return self;
    }
    
    return nil;
}

- (NSArray*)photosWithDict:(NSDictionary*)dict {
    NSMutableArray* photos = [NSMutableArray array];
    
    // photos from photoset
    NSArray* photoset = dict[@"photos"];
    
    /*
     Photo example
     "photo-url-1280":"http:\/\/40.media.tumblr.com\/tumblr_kzjlfiTnfe1qz4rgho1_1280.jpg",
     "photo-url-500":"http:\/\/41.media.tumblr.com\/tumblr_kzjlfiTnfe1qz4rgho1_500.jpg",
     "photo-url-400":"http:\/\/40.media.tumblr.com\/tumblr_kzjlfiTnfe1qz4rgho1_400.jpg",
     "photo-url-250":"http:\/\/40.media.tumblr.com\/tumblr_kzjlfiTnfe1qz4rgho1_250.jpg",
     "photo-url-100":"http:\/\/41.media.tumblr.com\/tumblr_kzjlfiTnfe1qz4rgho1_100.jpg",
     "photo-url-75":"http:\/\/40.media.tumblr.com\/tumblr_kzjlfiTnfe1qz4rgho1_75sq.jpg"
     */
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
    
    // one photo
    if ([photoset count] == 0 || photoset == nil) {
        NSMutableDictionary* urls = [NSMutableDictionary dictionary];
        [dict enumerateKeysAndObjectsUsingBlock:^(NSString* key, id obj, BOOL *stop){
            if ([key rangeOfString:@"photo-url-"].location != NSNotFound) {
                NSMutableString* mutableString = [NSMutableString stringWithString:key];
            
                [mutableString deleteCharactersInRange:NSMakeRange(0, 10)];
            
                NSString* urlString = dict[key];
                NSURL* url = [NSURL URLWithString:urlString];
                [urls setObject:url forKey:mutableString];
            }
        }];
    
        if (urls) {
            NSNumber* widthNb = dict[@"width"];
            NSNumber* heightNb = dict[@"height"];
    
            Photo* photo = [[Photo alloc] initWithUrls:urls width:[widthNb intValue] height:[heightNb intValue]];
            [photos addObject:photo];
        }
    }
    
    return photos;
}

@end
