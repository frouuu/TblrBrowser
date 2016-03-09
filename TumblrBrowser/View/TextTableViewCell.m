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
    
    // post with title and text
    if ([post.type isEqualToString:@"regular"]) {
        self.contentLabel.text = [self stringByStrippingHTML:post.regularBody];
        self.titleLabel.text = [self stringByStrippingHTML:post.regularTitle];
    }
    // quote with text and source
    else if ([post.type isEqualToString:@"quote"]) {
        self.contentLabel.text = [self stringByStrippingHTML:post.quoteSource];
        self.titleLabel.text = [self stringByStrippingHTML:post.quoteText];
    }
    else {
        self.titleLabel.text = post.type;
        self.contentLabel.text = @"...";
    }
}


@end
