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
@property (nonatomic,strong) SQLite3Proxy           * sqlite3proxy;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [_submit setTitle:@"Submit" forState:UIControlStateNormal];
    _submit.frame = CGRectMake(10, 250, 100, 30);
    _submit.layer.borderWidth = 1;
    _submit.layer.backgroundColor = [UIColor grayColor].CGColor;
    [_submit addTarget:self action:@selector(insertData) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_timetip];
    [self.view addSubview:_submit];
    
    _sqlite3proxy = [[SQLite3Proxy alloc] init];
}

- (void)insertData
{
    NSDate * startdate = [NSDate date];
    [_sqlite3proxy insertData2:_name.text withAge:_age.text withSex:_sex.text withTimes:1];
    NSDate * enddate = [NSDate date];
    double timegap = enddate.timeIntervalSince1970 - startdate.timeIntervalSince1970;
    
    [_timetip setText:[NSString stringWithFormat:@"数据插入时间%f",timegap]];
}

@end
