//
//  PhotoTableViewCell.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/9/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "PhotoTableViewCell.h"

#import "Post.h"
#import "PostView.h"
#import "PhotoPostView.h"


@implementation PhotoTableViewCell

- (void)configureWithPost:(Post*)post {
    [super configureWithPost:post];
    
    // some cleaning
    while ([self.photosView.subviews count] > 0) {
        [[self.photosView.subviews lastObject] removeFromSuperview];
    }
    
    // photo caption
    self.captionLabel.text = [self stringByStrippingHTML:post.photoCaption];
    
    // photos
    PhotoPostView* contentView = [[PhotoPostView alloc] initWithFrame:self.photosView.bounds];
    [contentView configureWithPost:self.post];
    
    [self.photosView addSubview:contentView];
    
    // change height constraint for photosView
    CGFloat photosHeight = CGRectGetHeight(contentView.frame);
    
    [self.photosView removeConstraint:self.photosHeightConstraint];
    self.photosHeightConstraint = [NSLayoutConstraint constraintWithItem:self.photosView
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:photosHeight];
    
    [self.photosView addConstraint:self.photosHeightConstraint];
}

@end
