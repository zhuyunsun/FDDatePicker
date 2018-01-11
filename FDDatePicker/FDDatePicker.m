//
//  FDDatePicker.m
//  FDDate
//
//  Created by 朱运 on 2017/12/28.
//  Copyright © 2017年 zhuyun. All rights reserved.
//

#import "FDDatePicker.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FDDatePicker()<UIPickerViewDelegate,UIPickerViewDataSource>{
    CGFloat windowWidth;
    CGFloat windowHeight;
    
    UIButton *baseButton;
    UIView *bottomView;
    
    CGFloat bottomViewHeight;
    
    NSDateComponents *com;
    NSMutableArray *_yearArray;
    NSMutableArray *_monthArray;
    NSMutableArray *_dayArray;
    
    NSString *_currentYearSting;
    NSString *_currentMonthString;
    NSString *_currentDayString;
    
    NSString *_selectDate;
}
@property(nonatomic,strong)UIPickerView *pickerView;

@property(nonatomic,strong)UIView *barView;
@property(nonatomic,strong)UILabel *selectDateLabel;

@end
FDDatePicker *picker;
@implementation FDDatePicker
- (instancetype)init{
    self = [super init];
    if (self) {
        windowWidth = [UIScreen mainScreen].bounds.size.width;
        windowHeight = [UIScreen mainScreen].bounds.size.height;
        picker = self;
        com = [self currentDateComponents];
        _keepDate = YES;
    }
    return self;
}
-(void)setKeepDate:(BOOL)keepDate{
    _keepDate = keepDate;
}
-(void)setBeginYear:(NSString *)beginYear{
    if ([self isPureInt:beginYear]) {
        _beginYear = beginYear;
    }
}
-(void)setEndYear:(NSString *)endYear{
    if ([self isPureInt:endYear]) {
        _endYear = endYear;
    }
}

