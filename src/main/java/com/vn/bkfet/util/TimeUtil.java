package com.vn.bkfet.util;

import java.time.LocalDateTime;
import java.time.ZoneId;

public class TimeUtil {
    public static LocalDateTime getCurrentDateTime() {
        return LocalDateTime.now(ZoneId.of("Asia/Ho_Chi_Minh"));
    }
}
