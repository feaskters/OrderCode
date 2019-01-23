//
//  TeachViewController.m
//  OrderCode
//
//  Created by iOS123 on 2019/1/23.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "TeachViewController.h"

@interface TeachViewController ()

@end

@implementation TeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)back:(UIButton *)sender {
    [_musicPlay_yx play];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
