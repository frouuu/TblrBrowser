//
//  BasicTableViewCell.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/7/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "BasicTableViewCell.h"

@implementation BasicTableViewCell

- (void)configureWithData:(NSDictionary*)postData {
    self.tagsLabel.text = [postData objectForKey:@"format"];
}

@end
