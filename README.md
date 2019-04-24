# FDDate
### A coustom date with year-month-day
![image](https://20190422zy.oss-cn-shenzhen.aliyuncs.com/2019-4-24-01/date-show.gif?Expires=1556092285&OSSAccessKeyId=TMP.AgGcYoxX6jm8u_pJ0e7SVkKfHrZ5fgBIW9rAKBzIir6OKmxyoHPyH3eD2yMSADAtAhUAqpCFX8h4cYcB8X8pGXGna9INF-4CFFyUWu051zkAytuPbWl5oj2fPVkz&Signature=KCu%2BZhcnZCNYhZ3By1FCR9OXaQg%3D) 
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
