package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WorkLog {
    private int workLogId;
    private String workLogContent;
    private LocalDateTime workLogRdate;
    private LocalDateTime visitStartTime;
    private LocalDateTime visitEndTime;
    private int cwId;
    private int seniorId;
}
