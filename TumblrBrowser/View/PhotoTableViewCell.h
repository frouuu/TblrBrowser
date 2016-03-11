//
//  PhotoTableViewCell.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/9/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BasicTableViewCell.h"

@class PhotoPostView;

@interface PhotoTableViewCell : BasicTableViewCell

@property (strong, nonatomic) PhotoPostView* photoPostView;

@property (weak, nonatomic) IBOutlet UIView* photosPlaceholderView;
@property (weak, nonatomic) IBOutlet UILabel* captionLabel;

@end
