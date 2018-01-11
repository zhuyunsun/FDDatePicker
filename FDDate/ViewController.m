//
//  ViewController.m
//  FDDate
//
//  Created by 朱运 on 2017/12/26.
//  Copyright © 2017年 zhuyun. All rights reserved.
//

#define WindowWidth [UIScreen mainScreen].bounds.size.width
#define WindowHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "FDDatePicker.h"
@interface ViewController ()<FDDateDelegate>{
    FDDatePicker *datePicker;
    UILabel *_selectDateLabel;
}
@property(nonatomic,strong)UIButton *showDateButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];

    _showDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _showDateButton.frame = CGRectMake(0, 0, WindowWidth / 6, WindowHeight / 18);
    _showDateButton.center = CGPointMake(WindowWidth / 2, WindowHeight / 6);
    [_showDateButton setTitle:@"show" forState:UIControlStateNormal];
    [_showDateButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    _showDateButton.layer.cornerRadius = 4;
    _showDateButton.layer.borderColor = [[UIColor blackColor] CGColor];
    _showDateButton.layer.borderWidth = 0.77;
    [_showDateButton addTarget:self action:@selector(showDateButtonAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_showDateButton];
    
    _selectDateLabel = [[UILabel alloc]init];
    _selectDateLabel.frame = CGRectMake(0, 0, WindowWidth / 3, WindowHeight / 15);
    _selectDateLabel.center = CGPointMake(WindowWidth / 2 , WindowHeight / 6 + WindowHeight / 9);
    _selectDateLabel.backgroundColor = [UIColor lightGrayColor];
    _selectDateLabel.textColor = [UIColor whiteColor];
    _selectDateLabel.layer.cornerRadius = 3;
    _selectDateLabel.clipsToBounds = YES;
    _selectDateLabel.font = [UIFont systemFontOfSize:13];
    _selectDateLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_selectDateLabel];
    
    datePicker = [[FDDatePicker alloc]init];
    datePicker.delegate = self;
    datePicker.month = @"12";
    datePicker.day = @"12";
    datePicker.year = @"1990";
    datePicker.beginYear = @"1949";
    datePicker.endYear = @"2000";
//    datePicker.keepDate = NO;
    
    
}
-(void)selectDate:(NSString *)dateString{
    NSLog(@"选择的日期=%@",dateString);
    _selectDateLabel.text = dateString;
}
-(void)cancleAction{
    NSLog(@"取消");
}
-(void)showDateButtonAction{
    [datePicker showPickerView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
