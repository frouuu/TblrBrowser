//
//  RegularTableViewCell.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/9/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "TextTableViewCell.h"

#import "Post.h"

@implementation TextTableViewCell

- (void)configureWithPost:(Post*)post {
    [super configureWithPost:post];
    
    if ([post.type isEqualToString:@"regular"]) {
        self.contentLabel.text = [self stringByStrippingHTML:post.regularBody];
    }
    else if ([post.type isEqualToString:@"quote"]) {
        self.contentLabel.text = [self stringByStrippingHTML:post.quoteText];
    }
    else {
        self.contentLabel.text = post.type;
    }
}


@end
