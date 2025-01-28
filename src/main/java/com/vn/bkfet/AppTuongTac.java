package com.vn.bkfet;

import jakarta.annotation.PostConstruct;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

import java.util.TimeZone;

@SpringBootApplication
@EnableCaching
public class AppTuongTac {
    public static void main(String[] args) {
        SpringApplication.run(AppTuongTac.class, args);
    }
    @PostConstruct
    public void init() {
        // Đặt múi giờ mặc định là Asia/Ho_Chi_Minh
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
        System.out.println("Múi giờ hiện tại: " + TimeZone.getDefault().getID());
    }
}
