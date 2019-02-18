//
//  PuzzleView.h
//  OrderCode
//
//  Created by iOS123 on 2019/2/18.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PuzzleView : UIView

+(instancetype)puzzleView;
//给b的值，返回对错
-(BOOL)resultWithB:(int)B;

@end

NS_ASSUME_NONNULL_END
