package com.vn.bkfet.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.vn.bkfet.enums.Role;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
@Data
@Entity
@NoArgsConstructor
@Table(name = "account")
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "name")
    private String name;
    @Column(name="number_car")
    private String numberCar;
    @JsonIgnore
    private String password;
    @Column(name = "type_user")
    @Enumerated(EnumType.STRING)
    private Role role;
    @Column(name = "create_time")
    private LocalDateTime createdTime;
    @Column(name = "is_active")
    private Boolean isActive;
    @Override
    @JsonIgnore
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role.name()));
    }
    @Override
    @JsonIgnore
    public String getUsername() {
        return name;
    }

    @Override
    @JsonIgnore
    public boolean isAccountNonExpired() {
        return isActive;
    }

    @Override
    @JsonIgnore
    public boolean isAccountNonLocked() {
        return isActive;
    }

    @Override
    @JsonIgnore
    public boolean isCredentialsNonExpired() {
        return isActive;
    }

    @Override
    @JsonIgnore
    public boolean isEnabled() {
        return isActive;
    }
}
