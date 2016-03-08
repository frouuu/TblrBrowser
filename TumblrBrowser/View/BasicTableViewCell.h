//
//  BasicTableViewCell.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/7/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Post;


@interface BasicTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UIView *postContentView;
@property (strong, nonatomic) Post *post;

- (void)configureWithPost:(Post*)post;

@end
