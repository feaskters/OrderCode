//
//  CoinImageView.h
//  OrderCode
//
//  Created by iOS123 on 2019/2/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinImageView : UIImageView

@property AVAudioPlayer *musplay_yx;

-(BOOL)isCatch;
-(NSArray *)location;
-(void)down :(double)duration;
-(void)catchCoin;

@end

NS_ASSUME_NONNULL_END
