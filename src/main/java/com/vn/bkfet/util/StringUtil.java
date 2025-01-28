package com.vn.bkfet.util;

public class StringUtil {
    public static boolean isNullOrEmpty(String obj) {
        return obj == null ||obj.isEmpty() || obj.isBlank();
    }
}
