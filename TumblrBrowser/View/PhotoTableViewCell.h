//
//  PhotoTableViewCell.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/9/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BasicTableViewCell.h"


@interface PhotoTableViewCell : BasicTableViewCell

@property (weak, nonatomic) IBOutlet UIView* photosView;
@property (weak, nonatomic) IBOutlet UILabel* captionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photosHeightConstraint;

@end