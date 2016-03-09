//
//  TextPostView.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "RegularPostView.h"
#import <UIKit/UIKit.h>

#import "Post.h"

@interface RegularPostView ()

@property (nonatomic, strong) NSLayoutConstraint* heightConstraint;

@end

@implementation RegularPostView

- (void)configureWithPost:(Post*)post {
    UITextView* textView = [[UITextView alloc] initWithFrame:self.bounds];
    NSData* htmlData = [post.regularBody dataUsingEncoding:NSUnicodeStringEncoding];
    
    NSAttributedString* attrString = [[NSAttributedString alloc] initWithData:htmlData
                                                                            options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                                 documentAttributes:nil
                                                                        error:nil];
    textView.attributedText = attrString;
    textView.editable = NO;
    
    //CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)];
    
    [self addSubview:textView];
}

@end
