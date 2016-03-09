//
//  DetailsViewController.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "DetailsViewController.h"

#import "PostViewFactory.h"
#import "PostView.h"


@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PostView* postView = [PostViewFactory createViewWithFrame:self.view.bounds post:self.post];
    [self.scrollView addSubview:postView];

    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(postView.frame),
                                             CGRectGetHeight(postView.frame));
}

@end
