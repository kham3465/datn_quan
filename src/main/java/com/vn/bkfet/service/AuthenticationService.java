package com.vn.bkfet.service;

import com.vn.bkfet.dto.request.AuthenticationRequest;
import com.vn.bkfet.dto.request.RegisterRequest;
import com.vn.bkfet.dto.response.AuthenticationResponse;
import com.vn.bkfet.entity.User;

public interface AuthenticationService {
    public User register(RegisterRequest request);
    public AuthenticationResponse authenticate(AuthenticationRequest request);

}
