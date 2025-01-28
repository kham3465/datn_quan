package com.vn.bkfet.dto.request;
import com.vn.bkfet.enums.District;
import lombok.Data;
@Data
public class ElectricVehicleRequest {
    private String name;
    private String longitude;
    private String latitude;
    private District district;
}
