//
//  PostViewFactory.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "PostViewFactory.h"

#import "Post.h"
#import "RegularPostView.h"
#import "QuotePostView.h"
#import "PhotoPostView.h"

@implementation PostViewFactory

+ (UIView*)createViewWithFrame:(CGRect)frame post:(Post*)post {
    if ([post.type isEqualToString:@"regular"]) {
        RegularPostView* regularPostView = [[RegularPostView alloc] initWithFrame:frame];
        [regularPostView configureWithPost:post];
        
        return regularPostView;
    }
    else if ([post.type isEqualToString:@"quote"]) {
        QuotePostView* quotePostView = [[QuotePostView alloc] initWithFrame:frame];
        [quotePostView configureWithPost:post];
        
        return quotePostView;
    }
    
    else if ([post.type isEqualToString:@"photo"]) {
        PhotoPostView* photoPostView = [[PhotoPostView alloc] initWithFrame:frame];
        [photoPostView configureWithPost:post];
        
        return photoPostView;
    }
    
    return [[PostView alloc] initWithFrame:frame];;
}

@end
