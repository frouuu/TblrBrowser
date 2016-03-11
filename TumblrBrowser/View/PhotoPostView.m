//
//  PhotoPostView.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "PhotoPostView.h"

#import "Post.h"
#import "Photo.h"

#define kMargin 2.0
#define kPhotoSize @"400"

@implementation PhotoPostView

- (void)configureWithPost:(Post*)post {
    NSMutableDictionary* imgViewsMutableDict = [NSMutableDictionary dictionary];
    
    if ([post.photos count] == 0)
        return;
    
    CGFloat yOffset = 0.0;
    
    for  (Photo* photo in post.photos) {
        // image view size
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        CGFloat width = photo.width > frameWidth ? frameWidth : photo.width;
        CGFloat height = (CGFloat)width*photo.height/photo.width;
        
        if (width == 0 || height == 0) { // for some photos there's no width and height in json
            width = 200.0;
            height = 200.0;
        }
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, yOffset, width, height)];
        NSURL* url = [photo.urlsBySize objectForKey:kPhotoSize];
        
        // for downloading
        [imgViewsMutableDict setObject:imageView forKey:[url absoluteString]];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:imageView];
        
        yOffset += height + kMargin;
    }
    
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame),
                              CGRectGetMinY(self.frame),
                              CGRectGetWidth(self.frame),
                              yOffset)];
    
    self.imageViewsByUrls = imgViewsMutableDict;
}


@end
