//
//  SettingDeleteDataView.m
//  Ezine
//
//  Created by MAC on 10/4/12.
//
//

#import "SettingDeleteDataView.h"

@interface SettingDeleteDataView ()

@end

@implementation SettingDeleteDataView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Xoá dữ liệu trả về"];
    _data=[[NSMutableArray alloc] initWithObjects:@"2 ngày",@"5 ngày",@"7 ngày",@"10 ngày",@"15 ngày",@"30 ngày", nil];
    lastcellchoose=nil;
    [self.menutable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_menutable release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMenutable:nil];
    [super viewDidUnload];
}

#pragma mark ====TableViewdelegate=========OK======

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (void)selectCell:(SettingforDownloadCell *)cells {
	[cells setAccessoryType:UITableViewCellAccessoryCheckmark];
	[[cells titleName] setTextColor:[UIColor colorWithRed:0.318 green:0.4 blue:0.569 alpha:1.0]];
}

- (void)deselectCell:(SettingforDownloadCell *)cells {
	[cells setAccessoryType:UITableViewCellAccessoryNone];
	[[cells titleName] setTextColor:[UIColor darkTextColor]];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    int numofRow =0;
    switch (section) {
        case 0:
            numofRow = 1;
            break;
        case 1:
            
            numofRow = [_data count];
            break;
        case 2:
            numofRow=1;
            
        default:
            break;
    }
    return numofRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cell = (SettingforDownloadCell*)[tableView dequeueReusableCellWithIdentifier:@"cellNormal"];
    if (cell==nil) {
        NSArray *topLevelObject=[[NSBundle mainBundle] loadNibNamed:@"SettingforDownloadCell" owner:self options:nil];
        for (id currentObject in topLevelObject) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell=(SettingforDownloadCell*)currentObject;
                [cell.titleName setFont:[UIFont boldSystemFontOfSize:18]];
                break;
            }
        }
        
    }
    if ([indexPath section]==0) {
        [cell.titleName setText:@"Sử dụng wifi khi tải nguồn tin"];
    }else if ([indexPath section]==1){
        [cell.titleName setText:[_data objectAtIndex:indexPath.row]];
    }else if ([indexPath section]==2){
        [cell.titleName setText:@"Xoá toàn bộ dữ liệu trả về"];
    }
    
    [cell.Swcell setHidden:YES];
    return cell;
            
    
    
}
	
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingforDownloadCell *cells=(SettingforDownloadCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self selectCell:cells];
    if (lastcellchoose) {
        [self deselectCell:lastcellchoose];
    }
    lastcellchoose=cells;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section]==1) {
        return 50;
    }else {
        return 47;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 25)];
        [headerView setBackgroundColor:[UIColor clearColor]];
        UILabel *headerLable=[[UILabel alloc] initWithFrame:CGRectZero];
        [headerLable setBackgroundColor:[UIColor clearColor]];
        headerLable.contentMode=UIViewContentModeLeft;
        headerLable.textAlignment=UITextAlignmentLeft;
        headerLable.textColor=[UIColor grayColor];
        [headerLable setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:18]];
        [headerLable setText:@"Lựa chon thời gian"];
        headerLable.frame=CGRectMake(30,3, 300, 25);
        headerLable.numberOfLines=0;
        [headerLable sizeToFit];
        [headerView addSubview:headerLable];
        
        return headerView;

    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 40;
    }
    return 20;
}
@end
