package com.vn.bkfet.entity;

import com.vn.bkfet.enums.District;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Entity
@NoArgsConstructor
@Table(name = "electric_vehicle")
public class ElectricVehicle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name="name")
    private String name;
    @Column(name="longitude")
    private String longitude;
    @Column(name="latitude")
    private String latitude;
    @Column(name="district")
    @Enumerated(EnumType.STRING)
    private District district;
    @Column(name="create_time")
    private LocalDateTime createTime;
}
