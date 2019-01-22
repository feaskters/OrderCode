//
//  GameViewController.h
//  OrderCode
//
//  Created by iOS123 on 2019/1/21.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController

@property AVAudioPlayer *musicPlay;
@property AVAudioPlayer *musicPlay_yx;//音效
@property AVAudioPlayer *musicPlay_bg;//背景
@property AVAudioPlayer *musicPlay_yx1;//音效

@property (weak, nonatomic) IBOutlet UIImageView *levelImage;

@property NSDictionary *checkPointInfo;

- (IBAction)back:(UIButton *)sender;
+(instancetype)gameView;

@end

NS_ASSUME_NONNULL_END
