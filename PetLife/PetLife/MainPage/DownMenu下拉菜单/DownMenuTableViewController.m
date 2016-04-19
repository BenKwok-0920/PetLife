//
//  DownMenu.m
//  PetLife
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "DownMenuTableViewController.h"

@interface DownMenuTableViewController ()

@end

@implementation DownMenuTableViewController


- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"1";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"2";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"3";
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"4";
    }else if (indexPath.row == 4) {
        cell.textLabel.text = @"5";
    }


    return cell;
}






@end
