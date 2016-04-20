//
//  ThirdViewController.m
//  PetLife
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@property (nonatomic,strong)UISearchBar *searchBar;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) NSMutableArray *showData;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.600 alpha:1.000];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 68, self.view.frame.size.width, 30)];

    [self.view addSubview:self.searchBar];

    [self.view endEditing:YES];
    

    for (UIView *subview in _searchBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_showData count]>0?[_showData count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    if (_showData != nil && _showData.count >0) {
        NSUInteger row = [indexPath row];
        cell.textLabel.text = [_showData objectAtIndex:row];
    }
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
{
    NSLog(@"%ld",[_dataList count]);
    if (searchText!=nil && searchText.length>0) {
        self.showData= [NSMutableArray array];
        for (NSString *tempStr in _dataList) {
            if ([tempStr rangeOfString:searchText options:NSCaseInsensitiveSearch].length >0 ) {
                [_showData addObject:tempStr];
                NSLog(@"%ld",[_showData count]);
            }
        }
        [_tableView reloadData];
    }
    else
    {
        self.showData = [NSMutableArray arrayWithArray:_dataList];
        [_tableView reloadData];
    }
    
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchBar:self.searchBar textDidChange:nil];
    [_searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self searchBar:self.searchBar textDidChange:nil];
    [_searchBar resignFirstResponder];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
