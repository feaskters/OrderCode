//
//  RankTableViewCell.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/14.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "RankTableViewCell.h"

@interface RankTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *rank;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *score;


@end

@implementation RankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(instancetype)rankTableViewCell{
    return [[NSBundle mainBundle]loadNibNamed:@"rankTableViewCell" owner:nil options:nil][0];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = nil;
    self.contentView.backgroundColor = nil;
    self.rank.text = [NSString stringWithFormat:@"%@", self.rankInfo[@"rank"] ];
    self.name.text = self.rankInfo[@"name"];
    self.score.text = [NSString stringWithFormat:@"%@", self.rankInfo[@"score"]];
}

@end
