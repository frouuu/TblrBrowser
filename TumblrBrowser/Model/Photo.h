//
//  Photo.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSURL* url;
@property (nonatomic) NSUInteger width;

- (id)initWithUrl:(NSURL*)url andWidth:(NSUInteger)width;

@end
