//
//  BasicTableViewCell.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/7/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;

- (void)configureWithData:(NSDictionary*)postData;

@end
