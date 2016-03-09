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
    
    while ([self.photosView.subviews count] > 0) {
        [[self.photosView.subviews lastObject] removeFromSuperview];
    }
    
    PostView* contentView = [[PhotoPostView alloc] initWithFrame:self.photosView.bounds];
    [contentView configureWithPost:self.post];
    
    if (contentView == nil)
        return;
    
    [self.photosView addSubview:contentView];
    
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

    self.captionLabel.text = [self stringByStrippingHTML:post.photoCaption];
}

@end
