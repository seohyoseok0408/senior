package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Contract {
    private int contractId;
    private LocalDate contractDate;
    private LocalDate contractStartDate;
    private LocalDate contractEndDate;
    private int contractPrice;
    private String contractStatus;
    private int cwId;
    private int userId;
    private int seniorId;
    private int scheduleId;
}
