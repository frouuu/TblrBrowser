//
//  PhotoPostView.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "PostView.h"

@interface PhotoPostView : UIView

@property (nonatomic, strong) NSDictionary* imageViewsByUrls;

- (void)configureWithPost:(Post*)post margins:(CGFloat)margin;

@end
