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

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PostView* postView = [PostViewFactory createViewWithFrame:self.view.bounds post:self.post];
    [self.scrollView addSubview:postView];

    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(postView.frame), CGRectGetHeight(postView.frame));
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
