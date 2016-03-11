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

#import "TumblrHelper.h"

#define kPhotoMargin 2.0

@implementation PhotoTableViewCell

- (void)configureWithPost:(Post*)post {
    [super configureWithPost:post];
    
    // some cleaning
    while ([self.photosPlaceholderView.subviews count] > 0) {
        [[self.photosPlaceholderView.subviews lastObject] removeFromSuperview];
    }
    
    // photo caption
    self.captionLabel.text = [self stringByStrippingHTML:post.photoCaption];
    
    // photos
    PhotoPostView* contentView = [[PhotoPostView alloc] initWithFrame:self.photosPlaceholderView.bounds];
    [contentView configureWithPost:self.post margins:kPhotoMargin];
    
    [self.photosPlaceholderView addSubview:contentView];
    
    self.photoPostView = contentView;
    
    CGFloat frameWidth = CGRectGetWidth(self.photosPlaceholderView.frame);
    
    // change height constraint for photosPlaceholderView
    CGFloat photosHeight = [TumblrHelper photosHeightWithPost:self.post
                                                        width:frameWidth
                                                       margin:kPhotoMargin];
    
    self.photosHeightConstraint.active = NO;
    
    self.photosHeightConstraint = [NSLayoutConstraint constraintWithItem:self.photosPlaceholderView
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:photosHeight];
    
    self.photosHeightConstraint.priority = 999;
    [self.photosPlaceholderView addConstraint:self.photosHeightConstraint];
}


@end