-(void)setYear:(NSString *)year{
    if ([self isPureInt:year]) {
        _currentYearSting = year;
    }
}
-(void)setMonth:(NSString *)month{
    if ([self isPureInt:month]) {
        NSUInteger monthInt = [month  integerValue];
        if (monthInt < 10) {
            month = [NSString stringWithFormat:@"0%@",month];
        }
        if (monthInt > 12) {
            if (com.month < 10) {
                month = [NSString stringWithFormat:@"0%ld",(long)com.month];
            }else{
                month = [NSString stringWithFormat:@"%ld",(long)com.month];
            }
        }
        _currentMonthString = month;
    }
}
-(void)setDay:(NSString *)day{
    if ([self isPureInt:day]) {
        if ([day  integerValue] < 10) {
            day = [NSString stringWithFormat:@"0%@",day];
        }
        _currentDayString = day;
    }
}
//判断是否是整型
-(BOOL)isPureInt:(NSString*)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
#pragma mark -- ======== views =========
-(void)loadView{
    bottomViewHeight = windowHeight / 3;
    CGFloat Y = windowHeight - bottomViewHeight;
//    Y = windowWidth / 2;
    bottomView = [[UIView alloc]init];
    bottomView.frame = CGRectMake(0,Y, windowWidth,bottomViewHeight);
    bottomView.backgroundColor = [UIColor redColor];
    
    [self loadBarView];
    
    [self getDataMessage];
    
    CGRect rect = CGRectMake(0,CGRectGetMaxY(self.barView.frame), windowWidth, bottomViewHeight - CGRectGetHeight(self.barView.frame));
    self.pickerView = [[UIPickerView alloc]initWithFrame:rect];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:self.pickerView];

    //
    if (_currentYearSting == nil || ![_yearArray containsObject:_currentYearSting]) {
        NSUInteger  yearRow = 0;
        if (_yearArray.count >= 35) {
            yearRow = 35;
        }else{
            yearRow = 0;
        }
        [self.pickerView selectRow:yearRow inComponent:0 animated:YES];
        _currentYearSting = _yearArray[yearRow];
    }else{
        NSUInteger  yearRow = [_yearArray indexOfObject:_currentYearSting];
        [self.pickerView selectRow:yearRow inComponent:0 animated:YES];
    }
    
    
    NSString *month;
    if (com.month < 10) {
        month = [NSString stringWithFormat:@"0%ld",(long)com.month];
    }else{
        month = [NSString stringWithFormat:@"%ld",(long)com.month];
    }
    if (_currentMonthString == nil) {
        _currentMonthString = month;
    }
    NSUInteger monthRow = [_monthArray indexOfObject:_currentMonthString];
    [self.pickerView selectRow:monthRow inComponent:1 animated:YES];
    
    NSString *day;
    if (com.day < 10) {
        day = [NSString stringWithFormat:@"0%ld",(long)com.day];
    }else{
        day = [NSString stringWithFormat:@"%ld",(long)com.day];
    }
    
    NSUInteger allDays = [self howManyDaysInThisYear:com.year withMonth:com.month];
    [_dayArray removeAllObjects];
    for (NSUInteger i = 1; i < allDays + 1; i ++) {
        NSString *dayString = [NSString stringWithFormat:@"%ld",(unsigned long)i];
        if (i < 10) {
            dayString = [NSString stringWithFormat:@"0%@",dayString];
        }
        [_dayArray addObject:dayString];
    }
    if (_currentDayString == nil) {
        _currentDayString = day;
    }
    if (![_dayArray containsObject:_currentDayString]) {
        _currentDayString = day;
    }
    NSUInteger dayRow = [_dayArray indexOfObject:_currentDayString];
    [self.pickerView selectRow:dayRow inComponent:2 animated:YES];
    
    [self.pickerView reloadAllComponents];
    
    _selectDate = [NSString stringWithFormat:@"%@-%@-%@",_currentYearSting,_currentMonthString,_currentDayString];
}
-(void)loadBarView{
    CGFloat width = windowWidth;
    CGFloat height = bottomViewHeight / 6;
    
    self.barView = [[UIView alloc]init];
    self.barView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    self.barView.frame = CGRectMake(0, 0, width, height);
    [bottomView addSubview:self.barView];
    
//    self.selectDateLabel = [[UILabel alloc]init];
//    self.selectDateLabel.frame = CGRectMake(width / 3, 0, width / 3, height);
//    self.selectDateLabel.textColor = [UIColor blackColor];
//    self.selectDateLabel.textAlignment = NSTextAlignmentCenter;
//    self.selectDateLabel.font = [UIFont systemFontOfSize:12];
//    [self.barView addSubview:self.selectDateLabel];
    
    
    CGFloat buttonWidth = width / 6;
    
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectButton.frame = CGRectMake(0, 0, buttonWidth, height);
    [selectButton setTitle:@"确定" forState:UIControlStateNormal];
    [selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(selectButtonAction) forControlEvents:UIControlEventTouchDown];
    selectButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.barView addSubview:selectButton];
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(width - buttonWidth, 0, buttonWidth, height);
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cancleButton addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchDown];
    [self.barView addSubview:cancleButton];
    
}
#pragma mark -- ======== pickerView delegate =========
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *selectYear = _currentYearSting;
    NSString *selectMonth = _currentMonthString;
    NSString *selectDay = _currentDayString;
    if (component == 0) {
        selectYear = _yearArray[row];
        [self changeDays];
    }
    if (component == 1) {
        selectMonth = _monthArray[row];
        [self changeDays];
    }
    if (component == 2) {
        selectDay = _dayArray[row];
    }
    if (_keepDate == YES) {
        _currentYearSting = selectYear;
        _currentMonthString = selectMonth;
        _currentDayString = selectDay;
    }
    _selectDate = [NSString stringWithFormat:@"%@-%@-%@",selectYear,selectMonth,selectDay];
    NSLog(@"_selectDate = %@",_selectDate);
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return _yearArray[row];
    }
    if (component == 1) {
        return _monthArray[row];
    }
    return _dayArray[row];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _yearArray.count;
    }
    if (component == 1) {
        return _monthArray.count;
    }
    return _dayArray.count;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *titleLabel = (UILabel *)view;
    if (titleLabel == nil){
        titleLabel = [[UILabel alloc]init];
        //在这里设置字体相关属性
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setBackgroundColor:[UIColor clearColor]];
    }
    //重新加载lbl的文字内容
    titleLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return titleLabel;
}
#pragma mark -- ======== dataSource =========
-(void)changeDays{
    NSUInteger allDays = [self howManyDaysInThisYear:[_currentYearSting integerValue] withMonth:[_currentMonthString integerValue]];
    
    [_dayArray removeAllObjects];
    for (NSUInteger i = 1; i < allDays + 1; i ++) {
        NSString *dayString = [NSString stringWithFormat:@"%ld",(unsigned long)i];
        if (i < 10) {
            dayString = [NSString stringWithFormat:@"0%@",dayString];
        }
        [_dayArray addObject:dayString];
    }
    [self.pickerView reloadComponent:2];
}
-(void)getDataMessage{
    NSUInteger beginCount = com.year - 70;
    NSUInteger allCount = com.year;
    if (_endYear == nil && _beginYear == nil) {
        
    }
    if (_endYear != nil && _beginYear == nil) {
        beginCount = [_endYear integerValue] - 70;
        allCount = [_endYear integerValue];
    }
    if (_endYear == nil && _beginYear != nil) {
        //
        if (com.year > [_beginYear integerValue]) {
            beginCount = [_beginYear integerValue];
            
        }else{
            beginCount = com.year;
            allCount = [_beginYear integerValue];
        }
    }
    if (_endYear != nil && _beginYear != nil) {
        //设置的结束年份比开始年份大,才有效;
        if ([_endYear integerValue] > [_beginYear integerValue]) {
            beginCount = [_beginYear integerValue];
            allCount = [_endYear integerValue];
        }
    }
    
    _yearArray = [[NSMutableArray alloc]init];
    for (NSUInteger i = beginCount; i <= allCount; i ++) {
        NSString *yearStr = [NSString stringWithFormat:@"%ld",(unsigned long)i];
        [_yearArray addObject:yearStr];
    }
    
    _monthArray = [[NSMutableArray alloc]init];
    for (NSUInteger i = 1; i < 13; i ++) {
        NSString *string = [NSString stringWithFormat:@"%ld",(unsigned long)i];
        if (i < 10) {
            string = [NSString stringWithFormat:@"0%@",string];
        }
        [_monthArray addObject:string];
    }
    
    NSUInteger allDays = [self howManyDaysInThisYear:com.year withMonth:com.month];
    _dayArray = [[NSMutableArray alloc]init];
    for (NSUInteger i = 1; i < allDays + 1; i ++) {
        NSString *dayString = [NSString stringWithFormat:@"%ld",(unsigned long)i];
        if (i < 10) {
            dayString = [NSString stringWithFormat:@"0%@",dayString];
        }
        [_dayArray addObject:dayString];
    }

}
#pragma mark -- ======== 获取当前年,月,日,时,分,秒,等信息 =========
-(NSDateComponents *)currentDateComponents{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate *dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    NSDateComponents *comp = [gregorian components: unitFlags fromDate:dt];
    return comp;
}
#pragma mark -- ======== 根据年和月获取天数 =========
-(NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12)){
        return 31 ;
    }
    if((month == 4) || (month == 6) || (month == 9) || (month == 11)){
        return 30;
    }
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3)){
        return 28;
    }
    if(year % 400 == 0){
        return 29;
    }
    if(year % 100 == 0){
        return 28;
    }
    return 29;
}
#pragma mark -- ======== show PickerView =========
-(void)showPickerView{
    [self loadView];
    
    UIColor *color = [UIColor blackColor];
    baseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    baseButton.frame = CGRectMake(0, 0, windowWidth, windowHeight);
    baseButton.backgroundColor = [color colorWithAlphaComponent:0.35];
    baseButton.alpha = 0;
    [baseButton addTarget:picker action:@selector(baseButtonAction) forControlEvents:UIControlEventTouchDown];
    
    [baseButton addSubview:bottomView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:baseButton];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    
    [UIView animateWithDuration:0.33 animations:^{
        baseButton.alpha = 1;
    } completion:^(BOOL finished) {
        baseButton.backgroundColor = [color colorWithAlphaComponent:0.35];
    }];
}
#pragma mark -- ======== remove PickerView =========
-(void)baseButtonAction{
//    [self removeBaseButton];
}
-(void)cancleAction{
    [self.delegate cancleAction];
    [self removeBaseButton];
}
-(void)removeBaseButton{
    [UIView animateWithDuration:0.22 animations:^{
        baseButton.alpha = 0;
    } completion:^(BOOL finished) {
        [baseButton removeFromSuperview];
    }];
}
-(void)selectButtonAction{
    [self.delegate selectDate:_selectDate];
    [self removeBaseButton];
}
@end
