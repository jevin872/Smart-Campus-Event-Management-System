package com.campus.event.controllers;

import com.campus.event.models.*;
import com.campus.event.payload.response.MessageResponse;
import com.campus.event.repository.EventRepository;
import com.campus.event.repository.RegistrationRepository;
import com.campus.event.repository.UserRepository;
import com.campus.event.security.services.UserDetailsImpl;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/events")
public class EventController {
  @Autowired
  EventRepository eventRepository;

  @Autowired
  RegistrationRepository registrationRepository;

  @Autowired
  UserRepository userRepository;

  @GetMapping
  public List<Event> getAllEvents() {
    return eventRepository.findAll();
  }

  @GetMapping("/{id}")
  public ResponseEntity<?> getEventById(@PathVariable Long id) {
    Event event = eventRepository.findById(id)
        .orElseThrow(() -> new RuntimeException("Error: Event is not found."));
    return ResponseEntity.ok(event);
  }

  @PostMapping
  @PreAuthorize("hasRole('ORGANIZER') or hasRole('ADMIN')")
  public ResponseEntity<?> createEvent(@Valid @RequestBody Event event) {
    UserDetailsImpl userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    User user = userRepository.findById(userDetails.getId()).get();
    
    event.setOrganizer(user);
    eventRepository.save(event);
    return ResponseEntity.ok(new MessageResponse("Event created successfully!"));
  }

  @PostMapping("/{id}/register")
  @PreAuthorize("hasRole('STUDENT')")
  public ResponseEntity<?> registerForEvent(@PathVariable Long id) {
    UserDetailsImpl userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    User user = userRepository.findById(userDetails.getId()).get();
    
    Event event = eventRepository.findById(id)
        .orElseThrow(() -> new RuntimeException("Error: Event is not found."));
    
    if (registrationRepository.findByEventIdAndUserId(id, user.getId()).isPresent()) {
      return ResponseEntity.badRequest().body(new MessageResponse("Error: Already registered for this event!"));
    }

    Registration registration = new Registration(event, user, LocalDateTime.now(), ERegistrationStatus.PENDING);
    registrationRepository.save(registration);
    
    return ResponseEntity.ok(new MessageResponse("Registered for event successfully!"));
  }

  @GetMapping("/my-registrations")
  @PreAuthorize("hasRole('STUDENT')")
  public List<Registration> getMyRegistrations() {
    UserDetailsImpl userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    return registrationRepository.findByUserId(userDetails.getId());
  }
}
