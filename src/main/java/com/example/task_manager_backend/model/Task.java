package com.example.task_manager_backend.model;

import jakarta.persistence.*;
import lombok.Data; // From Lombok dependency
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity // Marks this class as a JPA entity
@Table(name = "tasks") // Specifies the table name
@Data // Generates getters, setters, toString, equals, hashCode from Lombok
@NoArgsConstructor // Generates no-argument constructor from Lombok
@AllArgsConstructor // Generates constructor with all fields from Lombok
public class Task {

    @Id // Marks this field as the primary key
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-increments the ID
    private Long id;
    private String title;
    private String description;
    private boolean completed;

    // Lombok annotations handle constructors, getters, and setters.
    // If not using Lombok, you would manually add:
    // public Task() {}
    // public Task(Long id, String title, String description, boolean completed) { ... }
    // public Long getId() { ... }
    // public void setId(Long id) { ... }
    // ... etc.
}