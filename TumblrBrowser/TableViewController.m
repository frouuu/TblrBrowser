//
//  TableViewController.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/7/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "TableViewController.h"

#import "DetailsViewController.h"
#import "BasicTableViewCell.h"
#import "Post.h"


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kBlogFormatString @"http://%@.tumblr.com/api/read/json?start=0&num=10"


@interface TableViewController ()

- (NSURL*)blogUrlWithUser:(NSString*)userName;
- (void)fetchedData:(NSData *)responseData;

@end


@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 150.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:[self blogUrlWithUser:@"instagram"]];
        
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data
                            waitUntilDone:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BasicCell";
    
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[BasicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    [cell configureWithPost:(Post*)[self.posts objectAtIndex:indexPath.row]];
    
    return cell;
}


/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}*/


#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     BasicTableViewCell* cell = (BasicTableViewCell*)sender;
     
     DetailsViewController* detailsViewController = segue.destinationViewController;
     detailsViewController.post = cell.post;
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


@end
