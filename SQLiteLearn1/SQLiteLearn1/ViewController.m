//
//  ViewController.m
//  SQLiteLearn1
//
//  Created by 申超 on 15/4/8.
//  Copyright (c) 2015年 申超. All rights reserved.
//

#import "ViewController.h"
#import "SQLite3Proxy.h"

@interface ViewController ()

@property (nonatomic,strong) UILabel                * nametip;
@property (nonatomic,strong) UITextField            * name;
@property (nonatomic,strong) UILabel                * agetip;
@property (nonatomic,strong) UITextField            * age;
@property (nonatomic,strong) UILabel                * sextip;
@property (nonatomic,strong) UITextField            * sex;

@property (nonatomic,strong) UILabel                * timetip;
@property (nonatomic,strong) UIButton               * submit;
@property (nonatomic,strong) UIButton               * delete;
@property (nonatomic,strong) UIButton               * select;
@property (nonatomic,strong) UIButton               * addindex;
@property (nonatomic,strong) UIButton               * rmindex;
@property (nonatomic,strong) SQLite3Proxy           * sqlite3proxy;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //页面布局
    
    _nametip = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 100, 30)];
    [_nametip setText:@"Name"];
    _name = [[UITextField alloc] initWithFrame:CGRectMake(110, 50, 100, 30)];
    _name.layer.borderWidth = 1;
    
    [self.view addSubview:_nametip];
    [self.view addSubview:_name];
    
    _agetip = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 100, 30)];
    [_agetip setText:@"Age"];
    _age = [[UITextField alloc] initWithFrame:CGRectMake(110, 100, 100, 30)];
    _age.layer.borderWidth = 1;
    
    [self.view addSubview:_agetip];
    [self.view addSubview:_age];
    
    _sextip = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 100, 30)];
    [_sextip setText:@"Sex"];
    _sex = [[UITextField alloc] initWithFrame:CGRectMake(110, 150, 100, 30)];
    _sex.layer.borderWidth = 1;
    
    [self.view addSubview:_sextip];
    [self.view addSubview:_sex];
    
    _timetip = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 30)];
    [_timetip setText:@"插入数据时间：0s"];
    
    _submit = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submit setTitle:@"Insert" forState:UIControlStateNormal];
    _submit.frame = CGRectMake(10, 250, 100, 30);
    _submit.layer.borderWidth = 1;
    _submit.layer.backgroundColor = [UIColor grayColor].CGColor;
    [_submit addTarget:self action:@selector(insertData) forControlEvents:UIControlEventTouchUpInside];
    
    _delete = [UIButton buttonWithType:UIButtonTypeCustom];
    [_delete setTitle:@"Delete" forState:UIControlStateNormal];
    _delete.frame = CGRectMake(110, 250, 100, 30);
    _delete.layer.borderWidth = 1;
    _delete.layer.backgroundColor = [UIColor grayColor].CGColor;
    [_delete addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_timetip];
    [self.view addSubview:_submit];
    [self.view addSubview:_delete];
    
    _select = [UIButton buttonWithType:UIButtonTypeCustom];
    [_select setTitle:@"Select" forState:UIControlStateNormal];
    _select.frame = CGRectMake(10, 300, 100, 30);
    _select.layer.borderWidth = 1;
    _select.layer.backgroundColor = [UIColor grayColor].CGColor;
    [_select addTarget:self action:@selector(selectData) forControlEvents:UIControlEventTouchUpInside];
    
    _addindex = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addindex setTitle:@"AddIndex" forState:UIControlStateNormal];
    _addindex.frame = CGRectMake(110, 300, 100, 30);
    _addindex.layer.borderWidth = 1;
    _addindex.layer.backgroundColor = [UIColor grayColor].CGColor;
    [_addindex addTarget:self action:@selector(addIndex) forControlEvents:UIControlEventTouchUpInside];
    
    _rmindex = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rmindex setTitle:@"DeleteIndex" forState:UIControlStateNormal];
    _rmindex.frame = CGRectMake(210, 300, 100, 30);
    _rmindex.layer.borderWidth = 1;
    _rmindex.layer.backgroundColor = [UIColor grayColor].CGColor;
    [_rmindex addTarget:self action:@selector(deleteIndex) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_select];
    [self.view addSubview:_addindex];
    [self.view addSubview:_rmindex];
    
    _sqlite3proxy = [[SQLite3Proxy alloc] init];
}

/**
 *  插入数据
 */
- (void) insertData
{
    NSDate * startdate = [NSDate date];
    [_sqlite3proxy insertData2:_name.text withAge:_age.text withSex:_sex.text withTimes:1000000];
    NSDate * enddate = [NSDate date];
    double timegap = enddate.timeIntervalSince1970 - startdate.timeIntervalSince1970;
    
    [_timetip setText:[NSString stringWithFormat:@"数据插入时间%f",timegap]];
}

/**
 *  删除数据
 */
- (void) deleteData
{
    NSDate * startdate = [NSDate date];
    [_sqlite3proxy deleteData];
    NSDate * enddate = [NSDate date];
    double timegap = enddate.timeIntervalSince1970 - startdate.timeIntervalSince1970;
    
    [_timetip setText:[NSString stringWithFormat:@"数据删除时间%f",timegap]];
}

/**
 *  查询数据
 */
- (void) selectData
{
    NSDate * startdate = [NSDate date];
    double rows = [_sqlite3proxy selectData];
    NSDate * enddate = [NSDate date];
    double timegap = enddate.timeIntervalSince1970 - startdate.timeIntervalSince1970;
    
    [_timetip setText:[NSString stringWithFormat:@"查询%f数据时间%f",rows,timegap]];
}

/**
 *  添加索引数据
 */
- (void) addIndex
{
    NSDate * startdate = [NSDate date];
    [_sqlite3proxy addIndex];
    NSDate * enddate = [NSDate date];
    double timegap = enddate.timeIntervalSince1970 - startdate.timeIntervalSince1970;
    
    [_timetip setText:[NSString stringWithFormat:@"添加索引时间%f",timegap]];
}

/**
 *  删除索引数据
 */
- (void) deleteIndex
{
    NSDate * startdate = [NSDate date];
    [_sqlite3proxy deleteIndex];
    NSDate * enddate = [NSDate date];
    double timegap = enddate.timeIntervalSince1970 - startdate.timeIntervalSince1970;
    
    [_timetip setText:[NSString stringWithFormat:@"删除索引时间%f",timegap]];
}

@end
