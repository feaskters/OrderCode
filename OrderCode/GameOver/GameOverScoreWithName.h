//
//  GameOverCompetitionView.h
//  OrderCode
//
//  Created by iOS123 on 2019/2/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../competition/CompetitionViewController.h"
#import "../puzzle/PuzzleViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameOverScoreWithName : UIView

@property CompetitionViewController *cvc;
@property PuzzleViewController *pvc;

@property NSString* type;
-(void)addScoreString:(NSString *)scoreString;
+(instancetype)gameOverScoreWithName;

@end

NS_ASSUME_NONNULL_END
