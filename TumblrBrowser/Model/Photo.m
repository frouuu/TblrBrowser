//
//  Photo.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (id)initWithUrls:(NSDictionary*)urls width:(NSUInteger)width height:(NSUInteger)height {
    if (self = [super init]) {
        _urlsBySize = urls;
        _width = width;
        _height = height;
        
        return self;
    }
    
    return nil;
}

@end
