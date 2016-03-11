//
//  DataParser.h
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/11/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataParser : NSObject

+ (NSArray*)postArrayWithData:(NSData*)data error:(NSError**)error;

@end
