//
//  Photo.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (id)initWithUrl:(NSURL*)url andWidth:(NSUInteger)width {
    if (self = [super init]) {
        _url = url;
        _width = width;
        
        return self;
    }
    
    return nil;
}

@end
