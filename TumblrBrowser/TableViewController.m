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
#import "PhotoPostView.h"

#import "DataParser.h"

#import "Post.h"
#import "Photo.h"

#import "MBProgressHUD.h"


#define kBlogFormatString @"http://%@.tumblr.com/api/read/json?start=0&num=10"
#define kDefaultBlog @"rafgraphics"


@interface TableViewController ()

- (NSURL*)blogUrlWithUser:(NSString*)userName;
- (NSArray*)fetchedData:(NSData *)responseData;
- (void)showProgressIndicator:(BOOL)on;
- (void)showErrorAlertWithTitle:(NSString*)title message:(NSString*)msg;
- (void)downloadImagesForPostView:(PhotoPostView*)photoPostView;

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
    
    // photo posts
    if ([post.type isEqualToString:@"photo"]) {
        NSString* cellIdentifier = @"PhotoCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[PhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:cellIdentifier];
        }
        
        if (cell.post != post) {
            [cell configureWithPost:post];
            [self downloadImagesForPostView:((PhotoTableViewCell*)cell).photoPostView];
        }
    }
    // other posts
    else {
        NSString* cellIdentifier = @"TextCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:cellIdentifier];
        }
        
        if (cell.post != post) {
            [cell configureWithPost:post];
        }
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


- (NSArray*)fetchedData:(NSData *)responseData {
    NSError* error = nil;
    
    NSArray* postArray = [DataParser postArrayWithData:responseData error:&error];
    
    if (error) {
        [self showErrorAlertWithTitle:@"Error" message:error.localizedDescription];
        return nil;
    }
    else {
        return postArray;
    }
}


- (void)searchBlog:(NSString*)blogName {
    [self showProgressIndicator:YES];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:[self blogUrlWithUser:blogName]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!error) {
                        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                        if (httpResp.statusCode == 200) {
                            self.posts = [self fetchedData:data];
                            [self.tableView reloadData];
                        }
                        else if (httpResp.statusCode == 404) {
                            [self showErrorAlertWithTitle:@"Error"
                                                  message:@"User not found."];
                        }
                        else {
                            [self showErrorAlertWithTitle:@"Error"
                                                  message:@"Please try again."];
                        }
                    }
                    else {
                        // error
                        [self showErrorAlertWithTitle:@"Error"
                                              message:error.localizedDescription];
                        }
                
                    [self showProgressIndicator:NO];
                });
            }] resume];
}


- (void)showProgressIndicator:(BOOL)on {
    if (on) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = on;
}


- (void)showErrorAlertWithTitle:(NSString*)title message:(NSString*)msg {
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:title
                                                       message:msg
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    [theAlert show];
}


// download post images
- (void)downloadImagesForPostView:(PhotoPostView*)photoPostView {
    NSURLSession *session = [NSURLSession sharedSession];
    
    for (NSString* urlString in photoPostView.imageViewsByUrls) {
        [[session dataTaskWithURL:[NSURL URLWithString:urlString]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!error) {
                        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                        
                        if (httpResp.statusCode == 200) {
                            UIImageView* imageView = [photoPostView.imageViewsByUrls objectForKey:urlString];
                            imageView.image = [UIImage imageWithData:data];
                        }
                        
                    }
                });
            }] resume];
    }
}

@end
