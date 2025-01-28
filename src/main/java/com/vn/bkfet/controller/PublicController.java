package com.vn.bkfet.controller;

import com.vn.bkfet.dto.request.ElectricVehicleRequest;
import com.vn.bkfet.dto.request.QueueRequest;
import com.vn.bkfet.entity.ElectricVehicle;
import com.vn.bkfet.entity.Queue;
import com.vn.bkfet.enums.District;
import com.vn.bkfet.enums.NumberVehicle;
import com.vn.bkfet.enums.Status;
import com.vn.bkfet.service.ElectricVehicleService;
import com.vn.bkfet.service.QueueService;
import com.vn.bkfet.util.StandardResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/public")
@RequiredArgsConstructor
@Tag(name = "Public Api", description = "Public API")
public class PublicController {
    @Autowired
    private ElectricVehicleService electricVehicleService;
    @Autowired
    private QueueService queueService;

    @PostMapping("/create_electric")
    public ResponseEntity<Object> createElectricVehicle(@RequestBody ElectricVehicleRequest request) {
        ElectricVehicle electricVehicle = electricVehicleService.create(request);
        return new ResponseEntity<>(new StandardResponse("200", "Done", electricVehicle), HttpStatus.OK);
    }

    @PutMapping("/update_electric/{id}")
    public ResponseEntity<Object> updateElectricVehicle(
            @RequestBody ElectricVehicleRequest request,
            @PathVariable Long id) {
        electricVehicleService.updateElectricVehicle(request, id);
        return new ResponseEntity<>(new StandardResponse("200", "Done", null), HttpStatus.OK);
    }

    @GetMapping("/get_electric/{id}")
    public ResponseEntity<Object> getElectricVehicleById(@PathVariable Long id) {
        ElectricVehicle electricVehicle = electricVehicleService.getById(id);
        return new ResponseEntity<>(new StandardResponse("200", "Done", electricVehicle), HttpStatus.OK);
    }

    @GetMapping("get_list_electric")
    public ResponseEntity<Object> getListElectric(
            @RequestParam(required = false) District district,
            @RequestParam(required = false) String name) {
        List<ElectricVehicle> electricVehicles = electricVehicleService.getListElectric(district, name);
        return new ResponseEntity<>(new StandardResponse("200", "Done", electricVehicles), HttpStatus.OK);
    }

    @DeleteMapping("delete_electric/{id}")
    public ResponseEntity<Object> deleteElectricVehicle(@PathVariable Long id) {
        electricVehicleService.deleteElectricVehicle(id);
        return new ResponseEntity<>(new StandardResponse("200", "Done", null), HttpStatus.OK);
    }

    @PostMapping("queue_create")
    public ResponseEntity<Object> createQueue(@RequestBody QueueRequest request) {
        Queue queue = queueService.createQueue(request);
        return new ResponseEntity<>(new StandardResponse("200", "Done", queue), HttpStatus.OK);
    }

    @PutMapping("update_queue/{id}")
    public ResponseEntity<Object> updateQueueStatus(@PathVariable Long id, @RequestParam Status status) {
        queueService.update(id, status);
        return new ResponseEntity<>(new StandardResponse("200", "Done", null), HttpStatus.OK);
    }

    @GetMapping("get_list_queue")
    public ResponseEntity<Object> getQueues(
            @RequestParam(required = false) Long idUser,
            @RequestParam(required = false) Long idElectric,
            @RequestParam(required = false) Status status,
            @RequestParam(required = false) District district,
             @RequestParam(required = false) NumberVehicle number
    ) {
        List<Queue> queues = queueService.getList(idUser, idElectric, status, district, number);
        return new ResponseEntity<>(new StandardResponse("200", "Done", queues), HttpStatus.OK);
    }

    @GetMapping("get_queue/{id}")
    public ResponseEntity<Object> getQueue(@PathVariable Long id) {
        Queue queue = queueService.getQueue(id);
        return new ResponseEntity<>(new StandardResponse("200", "Done", queue), HttpStatus.OK);
    }

    @DeleteMapping("delete_queue/{id}")
    public ResponseEntity<Object> deleteQueue(@PathVariable Long id) {
        queueService.delete(id);
        return new ResponseEntity<>(new StandardResponse("200", "Done", null), HttpStatus.OK);
    }

    @GetMapping("check_numberCar")
    public ResponseEntity<Object> checkNumberCar(@RequestParam(required = false) String numberCar) {
        return new ResponseEntity<>(new StandardResponse("200", numberCar, queueService.checkNumberCar(numberCar)), HttpStatus.OK);
    }
}
