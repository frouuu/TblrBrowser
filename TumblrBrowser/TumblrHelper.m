//
//  Helper.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/11/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "TumblrHelper.h"

#import "Post.h"
#import "Photo.h"


@implementation TumblrHelper

+ (CGFloat)photosHeightWithPost:(Post*)post width:(CGFloat)frameWidth margin:(CGFloat)margin {
    CGFloat returnValue = 0.0;
    
    for  (Photo* photo in post.photos) {
        CGFloat width = [self widthWithPhoto:photo forMaxWidth:frameWidth];
        CGFloat height = [[self class] heightWithPhoto:photo
                                              forWidth:width];
        
        returnValue += height + margin;
    }
    
    if (returnValue > margin) { // remove last margin
        returnValue -= margin;
    }

    return returnValue;
}

+ (CGFloat)heightWithPhoto:(Photo*)photo forWidth:(CGFloat)width {
    if (photo.width && photo.height) {
        return (CGFloat)width*photo.height/photo.width;
    }
    else if (photo.height) {
        return (CGFloat)photo.height;
    }
    return width; // if there's no width and height
}

+ (CGFloat)widthWithPhoto:(Photo*)photo forMaxWidth:(CGFloat)maxWidth {
    CGFloat photoWidth = photo.width ? photo.width : 200.0; // for some photos there's no width and height in json
    
    return photoWidth > maxWidth ? maxWidth : photoWidth;
}

@end
