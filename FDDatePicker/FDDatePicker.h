//
//  FDDatePicker.h
//  FDDate
//
//  Created by 朱运 on 2017/12/28.
//  Copyright © 2017年 zhuyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FDDateDelegate;
@interface FDDatePicker : NSObject
@property(nonatomic,weak)id<FDDateDelegate>delegate;
@property(nonatomic,strong)NSString *beginYear;/**<开始年份*/
@property(nonatomic,strong)NSString *endYear;/**<结束年份*/
@property(nonatomic,strong)NSString *year;/**<默认年份*/
@property(nonatomic,strong)NSString *month;/**<默认月份*/
@property(nonatomic,strong)NSString *day;/**<默认日份*/
@property(nonatomic)BOOL keepDate;/**<是否保存上一次的日期选择状态,默认是YES*/
-(void)showPickerView;
@end
//delegate
@protocol FDDateDelegate<NSObject>
@optional
/**
 选择日期格式是:xxxx-xx-xx

 @param dateString xxxx-xx-xx
 */
-(void)selectDate:(NSString *)dateString;
/**
 取消选择
 */
-(void)cancleAction;
@end
