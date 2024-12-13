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
    private LocalDate contractDate;      // 계약 생성 날짜
    private int contractPrice;           // 계약 금액
    private String contractStatus;       // 계약 상태 (예: PENDING, ACTIVE)
    private int cwId;                    // 보호사 ID
    private int userId;                  // 사용자 ID
    private int seniorId;                // 어르신 ID
    private String contractInfo;         // 계약 설명
}
