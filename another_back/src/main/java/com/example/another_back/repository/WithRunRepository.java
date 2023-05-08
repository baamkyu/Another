package com.example.another_back.repository;

import com.example.another_back.entity.WithRun;
import org.springframework.data.jpa.repository.JpaRepository;

public interface WithRunRepository extends JpaRepository<WithRun, Long> {
    Long countByRunningHostId(String runningId);
}
