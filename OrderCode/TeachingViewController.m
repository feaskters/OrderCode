//
//  TeachViewController.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/23.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "TeachingViewController.h"

@interface TeachingViewController ()

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

@end
