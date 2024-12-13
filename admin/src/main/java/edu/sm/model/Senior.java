package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Senior {
    private int seniorId;
    private String seniorName;
    private String seniorGender; // Enum: 'M', 'F'
    private String seniorTel;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date seniorBirth;

    private String seniorZipcode;
    private String seniorStreetAddr;
    private String seniorDetailAddr1;
    private String seniorDetailAddr2;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date seniorRdate;

    private String seniorStatus; // Enum: 'ACTIVE', 'INACTIVE'
    private String seniorSignificant;
    private String seniorProfile;

    private BigDecimal seniorLatitude; // decimal(20,15)
    private BigDecimal seniorLongitude; // decimal(20,15)

    private int userId;
}
