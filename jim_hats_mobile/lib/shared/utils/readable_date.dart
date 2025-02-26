String readableDate(DateTime date){
  
    int hour = date.hour;
    int minute = date.minute;
    bool minuteLessThan10 = minute<10;
    bool hourLessThan10 = hour<10;
    
    return '${hourLessThan10?'0':''}$hour:${minuteLessThan10?'0':''}$minute';
}