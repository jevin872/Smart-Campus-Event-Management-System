package com.campus.event.models;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "registrations")
public class Registration {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "event_id")
  private Event event;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "user_id")
  private User user;

  private LocalDateTime registrationDate;

  @Enumerated(EnumType.STRING)
  private ERegistrationStatus status;

  public Registration() {}

  public Registration(Event event, User user, LocalDateTime registrationDate, ERegistrationStatus status) {
    this.event = event;
    this.user = user;
    this.registrationDate = registrationDate;
    this.status = status;
  }

  public Long getId() { return id; }
  public void setId(Long id) { this.id = id; }
  public Event getEvent() { return event; }
  public void setEvent(Event event) { this.event = event; }
  public User getUser() { return user; }
  public void setUser(User user) { this.user = user; }
  public LocalDateTime getRegistrationDate() { return registrationDate; }
  public void setRegistrationDate(LocalDateTime registrationDate) { this.registrationDate = registrationDate; }
  public ERegistrationStatus getStatus() { return status; }
  public void setStatus(ERegistrationStatus status) { this.status = status; }
}
