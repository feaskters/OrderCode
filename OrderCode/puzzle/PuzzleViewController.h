//
//  PuzzleViewController.h
//  OrderCode
//
//  Created by iOS123 on 2019/2/18.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PuzzleViewController : UIViewController

@property AVAudioPlayer *musplay;
@property AVAudioPlayer *musPlay_yx;//音效
@property AVAudioPlayer *musPlay_bg;//背景
+(instancetype)puzzleViewController;
- (IBAction)back:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
