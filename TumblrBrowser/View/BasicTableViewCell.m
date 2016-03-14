//
//  BasicTableViewCell.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/7/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "BasicTableViewCell.h"

#import "Post.h"


@interface BasicTableViewCell ()

- (void)addTags:(NSArray*)tags;

@end


@implementation BasicTableViewCell

- (void)configureWithPost:(Post*)post {
    self.post = post;
    
    [self addTags:post.tags];
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


@end
