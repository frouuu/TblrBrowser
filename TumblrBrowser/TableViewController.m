//
//  TableViewController.m
//  TumblrBrowser
//
//  Created by Magdalena Łazarecka on 3/7/16.
//  Copyright © 2016 Magdalena Łazarecka. All rights reserved.
//

#import "TableViewController.h"
#import "BasicTableViewCell.h"


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kBlogFormatString @"http://%@.tumblr.com/api/read/json?start=0&num=5"


@interface TableViewController ()

- (NSURL*)blogUrlWithUser:(NSString*)userName;
- (void)fetchedData:(NSData *)responseData;

@end


@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:[self blogUrlWithUser:@"demo"]];
        
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
    
    [cell configureWithData:[self.posts objectAtIndex:indexPath.row]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    
    self.posts = [json objectForKey:@"posts"];
    
    [self.tableView reloadData];
}


@end
