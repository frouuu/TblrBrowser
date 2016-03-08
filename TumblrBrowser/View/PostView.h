//
//  PostView.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Post;

@interface PostView : UIView

- (void)configureWithPost:(Post*)post;

@end
