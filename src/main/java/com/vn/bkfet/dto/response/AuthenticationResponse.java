package com.vn.bkfet.dto.response;

import com.vn.bkfet.entity.User;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AuthenticationResponse {
    private User user;
    private String accessToken;
}
