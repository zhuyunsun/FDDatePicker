# FDDate
### A coustom date with year-month-day
![image](http://oodrfzkav.bkt.clouddn.com/date/date-show.gif) 
### How to use
setting default date  
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

