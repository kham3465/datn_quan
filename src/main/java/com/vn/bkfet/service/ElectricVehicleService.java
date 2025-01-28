package com.vn.bkfet.service;

import com.vn.bkfet.dto.request.ElectricVehicleRequest;
import com.vn.bkfet.entity.ElectricVehicle;
import com.vn.bkfet.enums.District;

import java.util.List;

public interface ElectricVehicleService {
    public ElectricVehicle create(ElectricVehicleRequest request);
    public void updateElectricVehicle(ElectricVehicleRequest request, Long id);
    public ElectricVehicle getById(Long id);
    public List<ElectricVehicle> getListElectric(District district, String name);
    public void deleteElectricVehicle(Long id);
}
