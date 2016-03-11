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

#import "TumblrHelper.h"

#define kPhotoSize @"400"

@interface PhotoPostView ()

- (NSArray*)verticalConstraintWithImageViews:(NSArray*)imgViews margin:(CGFloat)margin;

@end


@implementation PhotoPostView

- (void)configureWithPost:(Post*)post margins:(CGFloat)margin {
    NSMutableDictionary* imgViewsMutableDict = [NSMutableDictionary dictionary];
    NSMutableArray* imgViews = [NSMutableArray array];
    
    if ([post.photos count] == 0)
        return;
    
    CGFloat yOffset = 0.0;
    
    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat fullHeight = [TumblrHelper photosHeightWithPost:post width:frameWidth margin:margin];
    
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame),
                              CGRectGetMinY(self.frame),
                              CGRectGetWidth(self.frame),
                              fullHeight)];
    
    for  (Photo* photo in post.photos) {
        // image view size        
        CGFloat width = [TumblrHelper widthWithPhoto:photo forMaxWidth:frameWidth];
        CGFloat height = [TumblrHelper heightWithPhoto:photo forWidth:width];
                
        UIImageView* imageView = [[UIImageView alloc] init];
        
        NSURL* url = [photo.urlsBySize objectForKey:kPhotoSize];
        // for downloading
        [imgViewsMutableDict setObject:imageView forKey:[url absoluteString]];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:imageView];
        
        [imgViews addObject:imageView];
        
        yOffset += height + margin;
        
        // Autolayout
        // Fit the parent view width constraint
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(imageView)]];
        // height ratio to parent
        NSLayoutConstraint* ratioHeightConstraint =[NSLayoutConstraint constraintWithItem:imageView
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeHeight
                                                                               multiplier:height/fullHeight
                                                                                 constant:0.0];
        ratioHeightConstraint.priority = 900;
        [self addConstraint:ratioHeightConstraint];
    }
    
    self.imageViewsByUrls = imgViewsMutableDict;
    
    if ([imgViews count] > 1)
        [self addConstraints:[self verticalConstraintWithImageViews:imgViews margin:margin]];
}

- (NSArray*)verticalConstraintWithImageViews:(NSArray*)imgViews margin:(CGFloat)margin {    
    NSMutableDictionary* views = [NSMutableDictionary dictionary];
    NSMutableString* verticalVisualFormat = [NSMutableString stringWithString:@"V:|"];
    
    int i = 0;
    for (UIImageView* imgView in imgViews) {
        NSString* key = [NSString stringWithFormat:@"img%d", i++];
        
        [verticalVisualFormat appendString:[NSString stringWithFormat:@"[%@]-%d-", key, (int)margin]];
      
        views[key] = imgView;
    }
    
    [verticalVisualFormat appendString:@"|"];
    
    return [NSLayoutConstraint constraintsWithVisualFormat:verticalVisualFormat
                                                   options:0
                                                   metrics:nil
                                                     views:views];
}

@end
