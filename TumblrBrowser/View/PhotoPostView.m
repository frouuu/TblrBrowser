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

@implementation PhotoPostView

- (void)configureWithPost:(Post*)post {
    if ([post.photos count] == 0)
        return;
    
    Photo* photo = [post.photos objectAtIndex:0];
    
    NSUInteger width = photo.width > CGRectGetWidth(self.bounds) ? CGRectGetWidth(self.bounds) : photo.width;
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, CGRectGetHeight(self.bounds))];
    NSData *imgData = [NSData dataWithContentsOfURL:photo.url];
        
    imageView.image = [UIImage imageWithData:imgData];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    [self addSubview:imageView];
}


@end
