package com.vn.bkfet.service;

import com.vn.bkfet.dto.request.QueueRequest;
import com.vn.bkfet.entity.Queue;
import com.vn.bkfet.enums.District;
import com.vn.bkfet.enums.NumberVehicle;
import com.vn.bkfet.enums.Status;

import java.util.List;

public interface QueueService {
    public Queue createQueue(QueueRequest request);
    public void update(Long id, Status status);
    public List<Queue> getList(Long idUser, Long idElectric, Status status, District district, NumberVehicle number);
    public Queue getQueue(Long id);
    public void delete(Long id);
    public Boolean checkNumberCar(String numberCar);
}
