package com.vn.bkfet.dto.request;

import lombok.Data;

@Data
public class AuthenticationRequest {
    private String name;
    private String password;

}
