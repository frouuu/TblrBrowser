//
//  TableViewController.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/7/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "TableViewController.h"

#import "TextTableViewCell.h"
#import "PhotoTableViewCell.h"

#import "Post.h"


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kBlogFormatString @"http://%@.tumblr.com/api/read/json?start=0&num=10"
#define kDefaultBlog @"rafgraphics"

@interface TableViewController ()

- (NSURL*)blogUrlWithUser:(NSString*)userName;
- (void)fetchedData:(NSData *)responseData;

@end


@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 150.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.searchBar.delegate = self;
    
    [self searchBlog:kDefaultBlog];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post* post = [self.posts objectAtIndex:indexPath.row];
    BasicTableViewCell* cell;
    
    if ([post.type isEqualToString:@"photo"]) {
        NSString* cellIdentifier = @"PhotoCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[PhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:cellIdentifier];
        }
    }
    else {
        NSString* cellIdentifier = @"TextCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:cellIdentifier];
        }
    }
    
    if (cell.post != post) {
        [cell configureWithPost:post];
    }
    
    return cell;
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length != 0 ) {
        [self searchBlog:searchBar.text];
    }
    
    [searchBar resignFirstResponder];
}


#pragma mark -

- (NSURL*)blogUrlWithUser:(NSString*)userName {
    NSString* blogString = [NSString stringWithFormat:kBlogFormatString, userName];
    
    return [NSURL URLWithString:blogString];
}


- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    
    // responseData is not JSON, there is some javascript "var tumblr_api_read = " at the beginning and ";" at the end
    NSMutableString *str = [[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    [str deleteCharactersInRange:NSMakeRange(0, 22)];
    [str deleteCharactersInRange:NSMakeRange([str length]-1, 1)];
    NSData* dataWithoutJavascript = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:dataWithoutJavascript
                          options:NSJSONReadingAllowFragments
                          error:&error];
    
    NSMutableArray* mutablePosts = [NSMutableArray array];
    for (NSDictionary* postData in [json objectForKey:@"posts"]) {
        [mutablePosts addObject:[[Post alloc] initWithDictionary:postData]];
    }
    self.posts = [mutablePosts copy];
    
    [self.tableView reloadData];
}


- (void)searchBlog:(NSString*)blogName {
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:[self blogUrlWithUser:blogName]];
        
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data
                            waitUntilDone:YES];
    });
}


@end
