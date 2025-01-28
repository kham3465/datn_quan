package com.vn.bkfet.repo;

import com.vn.bkfet.entity.ElectricVehicle;
import com.vn.bkfet.enums.District;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ElectricVehicleRepository extends JpaRepository<ElectricVehicle,Long> {

    @Query("SELECT u FROM ElectricVehicle u " +
            "WHERE (:name is null or u.name like %:name%) " +
            "AND (:district is null or u.district = :district) " +
            "ORDER BY u.id")
    List<ElectricVehicle> find(String name, District district);
}
