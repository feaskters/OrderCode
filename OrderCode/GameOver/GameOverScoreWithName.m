//
//  GameOverCompetitionView.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "GameOverScoreWithName.h"
#import "../db/UserDb.h"

@interface GameOverScoreWithName()

@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UILabel *title;


@end

@implementation GameOverScoreWithName

- (void)layoutSubviews{
    [super layoutSubviews];
}

-(void)addScoreString:(NSString *)scoreString{
    self.score.text = scoreString;
    //如果是competitionview
    if ([self.title.text isEqualToString:@"竞赛模式"]) {
        if ([self.type isEqualToString:@"competition"]) {
            self.title.text = @"竞赛模式";
        }else if ([self.type isEqualToString:@"puzzle"])
        {
            self.title.text = @"解谜模式";
        }
    }else{
        if ([self.type isEqualToString:@"competition"]) {
            self.title.text = @"COMPETITION";
        }else if ([self.type isEqualToString:@"puzzle"])
        {
            self.title.text = @"PUZZLE";
        }
    }
    
}

+ (instancetype)gameOverScoreWithName{
    return [[NSBundle mainBundle]loadNibNamed:@"GameOverScoreWithNameView" owner:nil options:nil][0];
}

- (IBAction)menu:(UIButton *)sender {
    UserDb *db = [UserDb sharedUserDb];
    //如果是competitionview
    if ([self.type isEqualToString:@"competition"]) {
        [db insertCompetitionWithName:self.name.text score:self.score.text];
        //调用competitionViewController的返回方法
        [self.cvc back:sender];
    }else if ([self.type isEqualToString:@"puzzle"])
    {
        [db insertPuzzleWithName:self.name.text score:self.score.text];
        //调用pvc的返回方法
        [self.pvc back:sender];
    }
}

@end
