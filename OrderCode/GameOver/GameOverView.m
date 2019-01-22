//
//  GameOverView.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/22.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "GameOverView.h"

@interface GameOverView()

@property (weak, nonatomic) IBOutlet UIImageView *levelView;
@property (weak, nonatomic) IBOutlet UIImageView *starImage;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;


@end

@implementation GameOverView

-(void)layoutSubviews{
    [super layoutSubviews];
    //设置图片
    NSString *levelName = [[NSString alloc]initWithFormat:@"%@",self.gameDetail[@"level"]];
    [self.levelView setImage:[UIImage imageNamed:levelName]];
    //设置星星
    
    //是否过关
    if (self.is_clear == 0) {
        self.resultLabel.text = @"FAILED";
    }
}

+(instancetype)gameOverView{
    return [[NSBundle mainBundle]loadNibNamed:@"GameOverView" owner:nil options:nil][0];
}
- (IBAction)back:(UIButton *)sender {
    [_musicPlay_yx play];
    [self.gvc back:sender];
}

@end
