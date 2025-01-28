package com.vn.bkfet.entity;

import com.vn.bkfet.enums.NumberVehicle;
import com.vn.bkfet.enums.Status;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Entity
@NoArgsConstructor
@Table(name = "queue")
public class Queue {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private Status status;
    @Column(name = "number")
    @Enumerated(EnumType.STRING)
    private NumberVehicle number;
    @Column(name="time_start")
    private LocalDateTime timeStart;
    @Column(name="time_end")
    private LocalDateTime timeEnd;
    @Column(name="time_out")
    private LocalDateTime timeOut;
    @ManyToOne
    @JoinColumn(name = "id_account", nullable = false)
    private User user;
    @ManyToOne
    @JoinColumn(name = "id_electric", nullable = false)
    private ElectricVehicle electricVehicle;
}
