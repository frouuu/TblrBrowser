//
//  RegularTableViewCell.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/9/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "TextTableViewCell.h"

#import "Post.h"

#import "TumblrHelper.h"

@implementation TextTableViewCell

- (void)configureWithPost:(Post*)post {
    [super configureWithPost:post];
    
    // post with title and text
    if ([post.type isEqualToString:@"regular"]) {
        NSString* body = [TumblrHelper stringByStrippingHTML:post.regularBody];
        body = [TumblrHelper replaceHtmlEntities:body];
        
        self.contentLabel.text = body;
        
        NSString* title = [TumblrHelper stringByStrippingHTML:post.regularTitle];
        title = [TumblrHelper replaceHtmlEntities:title];
        
        self.titleLabel.text = title;
    }
    // quote with text and source
    else if ([post.type isEqualToString:@"quote"]) {
        NSString* text = [TumblrHelper stringByStrippingHTML:post.quoteText];
        text = [TumblrHelper replaceHtmlEntities:text];
        
        self.titleLabel.text = text;
        
        NSString* source = [TumblrHelper stringByStrippingHTML:post.quoteSource];
        source = [TumblrHelper replaceHtmlEntities:source];
        self.contentLabel.text = source;
    }
    else {
        self.titleLabel.text = post.type;
        self.contentLabel.text = @"...";
    }
}


@end
