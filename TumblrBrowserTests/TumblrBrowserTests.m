//
//  TumblrBrowserTests.m
//  TumblrBrowserTests
//
//  Created by Magdalena Łazarecka on 3/7/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Post.h"
#import "Photo.h"

#import "TumblrHelper.h"
#import "DataParser.h"

@interface TumblrBrowserTests : XCTestCase

@end

@implementation TumblrBrowserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPhotosHeight {
    Post* testPost = [[Post alloc] init];
    testPost.type = @"photo";
    
    Photo* photo1 = [[Photo alloc] initWithUrls:@{@"400" : @"http://40.media.tumblr.com/6d27fbf55dd0d0c124994b472be3f587/tumblr_o3xmipCfZB1tuvh1oo1_400.jpg"} width:800 height:1200];
    Photo* photo2 = [[Photo alloc] initWithUrls:@{@"400" : @"http://40.media.tumblr.com/6d27fbf55dd0d0c124994b472be3f587/tumblr_o3xmipCfZB1tuvh1oo1_400.jpg"} width:800 height:1200];
    
    testPost.photos = @[photo1, photo2];
    
    CGFloat result = [TumblrHelper photosHeightWithPost:testPost width:400 margin:2];
    
    XCTAssertEqual(result, 1202, @"");
}

- (void)testParsingPhotos {
    NSString* testDataString = @"var tumblr_api_read = {\"tumblelog\":{\"title\":\"Photos\",\"description\":\"\",\"name\":\"frouuu\",\"timezone\":\"US/Eastern\",\"cname\":false,\"feeds\":[]},\"posts-start\":0,\"posts-total\":1,\"posts-type\":false,\"posts\":[{\"id\":\"29492200021\",\"url\":\"http://frouuu.tumblr.com/post/29492200021\",\"url-with-slug\":\"http://frouuu.tumblr.com/post/29492200021\",\"type\":\"photo\",\"date-gmt\":\"2012-08-15 18:19:00 GMT\",\"date\":\"Wed, 15 Aug 2012 14:19:00\",\"bookmarklet\":0,\"mobile\":0,\"feed-item\":\"\",\"from-feed-id\":0,\"unix-timestamp\":1345054740,\"format\":\"html\",\"reblog-key\":\"Nhn8eSSF\",\"slug\":\"\",\"photo-caption\":\"\",\"width\":3108,\"height\":1748,\"photo-url-1280\":\"http://36.media.tumblr.com/tumblr_m8t6wizvOz1re0x7zo1_1280.jpg\",\"photo-url-500\":\"http://41.media.tumblr.com\/tumblr_m8t6wizvOz1re0x7zo1_500.jpg\",\"photo-url-400\":\"http://41.media.tumblr.com\/tumblr_m8t6wizvOz1re0x7zo1_400.jpg\",\"photo-url-250\":\"http://40.media.tumblr.com\/tumblr_m8t6wizvOz1re0x7zo1_250.jpg\",\"photo-url-100\":\"http://36.media.tumblr.com\/tumblr_m8t6wizvOz1re0x7zo1_100.jpg\",\"photo-url-75\":\"http://40.media.tumblr.com\/tumblr_m8t6wizvOz1re0x7zo1_75sq.jpg\",\"photos\":[],\"tags\":[\"horses\",\"summer\",\"grassfield\"]}]};";
    
    NSData* testData = [testDataString dataUsingEncoding:NSUTF8StringEncoding];

    NSError* err = nil;
    NSArray* posts = [DataParser postArrayWithData:testData error:&err];
    
    XCTAssertEqual([posts count], 1, @"");
}

- (void)testPerformanceParsing {
    [self measureBlock:^{
        NSString* testDataString = @"var tumblr_api_read = {\"tumblelog\":{\"title\":\"Photos\",\"description\":\"\",\"name\":\"frouuu\",\"timezone\":\"US/Eastern\",\"cname\":false,\"feeds\":[]},\"posts-start\":0,\"posts-total\":1,\"posts-type\":false,\"posts\":[{\"id\":\"29492200021\",\"url\":\"http://frouuu.tumblr.com/post/29492200021\",\"url-with-slug\":\"http://frouuu.tumblr.com/post/29492200021\",\"type\":\"photo\",\"date-gmt\":\"2012-08-15 18:19:00 GMT\",\"date\":\"Wed, 15 Aug 2012 14:19:00\",\"bookmarklet\":0,\"mobile\":0,\"feed-item\":\"\",\"from-feed-id\":0,\"unix-timestamp\":1345054740,\"format\":\"html\",\"reblog-key\":\"Nhn8eSSF\",\"slug\":\"\",\"photo-caption\":\"\",\"width\":3108,\"height\":1748,\"photo-url-1280\":\"http://36.media.tumblr.com/tumblr_m8t6wizvOz1re0x7zo1_1280.jpg\",\"photo-url-500\":\"http://41.media.tumblr.com\/tumblr_m8t6wizvOz1re0x7zo1_500.jpg\",\"photo-url-400\":\"http://41.media.tumblr.com\/tumblr_m8t6wizvOz1re0x7zo1_400.jpg\",\"photo-url-250\":\"http://40.media.tumblr.com\/tumblr_m8t6wizvOz1re0x7zo1_250.jpg\",\"photo-url-100\":\"http://36.media.tumblr.com\/tumblr_m8t6wizvOz1re0x7zo1_100.jpg\",\"photo-url-75\":\"http://40.media.tumblr.com\/tumblr_m8t6wizvOz1re0x7zo1_75sq.jpg\",\"photos\":[],\"tags\":[\"horses\",\"summer\",\"grassfield\"]}]};";
        
        NSData* testData = [testDataString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError* err = nil;
        NSArray* posts = [DataParser postArrayWithData:testData error:&err];
    }];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
