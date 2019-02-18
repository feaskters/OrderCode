//
//  PuzzleView.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/18.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "PuzzleView.h"

@interface PuzzleView(){
     int a;
     int b;
     int c;
}

@property (weak, nonatomic) IBOutlet UILabel *a_label;
@property (weak, nonatomic) IBOutlet UILabel *signal;
@property (weak, nonatomic) IBOutlet UILabel *b_label;
@property (weak, nonatomic) IBOutlet UILabel *c_label;
@property (nonatomic) UIView *resultViewCorrect;
@property (nonatomic) UIView *resultViewFault;

@end

@implementation PuzzleView

//懒加载正确的view
- (UIView *)resultViewCorrect{
    if (_resultViewCorrect == nil) {
        _resultViewCorrect = [[UIView alloc]init];
        //绿色打钩图片
        UIImageView *imageView = [[UIImageView alloc]initWithImage: [UIImage imageNamed: @"勾"] ];
        imageView.frame = CGRectMake(5, 5, 40, 40);
        //+2s
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(100, 0, 50, 50);
        label.textColor = [UIColor greenColor];
        label.text = @"+2s";
        label.font = [UIFont fontWithName:@"Chalkduster" size: 24.0];
        //添加部件
        _resultViewCorrect.frame = CGRectMake(50, 50, 150, 50);
        [_resultViewCorrect addSubview:imageView];
        [_resultViewCorrect addSubview:label];
    }
    return _resultViewCorrect;
}

//懒加载错误的view
- (UIView *)resultViewFault{
    if (_resultViewFault == nil) {
        _resultViewFault = [[UIView alloc]init];
        //红色叉图片
        UIImageView *imageView = [[UIImageView alloc]initWithImage: [UIImage imageNamed: @"叉"] ];
        imageView.frame = CGRectMake(5, 5, 40, 40);
        //+2s
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(100, 0, 50, 50);
        label.textColor = [UIColor redColor];
        label.text = @"-5s";
        label.font = [UIFont fontWithName:@"Chalkduster" size: 24.0];
        //添加部件
        _resultViewFault.frame = CGRectMake(50, 50, 150, 50);
        [_resultViewFault addSubview:imageView];
        [_resultViewFault addSubview:label];
    }
    return _resultViewFault;
}

+(instancetype)puzzleView{
    return [[NSBundle mainBundle]loadNibNamed:@"PuzzleView" owner:nil options:nil][0];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self start];
}

//开始出题
-(void)start{
    //随机生成a,b
    a = arc4random() % 99 + 1;
    b = arc4random() % 9 + 1;
    //随机生成+，-，*
    /*
     0 -> +
     1 -> -
     2 -> *
     */
    int sig = arc4random() % 3;
    switch (sig) {
        case 0:
            self.signal.text = @"+";
            c = a + b;
            break;
        case 1:
            self.signal.text = @"-";
            c = a - b;
            break;
        case 2:
            self.signal.text = @"*";
            c = a * b;
            break;
        default:
            break;
    }
    self.a_label.text = [NSString stringWithFormat:@"%d",a];
    self.c_label.text = [NSString stringWithFormat:@"%d",c];
    self.b_label.text = @"?";
}

-(BOOL)resultWithB:(int)B{
    self.b_label.text = [NSString stringWithFormat:@"%d",B];
    //判断答案是否相等
    if (B == b) {
        //弹出正确弹窗
        [self addSubview:self.resultViewCorrect];
        self.resultViewCorrect.alpha = 0;
        [UIView animateWithDuration:1 animations:^{
            self.resultViewCorrect.alpha = 1;
        } completion:^(BOOL finished) {
            [self.resultViewCorrect removeFromSuperview];
            [self start];
        }];
    }else{
        //弹出错误弹窗
        [self addSubview:self.resultViewFault];
        self.resultViewFault.alpha = 0;
        [UIView animateWithDuration:1 animations:^{
            self.resultViewFault.alpha = 1;
        } completion:^(BOOL finished) {
            [self.resultViewFault removeFromSuperview];
            [self start];
        }];
    }
    return B == b;
}

@end
