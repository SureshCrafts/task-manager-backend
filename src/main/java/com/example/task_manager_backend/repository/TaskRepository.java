package com.example.task_manager_backend.repository;

import com.example.task_manager_backend.model.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository // Marks this interface as a Spring Data JPA repository
public interface TaskRepository extends JpaRepository<Task, Long> {
    // JpaRepository provides out-of-the-box CRUD operations for Task entity
    // You can add custom query methods here if needed, e.g.,
    // List<Task> findByCompleted(boolean completed);
}
