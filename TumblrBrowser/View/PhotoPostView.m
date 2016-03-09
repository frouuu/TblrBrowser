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
#define kLabelHeight 20.0
#define kPhotoSize @"400" // medium size photo

@implementation PhotoPostView

- (void)configureWithPost:(Post*)post {
    if ([post.photos count] == 0)
        return;
    
    CGFloat yOffset = 0.0;
    
    for  (Photo* photo in post.photos) {
        // image view size
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        NSUInteger width = photo.width > frameWidth ? frameWidth : photo.width;
        CGFloat height = (CGFloat)width*photo.height/photo.width;
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, yOffset, width, height)];
    
        NSURL* photoUrl = [photo.urlsBySize objectForKey:kPhotoSize];
        NSData *imgData = [NSData dataWithContentsOfURL:photoUrl];
        imageView.image = [UIImage imageWithData:imgData];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:imageView];
        
        yOffset += height + kMargin;
    }
    
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame),
                              CGRectGetMinY(self.frame),
                              CGRectGetWidth(self.frame),
                              yOffset)];
}


@end
