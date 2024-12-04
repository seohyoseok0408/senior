package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Schedule {
    private int scheduleId;               // 스케줄 ID
    private String scheduleTitle;         // 스케줄 제목
    private String scheduleDescription;   // 스케줄 설명
    private LocalDateTime scheduleStartDatetime; // 스케줄 시작 시간
    private LocalDateTime scheduleEndDatetime;   // 스케줄 종료 시간
    private String scheduleStatus;        // 스케줄 상태 (ACTIVE, CANCELLED)
    private int scheduleGroupId;          // 그룹 ID
    private int userId;                   // 사용자 ID
    private int cwId;                     // 돌봄 제공자 ID
}
