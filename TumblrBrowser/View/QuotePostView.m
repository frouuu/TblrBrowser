//
//  QuotePostView.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "QuotePostView.h"
#import <UIKit/UIKit.h>

#import "Post.h"


@implementation QuotePostView

- (void)configureWithPost:(Post*)post {
    UITextView* textView = [[UITextView alloc] initWithFrame:self.bounds];
    NSData* htmlData = [post.quoteText dataUsingEncoding:NSUnicodeStringEncoding];
    
    NSAttributedString* attrString = [[NSAttributedString alloc] initWithData:htmlData
                                                                      options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                           documentAttributes:nil
                                                                        error:nil];
    textView.attributedText = attrString;
    textView.editable = NO;
    
    [self addSubview:textView];
}

@end
