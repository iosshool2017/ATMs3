//
//  ViewController.m
//  ATMMap
//
//  Created by Admin on 10.05.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ATMTableViewController.h"
#import "ATMMapViewController.h"
#import "CustomAnnotation.h"
#import "ATMList.h"

@interface ATMTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, copy) NSArray *mapAnnotations;

@end

@implementation ATMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=UIColor.greenColor;
    self.title=@"ATMList";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [UITableView new];
    CGRect bounds = self.view.bounds;
    double root_width = bounds.size.width;
    double root_hight = bounds.size.height;
    
    self.tableView.frame = CGRectMake(0, 0, root_width, root_hight);
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;

    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
       
    
    [self.view addSubview:self.tableView];
    
    ATMList *list = [[ATMList alloc] init];
    
    CLLocationDegrees lat=37.770;
    CLLocationDegrees lng=-122.4709;

    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:lat longitude:lng] ;
    
    __weak typeof(self) weakself = self;
    [list downloadItems:location withCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.mapAnnotations = [list getAnnotations];
            [weakself.tableView reloadData];
        });
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  10;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    CustomAnnotation *item=self.mapAnnotations[indexPath.row];
    cell.textLabel.text=item.title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.tabBarController.selectedIndex=0;
    ATMMapViewController *mc=self.tabBarController.selectedViewController;
    [mc  setCenter:indexPath.row];
}



@end
