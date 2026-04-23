package com.campus.event.repository;

import com.campus.event.models.Registration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RegistrationRepository extends JpaRepository<Registration, Long> {
  List<Registration> findByUserId(Long userId);
  List<Registration> findByEventId(Long eventId);
  Optional<Registration> findByEventIdAndUserId(Long eventId, Long userId);
}
