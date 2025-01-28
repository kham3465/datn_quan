package com.vn.bkfet.repo;
import com.vn.bkfet.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    boolean existsByName(String name);
    boolean existsByNumberCar(String name);
    Optional<User> findByName(String name);

}
