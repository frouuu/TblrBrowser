//
//  Helper.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/11/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class Post;
@class Photo;


@interface TumblrHelper : NSObject

+ (CGFloat)photosHeightWithPost:(Post*)post width:(CGFloat)frameWidth margin:(CGFloat)margin;
+ (CGFloat)heightWithPhoto:(Photo*)photo forWidth:(CGFloat)width;
+ (CGFloat)widthWithPhoto:(Photo*)photo forMaxWidth:(CGFloat)maxWidth;

@end
