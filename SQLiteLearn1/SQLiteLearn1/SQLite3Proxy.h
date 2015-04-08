//
//  SQLite3Proxy.h
//  SQLiteLearn1
//
//  Created by 申超 on 15/4/8.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLite3Proxy : NSObject

- (void) insertData:(NSString *) name withAge:(NSString *) age withSex:(NSString *) sex withTimes:(int) times;
- (void) insertData2:(NSString *) name withAge:(NSString *) age withSex:(NSString *) sex withTimes:(int) times;
@end
