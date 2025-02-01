package com.vn.bkfet.service.impl;

import com.vn.bkfet.dto.request.QueueRequest;
import com.vn.bkfet.entity.ElectricVehicle;
import com.vn.bkfet.entity.Queue;
import com.vn.bkfet.entity.User;
import com.vn.bkfet.enums.District;
import com.vn.bkfet.enums.NumberVehicle;
import com.vn.bkfet.enums.Status;
import com.vn.bkfet.repo.ElectricVehicleRepository;
import com.vn.bkfet.repo.QueueRepository;
import com.vn.bkfet.repo.UserRepository;
import com.vn.bkfet.service.QueueService;
import jakarta.validation.ValidationException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class QueueServiceImpl implements QueueService {
    final private ElectricVehicleRepository electricVehicleRepository;
    final private UserRepository userRepository;
    final private QueueRepository queueRepository;

    @Override
    public Queue createQueue(QueueRequest request) {
        Queue queue = new Queue();
        LocalDateTime startOfDay = LocalDateTime.of(LocalDateTime.now().toLocalDate(), LocalTime.MIN);
        if(queueRepository.existsQueueStartingEnding(LocalDateTime.now(), request.getNumber(), request.getIdVehicle())){
            throw new ValidationException("Ô sạc đang bận, không thể đăng ký ô sạc này");
        }
        if(queueRepository.existsQueueStartingEndingAndIdUser(LocalDateTime.now(),  request.getIdUser())){
            throw new ValidationException("Bạn đang có 1 yêu cầu chưa hoàn thành");
        }
        if (!queueRepository.existsQueueStartingToday(startOfDay, request.getIdVehicle(), request.getNumber())) {
            queue.setTimeStart(LocalDateTime.now());
            queue.setTimeOut(LocalDateTime.now().plusMinutes(15));
            queue.setTimeEnd(LocalDateTime.now().plusMinutes(60));
        } else {
            Optional<Queue> queueEnd= queueRepository.findTopByOrderByTimeEndDesc();
            LocalDateTime startTime= queueEnd.get().getTimeEnd();
            queue.setTimeStart(startTime);
            queue.setTimeOut(startTime.plusMinutes(15));
            queue.setTimeEnd(startTime.plusMinutes(60));
        }
        queue.setNumber(request.getNumber());
        queue.setUser(userRepository.findById(request.getIdUser()).orElse(new User()));
        queue.setStatus(Status.PENDING);
        queue.setElectricVehicle(electricVehicleRepository.findById(request.getIdVehicle()).orElse(new ElectricVehicle()));
        return queueRepository.save(queue);
    }

    @Override
    public void update(Long id, Status status) {
        Queue queue = queueRepository.findById(id)
                .orElseThrow(() -> new ValidationException("Không tồn tại queue này"));

        if (status != null) {
            queue.setStatus(status);
        }
        if (status != Status.PENDING) {
            LocalDateTime now = LocalDateTime.now();
            Duration timeDiff = Duration.between(queue.getTimeEnd(), now);
        List<Queue> listQueue=    queueRepository.findByLast(queue.getElectricVehicle().getId(),Status.PENDING,  queue.getNumber(),id);
            if(listQueue.isEmpty()){
                timeDiff = Duration.between(queue.getTimeEnd(), now);
            }else{
                Queue queueChoose=listQueue.get(0);
                timeDiff = Duration.between(queue.getTimeEnd(), queueChoose.getTimeEnd());
            }
            Long timeDiffInMillis = timeDiff.toMillis(); // Chuyển Duration thành mili giây
            queueRepository.updateQueueTimesAfterCancellation(
                    queue.getElectricVehicle().getId(),
                    queue.getNumber().name(),
                    queue.getTimeEnd(),
                    timeDiffInMillis // Truyền long vào thay vì Duration
            );
            queue.setTimeEnd(now);
            queue.setTimeOut(now);
        }
        // Lưu lại queue đã thay đổi
        queueRepository.save(queue);
    }

    @Override
    public List<Queue> getList(Long idUser, Long idElectric, Status status, District district, NumberVehicle number) {
        return queueRepository.find(idUser, idElectric, status, district, number);
    }

    @Override
    public Queue getQueue(Long id) {
        return queueRepository.findById(id).orElse(null);
    }

    @Override
    public void delete(Long id) {
        Queue queue = queueRepository.findById(id).orElse(null);
        queueRepository.delete(queue);
    }

    @Override
    public Boolean checkNumberCar(String numberCar) {
        if (userRepository.existsByNumberCar(numberCar)) {
            return true;
        } else {
            return false;
        }
    }
}
