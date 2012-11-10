//
//  ListCategoriesOfSource.m
//  Ezine
//
//  Created by PDG2 on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListCategoriesOfSource.h"
#import "CategoryCell.h"
#import "EzineAppDelegate.h"

@implementation ListCategoriesOfSource
@synthesize delegate;
@synthesize listCategories = listCategories_;
@synthesize _idSite;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(300.0,450.0);
    self.title=@"Danh mục";
    [XAppDelegate.serviceEngine getChangeFromSite:self._idSite onCompletion:^(NSMutableArray* data) {
        [self fetchedData:data];
        
    } onError:^(NSError* error) {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not connect to service" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
//        [alert show];
//        [alert release];
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
       [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.listCategories count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CategoryCell";
    
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObject=[[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:self options:nil];
		for (id currentObject in topLevelObject) {
			
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell=(CategoryCell*)currentObject;
				break;
            }
        }  
    }
    NSDictionary *data=[self.listCategories objectAtIndex:indexPath.row];
    [cell setData:data];
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        CategoryCell *monster = (CategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
        CategoryModel *model=[[CategoryModel alloc] init];
        model.sourceId=monster.tag;
        model.title=monster.titleLabel.text;
        NSLog(@"chanle id===%d",monster.tag);
        [self.delegate categorySelectionChanged:model];
    }
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    self.listCategories = nil;
    self.delegate = nil;
    [super dealloc];
}

#pragma mark---
-(void)fetchedData:(NSMutableArray*)data{
    NSLog(@"change Site==%@",data);
    self.listCategories=[[NSMutableArray alloc] init];
    self.listCategories=[data copy];
    [self.tableView reloadData];
}
@end
