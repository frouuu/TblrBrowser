//
//  Post.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/8/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (nonatomic) NSUInteger postId;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSArray* tags;
@property  (nonatomic, strong) NSString* regularBody;
@property  (nonatomic, strong) NSString* regularTitle;
@property  (nonatomic, strong) NSString* quoteText;
@property  (nonatomic, strong) NSString* quoteSource;
@property  (nonatomic, strong) NSString* photoCaption;
@property  (nonatomic, strong) NSArray* photos;

- (id)initWithDictionary:(NSDictionary*)dict;

@end
