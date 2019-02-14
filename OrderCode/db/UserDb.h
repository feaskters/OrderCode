//
//  UserDb.h
//  OrderCode
//
//  Created by iOS123 on 2019/2/14.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDb : NSObject

+(instancetype)sharedUserDb;
-(NSArray *)SelectCompetition;
-(BOOL)insertCompetitionWithName:(NSString *)name score:(NSString *)score;

@end

NS_ASSUME_NONNULL_END
