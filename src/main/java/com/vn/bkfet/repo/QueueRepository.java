package com.vn.bkfet.repo;

import com.vn.bkfet.entity.Queue;
import com.vn.bkfet.enums.District;
import com.vn.bkfet.enums.NumberVehicle;
import com.vn.bkfet.enums.Status;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface QueueRepository extends JpaRepository<Queue, Long> {
    @Query("SELECT q FROM Queue q " +
            "WHERE (:idUser IS NULL OR q.user.id = :idUser) " +
            "AND (:idElectric IS NULL OR q.electricVehicle.id = :idElectric) " +
            "AND (:status IS NULL OR q.status = :status) " +
            "AND (:district IS NULL OR q.electricVehicle.district = :district) " +
            "AND (:number IS NULL OR q.number = :number) " +
            "ORDER BY q.id")
    List<Queue> find(Long idUser, Long idElectric, Status status, District district, NumberVehicle number);

    @Query("SELECT COUNT(q) > 0 FROM Queue q WHERE q.timeStart >= :startOfDay AND q.electricVehicle.id = :idVehicle AND q.number = :number ")
    boolean existsQueueStartingToday(LocalDateTime startOfDay, Long idVehicle, NumberVehicle number);

    @Query("SELECT COUNT(q) > 0 FROM Queue q WHERE q.timeOut <= :timeNow AND q.timeEnd >= :timeNow AND q.number = :number AND q.electricVehicle.id = :idVehicle ")
    boolean existsQueueStartingEnding(LocalDateTime timeNow, NumberVehicle number, Long idVehicle);
    @Query("SELECT COUNT(q) > 0 FROM Queue q WHERE q.timeStart <= :timeNow AND q.timeEnd >= :timeNow  AND q.user.id=:idUser")
    boolean existsQueueStartingEndingAndIdUser(LocalDateTime timeNow, Long idUser);

    Optional<Queue> findTopByOrderByTimeEndDesc();


    @Modifying
    @Transactional
    @Query(nativeQuery = true, value = "UPDATE Queue q " +
            "SET q.timeStart = DATE_ADD(q.timeStart, INTERVAL :timeDiff MILLISECOND), " +
            "q.timeOut = DATE_ADD(q.timeOut, INTERVAL :timeDiff MILLISECOND), " +
            "q.timeEnd = DATE_ADD(q.timeEnd, INTERVAL :timeDiff MILLISECOND) " +
            "WHERE q.electricVehicle_id = :idVehicle " +
            "AND q.number = :number " +
            "AND q.timeEnd > :canceledTimeEnd")
    void updateQueueTimesAfterCancellation(
            Long idVehicle,
            NumberVehicle number,
            LocalDateTime canceledTimeEnd,
            Long timeDiff // Sử dụng mili giây
    );


}
