package com.vn.bkfet.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;
import java.util.List;

@Configuration
@Data
public class FileConfig {
    @Value("${acd.file.max-file-size}")
    private String maxFileSizeConf;

    @Value("${acd.file.max-request-size}")
    private String maxRequestSizeConf;

    @Value("${acd.file.allow-extension}")
    private String allowExtensionConf;

    public long getMaxFileSize() {
        return getSize(maxFileSizeConf);
    }

    public long getMaxRequestSize() {
        return getSize(maxRequestSizeConf);
    }

    private long getSize(String sizeStr) {
        long size = Long.parseLong(sizeStr.replace("MB", ""));
        return size * 1024 * 1024;
    }

    public List<String> getAllowExtension() {
        return Arrays.asList(allowExtensionConf.split(","));
    }
}
