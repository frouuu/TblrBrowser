//
//  Photo.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSDictionary* urlsBySize;
@property (nonatomic) NSUInteger width;
@property (nonatomic) NSUInteger height;

- (id)initWithUrls:(NSDictionary*)urls width:(NSUInteger)width height:(NSUInteger)height;

@end
