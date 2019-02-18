//
//  MoreView.h
//  OrderCode
//
//  Created by iOS123 on 2019/2/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//代理协议
@protocol LSMoreViewDelegate <NSObject>

@optional
-(void)LSMoreViewCompetitionButtonClick;
-(void)LSMoreViewRankButtonClick;
-(void)LSMoreViewPuzzleButtonClick;
@end

@interface MoreView : UIView

+(instancetype)moreView;
@property (nonatomic,weak) id<LSMoreViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
