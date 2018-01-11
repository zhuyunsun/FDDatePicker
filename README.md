# FDDate
### A coustom date with year-month-day
![image](http://oodrfzkav.bkt.clouddn.com/date/date-show.gif) 
### how to use
setting default date  
``` 
    datePicker = [[FDDatePicker alloc]init];
    datePicker.delegate = self;
    datePicker.month = @"12";
    datePicker.day = @"12";
    datePicker.year = @"1990";
    datePicker.beginYear = @"1949";
    datePicker.endYear = @"2000";
    datePicker.keepDate = NO;
    
``` 

