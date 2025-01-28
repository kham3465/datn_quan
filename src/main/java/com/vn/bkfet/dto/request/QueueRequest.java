package com.vn.bkfet.dto.request;

import com.vn.bkfet.enums.NumberVehicle;
import lombok.Data;

@Data
public class QueueRequest {
    private Long idUser;
    private Long idVehicle;
    private NumberVehicle number;
}
