package com.vn.bkfet.service.impl;

import com.vn.bkfet.config.JwtService;
import com.vn.bkfet.dto.request.AuthenticationRequest;
import com.vn.bkfet.dto.request.RegisterRequest;
import com.vn.bkfet.dto.response.AuthenticationResponse;
import com.vn.bkfet.entity.User;
import com.vn.bkfet.enums.Role;
import com.vn.bkfet.exception.ClientErrorException;
import com.vn.bkfet.repo.UserRepository;
import com.vn.bkfet.service.AuthenticationService;
import com.vn.bkfet.util.TimeUtil;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthenticationServiceImpl implements AuthenticationService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    @Override
    public User register(RegisterRequest request) {
        if (userRepository.existsByName(request.getName())) {
            throw new ClientErrorException("Tên người dùng đã được đăng ký");
        }
        User user = new User();
        user.setNumberCar(request.getNumberCar());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setIsActive(true);
        user.setName(request.getName());
        user.setRole(Role.USER);
        user.setCreatedTime(TimeUtil.getCurrentDateTime());
        return userRepository.save(user);
    }

    @Override
    @Transactional
    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getName(),
                        request.getPassword()
                )
        );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        User user = (User) authentication.getPrincipal();
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .user(user)
                .accessToken(jwtToken)
                .build();
    }
}
