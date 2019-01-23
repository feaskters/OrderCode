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
@property (weak, nonatomic) IBOutlet UIImageView *SuccessView;


@end

@implementation GameOverView

-(void)layoutSubviews{
    [super layoutSubviews];
    //修改plist文件
    //沙盒路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [documentPath stringByAppendingPathComponent:@"CheckPoint.plist"];
    NSMutableArray *mArray = [NSMutableArray arrayWithContentsOfFile:path];
    //设置图片
    NSString *levelName = [[NSString alloc]initWithFormat:@"%@",self.gameDetail[@"level"]];
    [self.levelView setImage:[UIImage imageNamed:levelName]];
    //设置星星
    if (self.is_star == 1) {
        UIImage *image = [UIImage imageNamed:@"星星-满"];
        [self.starImage setImage:image];
    }
    //是否过关
    if (self.is_clear == 0) {
        self.resultLabel.text = @"FAILED";
        UIImage *image = [UIImage imageNamed:@"失败"];
        [self.SuccessView setImage:image];
    }else{
        if ([self.gameDetail[@"level"] integerValue] < 9) {
            [mArray[[self.gameDetail[@"level"] integerValue]] setObject:@(1) forKey: @"enable"];
        }
        if (self.is_star == 1) {
            [mArray[[self.gameDetail[@"level"] integerValue] - 1] setObject:@(1) forKey: @"is_star"];
        }
        
    }
    [mArray writeToFile:path atomically:YES];
}

+(instancetype)gameOverView{
    return [[NSBundle mainBundle]loadNibNamed:@"GameOverView" owner:nil options:nil][0];
}
- (IBAction)back:(UIButton *)sender {
    [_musicPlay_yx play];
    [self.gvc back:sender];
}

@end
