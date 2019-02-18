//
//  CharacterView.h
//  OrderCode
//
//  Created by iOS123 on 2019/1/22.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CharacterView : UIImageView

+(instancetype)characterView;
-(void)up;
-(void)left;
-(void)down;
-(void)right;
-(void)competition_left;
-(void)competition_right;
-(void)competition_up;
-(void)competition_down;

//获取当前位置
-(NSArray *)location;

@end

NS_ASSUME_NONNULL_END
