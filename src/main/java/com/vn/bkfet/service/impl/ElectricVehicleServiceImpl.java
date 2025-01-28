package com.vn.bkfet.service.impl;

import com.vn.bkfet.dto.request.ElectricVehicleRequest;
import com.vn.bkfet.entity.ElectricVehicle;
import com.vn.bkfet.enums.District;
import com.vn.bkfet.repo.ElectricVehicleRepository;
import com.vn.bkfet.service.ElectricVehicleService;
import jakarta.validation.ValidationException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ElectricVehicleServiceImpl implements ElectricVehicleService {
    final private ElectricVehicleRepository electricVehicleRepository;
    @Override
    public ElectricVehicle create(ElectricVehicleRequest request) {
        ElectricVehicle electricVehicle = new ElectricVehicle();
        electricVehicle.setName(request.getName());
        electricVehicle.setDistrict(request.getDistrict());
        electricVehicle.setLongitude(request.getLongitude());
        electricVehicle.setLatitude(request.getLatitude());
        electricVehicle.setCreateTime(LocalDateTime.now());
        return electricVehicleRepository.save(electricVehicle);
    }
    @Override
    public void updateElectricVehicle(ElectricVehicleRequest request, Long id) {
        ElectricVehicle electricVehicle = electricVehicleRepository.findById(id).orElseThrow(()->new ValidationException("Không tồn tại trạm sạc này"));
        if(request.getDistrict()!=null){
            electricVehicle.setDistrict(request.getDistrict());
        }

        if(request.getLongitude()!=null){
            electricVehicle.setLongitude(request.getLongitude());
        }
        if(request.getLatitude()!=null){
            electricVehicle.setLatitude(request.getLatitude());
        }
        if(request.getName()!=null){
            electricVehicle.setName(request.getName());
        }
        electricVehicleRepository.save(electricVehicle);
    }
    @Override
    public ElectricVehicle getById(Long id) {
        return electricVehicleRepository.findById(id).orElseThrow(()->new ValidationException("Không tồn tại trạm sạc này"));
    }
    @Override
    public List<ElectricVehicle> getListElectric(District district, String name) {
        return electricVehicleRepository.find(name, district);
    }
    @Override
    public void deleteElectricVehicle(Long id) {
        ElectricVehicle electricVehicle = electricVehicleRepository.findById(id).orElseThrow(()->new ValidationException("Không tồn tại trạm sạc này"));
         electricVehicleRepository.delete(electricVehicle);
    }
}
