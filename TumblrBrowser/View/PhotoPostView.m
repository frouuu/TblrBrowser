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

@implementation PhotoPostView

- (void)configureWithPost:(Post*)post {
    if ([post.photos count] == 0)
        return;
    
    CGFloat offset = 0.0;
    
    for  (Photo* photo in post.photos) {
        NSUInteger width = photo.width > 400 ? 400 : photo.width;
        CGFloat ratioWH = photo.width/photo.height;
        CGFloat height = width/ratioWH;
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, offset, width, height)];
    
        NSData *imgData = [NSData dataWithContentsOfURL:[photo.urlsBySize objectForKey:@"400"]];
        
        imageView.image = [UIImage imageWithData:imgData];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:imageView];
        
        offset += height + kMargin;
    }
    
    UILabel* captionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, offset, CGRectGetWidth(self.bounds), kLabelHeight)];
    
    [self addSubview:captionLabel];
    
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), offset + kLabelHeight)];
}


@end
