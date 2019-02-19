//
//  UserDb.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/14.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "UserDb.h"
#import "../fmdb/FMDB.h"

@interface UserDb()

@property FMDatabase *db;

@end

@implementation UserDb

static UserDb *_instance;

//加载时就创建database
+ (void)load{
    _instance = [[UserDb alloc]init];
    //沙盒地址
    NSString *path  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //数据库地址
    NSString *dbPath = [path stringByAppendingString:@"/user.sqlite"];
    NSLog(@"%@",dbPath);
    //加载数据库
    _instance.db = [FMDatabase databaseWithPath:dbPath];
    //创建competition表
    if ([_instance.db open]) {
        //若表已经存在:success值为false
        BOOL success = [_instance.db executeUpdate:@"create table competition (id integer primary key autoincrement,name text not null default player,score integer default 0);"];
        //若添加表成功，加入电脑数据
        if (success) {
            //添加五个默认数据
            [_instance.db executeUpdate:@"insert into competition(name ,score) values(?,?);",@"QLT",@"2000"];
            [_instance.db executeUpdate:@"insert into competition(name ,score) values(?,?);",@"GKD",@"3000"];
            [_instance.db executeUpdate:@"insert into competition(name ,score) values(?,?);",@"HHH",@"2300"];
            [_instance.db executeUpdate:@"insert into competition(name ,score) values(?,?);",@"SJB",@"1300"];
            [_instance.db executeUpdate:@"insert into competition(name ,score) values(?,?);",@"SMG",@"3200"];
        }
    }
    //创建puzzle表
    if ([_instance.db open]) {
        //若表已经存在:success值为false
        BOOL success = [_instance.db executeUpdate:@"create table puzzle (id integer primary key autoincrement,name text not null default player,score integer default 0);"];
        //若添加表成功，加入电脑数据
        if (success) {
            //添加五个默认数据
            [_instance.db executeUpdate:@"insert into puzzle(name ,score) values(?,?);",@"puzzle1",@"1000"];
            [_instance.db executeUpdate:@"insert into puzzle(name ,score) values(?,?);",@"puzzle2",@"500"];
            [_instance.db executeUpdate:@"insert into puzzle(name ,score) values(?,?);",@"puzzle3",@"1200"];
            [_instance.db executeUpdate:@"insert into puzzle(name ,score) values(?,?);",@"puzzle4",@"1300"];
            [_instance.db executeUpdate:@"insert into puzzle(name ,score) values(?,?);",@"puzzle5",@"700"];
        }
    }
}

//返回userdb
+(instancetype)sharedUserDb{
    return _instance;
}

//不允许alloc
+(instancetype)alloc{
    if (_instance) {
        NSException *exc = [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"There can only be one UserDb instance." userInfo:nil];
        //抛出异常
        [exc raise];
    }
    return [super alloc];
}

#pragma mark - competition

/*插入competition数据
 param:name->name score->score
 return:true->success false->fail
 */
-(BOOL)insertCompetitionWithName:(NSString *)name score:(NSString *)score{
    BOOL state =  [_instance.db executeUpdate:@"insert into competition(name ,score) values(?,?);",name,score];
    return state;
}

/*查询competition数据
 return
 */
-(NSArray *)SelectCompetition{
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    FMResultSet *set = [_instance.db executeQuery:@"select * from competition order by score desc limit 50"];
    while ([set next]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[set stringForColumnIndex:1], @"name",[[NSNumber alloc] initWithInt: [set intForColumnIndex:2]],@"score", nil];
        [mArray addObject:dic];
    }
    return mArray;
}

#pragma mark - puzzle

/*插入puzzle数据
 param:name->name score->score
 return:true->success false->fail
 */
-(BOOL)insertPuzzleWithName:(NSString *)name score:(NSString *)score{
    BOOL state =  [_instance.db executeUpdate:@"insert into puzzle(name ,score) values(?,?);",name,score];
    return state;
}

/*查询competition数据
 return
 */
-(NSArray *)SelectPuzzle{
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    FMResultSet *set = [_instance.db executeQuery:@"select * from puzzle order by score desc limit 50"];
    while ([set next]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[set stringForColumnIndex:1], @"name",[[NSNumber alloc] initWithInt: [set intForColumnIndex:2]],@"score", nil];
        [mArray addObject:dic];
    }
    return mArray;
}
@end
