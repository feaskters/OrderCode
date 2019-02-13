//
//  GameOverCompetitionView.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "GameOverCompetitionView.h"

@interface GameOverCompetitionView()

@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UITextField *name;


@end

@implementation GameOverCompetitionView

- (void)layoutSubviews{
    [super layoutSubviews];
}

-(void)addScoreString:(NSString *)scoreString{
    self.score.text = scoreString;
}

+ (instancetype)gameOverCompetition{
    return [[NSBundle mainBundle]loadNibNamed:@"GameOverCompetitionView" owner:nil options:nil][0];
}

- (IBAction)menu:(UIButton *)sender {
    [self.cvc back:sender];
}

@end
