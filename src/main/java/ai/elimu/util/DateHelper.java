package ai.elimu.util;

import java.util.Date;

public class DateHelper {

    public static Date timestampToDate(Long timestamp) {        
        return new Date(timestamp * 1000);
    }

    public static Long dateToTimestamp(Date date) {
        return date.getTime() / 1000;
    }
}
