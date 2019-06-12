# FDDate
### A coustom date with year-month-day
![image](https://20190422zy.oss-cn-shenzhen.aliyuncs.com/2019-4-24-01/%E8%87%AA%E5%AE%9A%E4%B9%89%E6%97%A5%E6%9C%9F%E9%80%89%E6%8B%A9%E5%99%A8/date-show.gif) 
### How to use
setting default message  
``` 
    datePicker = [[FDDatePicker alloc]init];
    datePicker.delegate = self;//select date delegate
    datePicker.month = @"12";//default month
    datePicker.day = @"12";//default day
    datePicker.year = @"1990";//default year
    datePicker.beginYear = @"1949";//begin year
    datePicker.endYear = @"2000";//end year
    datePicker.keepDate = NO;//save date state last time;
    
``` 
show 

```  
[datePicker showPickerView];

```  
delegate
```  
-(void)selectDate:(NSString *)dateString{
    NSLog(@"selestdate=%@",dateString);
    _selectDateLabel.text = dateString;
}
-(void)cancleAction{
    NSLog(@"cancle");
}

```  
### If you find any bugs,please contact me.  
gzzhuyunsun@163.com
