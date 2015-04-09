//
//  SQLite3Proxy.h
//  SQLiteLearn1
//
//  Created by 申超 on 15/4/8.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLite3Proxy : NSObject

/**
 *  添加数据
 *
 *  @param name  姓名
 *  @param age   年龄
 *  @param sex   性别
 *  @param times 插入数据条数
 */
- (void) insertData:(NSString *) name withAge:(NSString *) age withSex:(NSString *) sex withTimes:(int) times;

/**
 *  添加数据（使用事务）
 *
 *  @param name  姓名
 *  @param age   年龄
 *  @param sex   性别
 *  @param times 插入数据条数
 */
- (void) insertData2:(NSString *) name withAge:(NSString *) age withSex:(NSString *) sex withTimes:(int) times;

/**
 *  删除所有数据
 */
- (void) deleteData;

/**
 *  查询数据
 *
 *  @return 查询数据条数
 */
- (double) selectData;

/**
 *  添加索引
 */
- (void) addIndex;

/**
 *  删除索引
 */
- (void) deleteIndex;

@end
