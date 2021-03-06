//
//  ListViewController.m
//  MLInputDodger
//
//  Created by molon on 15/7/28.
//  Copyright (c) 2015年 molon. All rights reserved.
//

#import "ListViewController.h"
#import "MLInputDodger.h"

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tapG];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(testPush)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //because `self.automaticallyAdjustsScrollViewInsets==YES` , the contentInset have be set now.
    //when `registerAsDodgeViewForMLInputDodger`,the`originalContentInsetAsDodgeViewForMLInputDodger` would be
    //set with the current cotentInset
    self.tableView.shiftHeightAsDodgeViewForMLInputDodger = 44.0f+5.0f;
    [self.tableView registerAsDodgeViewForMLInputDodger];
}

#pragma mark - event
- (void)tap
{
    [self.view endEditing:YES];
}

- (void)testPush
{
    ListViewController *vc = [ListViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.backgroundColor = [UIColor lightGrayColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - layout
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame),400);
}

#pragma mark - tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectInset(cell.bounds, 5, 5)];
        textFiled.backgroundColor = [UIColor colorWithWhite:0.763 alpha:1.000];
        textFiled.tag = 100;
        [cell.contentView addSubview:textFiled];
    }
    
    UITextField *textFiled = (UITextField *)[cell.contentView viewWithTag:100];
    textFiled.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}


@end
