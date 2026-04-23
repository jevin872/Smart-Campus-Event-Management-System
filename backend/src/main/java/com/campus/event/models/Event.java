package com.campus.event.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Entity
@Table(name = "events")
public class Event {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @NotBlank
  private String title;

  @NotBlank
  @Column(columnDefinition = "TEXT")
  private String description;

  @NotBlank
  private String location;

  @NotNull
  private LocalDateTime dateTime;

  @NotBlank
  private String category;

  private Integer capacity;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "organizer_id")
  private User organizer;

  public Event() {}

  public Event(String title, String description, String location, LocalDateTime dateTime, String category, Integer capacity) {
    this.title = title;
    this.description = description;
    this.location = location;
    this.dateTime = dateTime;
    this.category = category;
    this.capacity = capacity;
  }

  public Long getId() { return id; }
  public void setId(Long id) { this.id = id; }
  public String getTitle() { return title; }
  public void setTitle(String title) { this.title = title; }
  public String getDescription() { return description; }
  public void setDescription(String description) { this.description = description; }
  public String getLocation() { return location; }
  public void setLocation(String location) { this.location = location; }
  public LocalDateTime getDateTime() { return dateTime; }
  public void setDateTime(LocalDateTime dateTime) { this.dateTime = dateTime; }
  public String getCategory() { return category; }
  public void setCategory(String category) { this.category = category; }
  public Integer getCapacity() { return capacity; }
  public void setCapacity(Integer capacity) { this.capacity = capacity; }
  public User getOrganizer() { return organizer; }
  public void setOrganizer(User organizer) { this.organizer = organizer; }
}
