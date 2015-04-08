//
//  SQLite3Proxy.m
//  SQLiteLearn1
//
//  Created by 申超 on 15/4/8.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import "SQLite3Proxy.h"
#import <sqlite3.h>

#define database            @"sqlite3"

#define CREATE_TABLE        @"create table if not exists people ("\
"id INTEGER PRIMARY KEY AUTOINCREMENT," \
"name Text," \
"age Text," \
"sex Text)"

#define INSERT_TABLE        @"insert into people (name,age,sex) values (?,?,?)"


@interface SQLite3Proxy ()

@property (nonatomic,strong) NSString               * datebasePath;

@end;

@implementation SQLite3Proxy
{
    sqlite3 * datebase;
}

- (id) init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _datebasePath = [documentsDirectory stringByAppendingPathComponent:database];
        
        [self p_createTable];
    }
    return self;
}

- (void) p_createTable
{
    int result = sqlite3_open([_datebasePath UTF8String], &datebase);
    NSLog(@"open result %d",result);
    char *errorMsg;
    sqlite3_exec(datebase, [CREATE_TABLE UTF8String], NULL, NULL, &errorMsg);
    sqlite3_close(datebase);
}

//10w次插入大于80s
- (void) insertData:(NSString *) name withAge:(NSString *) age withSex:(NSString *) sex withTimes:(int) times
{
    int result = sqlite3_open([_datebasePath UTF8String], &datebase);
    NSLog(@"open result %d",result);
    
    sqlite3_stmt * stmt;
    int stmtResult = sqlite3_prepare_v2(datebase, [INSERT_TABLE UTF8String], -1, &stmt, nil);
    for (int i=0; i<times; i++) {
        if(stmtResult == SQLITE_OK)
        {
            sqlite3_bind_text(stmt, 1, [[NSString stringWithFormat:@"%@%d",name,i] UTF8String], -1, NULL);
            sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@%d",age,i] UTF8String], -1, NULL);
            sqlite3_bind_text(stmt, 3, [[NSString stringWithFormat:@"%@%d",sex,i] UTF8String], -1, NULL);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSLog(@"insert error !!!");
        }
        //sqlite3_clear_bindings
        //sqlite3_reset并不改变在准备语句上的任何绑定值，那么这里猜测，可能是语句在被执行的过程中发生了其他的改变，然后这个语句将它重置到绑定值的时候的那个状态。
        sqlite3_reset(stmt);
    }
    NSLog(@"insert finished!!!");
    sqlite3_finalize(stmt);
    sqlite3_close(datebase);
}

//10w次插入小于1s，可见使用了事务之后却是极大的提高了数据库的效率。但是我们也要注意，使用事务也是有一定的开销的，所以对于数据量很小的操作可以不必使用，以免造成而外的消耗。
- (void) insertData2:(NSString *) name withAge:(NSString *) age withSex:(NSString *) sex withTimes:(int) times
{
    int result = sqlite3_open([_datebasePath UTF8String], &datebase);
    NSLog(@"open result %d",result);
    //将会重复的打开关闭数据库文件100万次，所以速度当然会很慢。因此对于这种情况我们应该使用“事务”。
    sqlite3_exec(datebase, "BEGIN;", 0, 0, NULL);
    sqlite3_stmt * stmt;
    int stmtResult = sqlite3_prepare_v2(datebase, [INSERT_TABLE UTF8String], -1, &stmt, nil);
    for (int i=0; i<times; i++) {
        if(stmtResult == SQLITE_OK)
        {
            sqlite3_bind_text(stmt, 1, [[NSString stringWithFormat:@"%@%d",name,i] UTF8String], -1, NULL);
            sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@%d",age,i] UTF8String], -1, NULL);
            sqlite3_bind_text(stmt, 3, [[NSString stringWithFormat:@"%@%d",sex,i] UTF8String], -1, NULL);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSLog(@"insert error !!!");
        }
        //sqlite3_clear_bindings
        //sqlite3_reset并不改变在准备语句上的任何绑定值，那么这里猜测，可能是语句在被执行的过程中发生了其他的改变，然后这个语句将它重置到绑定值的时候的那个状态。
        sqlite3_reset(stmt);
    }
    sqlite3_exec(datebase, "COMMIT;", 0, 0, NULL);
    NSLog(@"insert finished!!!");
    sqlite3_finalize(stmt);
    sqlite3_close(datebase);
}

@end
