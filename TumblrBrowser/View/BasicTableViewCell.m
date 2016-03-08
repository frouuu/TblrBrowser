//
//  BasicTableViewCell.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/7/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "BasicTableViewCell.h"

#import "Post.h"
#import "PostView.h"
#import "PostViewFactory.h"


@interface BasicTableViewCell ()

- (void)addTags:(NSArray*)tags;
- (void)addContentSpecificForTypeWithPost:(Post*)post;

@end


@implementation BasicTableViewCell

- (void)configureWithPost:(Post*)post {
    [self addTags:post.tags];
    
    [self addContentSpecificForTypeWithPost:post];

}

- (void)addTags:(NSArray*)tags {
    NSMutableString* tagsString = [NSMutableString string];
    
    BOOL firstTag = YES;
    for (NSString* tag in tags) {
        if (!firstTag)
            [tagsString appendString:@", "];
        else {
            firstTag = NO;
            [tagsString appendString:@"Tags: "];
        }
        
        [tagsString appendString:tag];
    }
    self.tagsLabel.text = tagsString;
}

- (void)addContentSpecificForTypeWithPost:(Post*)post {
    PostView* contentView = [PostViewFactory createViewWithFrame:self.postContentView.bounds post:post];
    
    if (contentView == nil)
        return;
    
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.postContentView addSubview:contentView];
    
    [self.postContentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|[contentView]|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(contentView)]];
    [self.postContentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|[contentView]|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(contentView)]];
}

@end
