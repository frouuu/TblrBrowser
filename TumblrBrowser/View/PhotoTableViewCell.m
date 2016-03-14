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
    NSString* caption = [TumblrHelper stringByStrippingHTML:post.photoCaption];
    caption = [TumblrHelper replaceHtmlEntities:caption];
    self.captionLabel.text = caption;
    
    // photos
    PhotoPostView* contentView = [[PhotoPostView alloc] initWithFrame:self.photosPlaceholderView.bounds];
    [contentView configureWithPost:self.post margins:kPhotoMargin];
    
    [self.photosPlaceholderView addSubview:contentView];
    
    self.photoPostView = contentView;
    
    
    // Autolayout constraints
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // photo content fit width and height
    [self.photosPlaceholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|"
                                                                 options:0 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(contentView)]];
    
    [self.photosPlaceholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|"
                                                                 options:0 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(contentView)]];
    
    CGFloat ratio = CGRectGetHeight(contentView.frame)/CGRectGetWidth(contentView.frame);
    NSLayoutConstraint* ratioConstraint =[NSLayoutConstraint constraintWithItem:contentView
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:contentView
                                                                            attribute:NSLayoutAttributeWidth
                                                                           multiplier:ratio
                                                                             constant:0.0];
    ratioConstraint.priority = 900;
    [self.photosPlaceholderView addConstraint:ratioConstraint];
}


@end
