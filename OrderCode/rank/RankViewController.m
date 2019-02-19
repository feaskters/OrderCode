//
//  RankViewController.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/14.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "RankViewController.h"
#import "../db/UserDb.h"
#import "RankTableViewCell.h"

@interface RankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *rankTableView;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (nonatomic) NSArray *infoArray;
@end

@implementation RankViewController

//懒加载infoArray
- (NSArray *)infoArray{
    if (_infoArray == nil) {
        UserDb *db = [UserDb sharedUserDb];
        _infoArray = [db SelectCompetition];
    }
    return _infoArray;
}

-(void)changeInfoArrayWithType:(NSString *)type {
    UserDb *db = [UserDb sharedUserDb];
    if ([type isEqualToString:@"competition"]) {
        self.infoArray = [db SelectCompetition];
        [self.rankTableView reloadData];
    }else if([type isEqualToString:@"puzzle"]){
        self.infoArray = [db SelectPuzzle];
        [self.rankTableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rankTableView.delegate = self;
    self.rankTableView.dataSource = self;
    self.rankTableView.backgroundColor = nil;
    [self.rankTableView registerClass:[RankTableViewCell classForCoder] forCellReuseIdentifier:@"rankCell"];
}

//改变排行
- (IBAction)changeRank:(UIButton *)sender {
    //英文
    if ([self.title_label.text isEqualToString:@"competition>"]) {
        self.title_label.text = @"<puzzle";
        [self changeInfoArrayWithType:@"puzzle"];
    }else if ([self.title_label.text isEqualToString:@"<puzzle"]) {
        self.title_label.text = @"competition>";
        [self changeInfoArrayWithType:@"competition"];
    }
    //中文
    if ([self.title_label.text isEqualToString:@"竞赛模式>"]) {
        self.title_label.text = @"<解谜模式";
        [self changeInfoArrayWithType:@"puzzle"];
    }else if ([self.title_label.text isEqualToString:@"<解谜模式"]) {
        self.title_label.text = @"竞赛模式>";
        [self changeInfoArrayWithType:@"competition"];
    }
}

//返回
- (IBAction)back:(UIButton *)sender {
    [_musicPlay_yx play];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark tableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rankCell"];
    cell = [RankTableViewCell rankTableViewCell];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:indexPath.row + 1],@"rank",[self.infoArray[indexPath.row] valueForKey:@"name"],@"name",[self.infoArray[indexPath.row] valueForKey:@"score"],@"score", nil];
    cell.rankInfo = dic;
    return cell;
}

#pragma prepare data from database

@end
