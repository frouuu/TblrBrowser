//
//  DetailsViewController.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Post;

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Post* post;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
