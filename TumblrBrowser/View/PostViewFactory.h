//
//  PostViewFactory.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Post;
@class PostView;

@interface PostViewFactory : NSObject

+ (PostView*)createViewWithFrame:(CGRect)frame post:(Post*)post;

@end
