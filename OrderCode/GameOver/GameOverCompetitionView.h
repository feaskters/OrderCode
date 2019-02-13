//
//  GameOverCompetitionView.h
//  OrderCode
//
//  Created by iOS123 on 2019/2/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../competition/CompetitionViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameOverCompetitionView : UIView

@property CompetitionViewController *cvc;

-(void)addScoreString:(NSString *)scoreString;
+(instancetype)gameOverCompetition;

@end

NS_ASSUME_NONNULL_END
