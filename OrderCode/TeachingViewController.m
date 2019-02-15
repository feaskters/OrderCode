//
//  TeachViewController.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/23.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "TeachingViewController.h"

@interface TeachingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TeachingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)back:(UIButton *)sender {
    [_musplay_yx play];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (IBAction)changeMode:(UIButton *)sender {
    [_musplay_yx play];
    
    //英文
    if ([sender.titleLabel.text isEqualToString:@"↓ STANDARD ↓"]) {
        [sender setTitle:@"↓ COMPETITION ↓" forState:UIControlStateNormal];
         [sender setTitle:@"↓ COMPETITION ↓" forState:UIControlStateHighlighted];
        self.imageView.image = [UIImage imageNamed: @"competition_teach_en"];
    }else if([sender.titleLabel.text isEqualToString:@"↓ COMPETITION ↓"]){
        [sender setTitle:@"↓ STANDARD ↓" forState:UIControlStateNormal];
        [sender setTitle:@"↓ STANDARD ↓" forState:UIControlStateHighlighted];
        self.imageView.image = [UIImage imageNamed: @"教程_en"];
    }
    //中文
    if ([sender.titleLabel.text isEqualToString:@"↓ 标准模式 ↓"]) {
        [sender setTitle:@"↓ 竞技模式 ↓" forState:UIControlStateNormal];
        [sender setTitle:@"↓ 竞技模式 ↓" forState:UIControlStateHighlighted];
        self.imageView.image = [UIImage imageNamed: @"competition_teach"];
    }else if([sender.titleLabel.text isEqualToString:@"↓ 竞技模式 ↓"]){
        [sender setTitle:@"↓ 标准模式 ↓" forState:UIControlStateNormal];
        [sender setTitle:@"↓ 标准模式 ↓" forState:UIControlStateHighlighted];
        self.imageView.image = [UIImage imageNamed: @"教程"];
    }
}

@end
