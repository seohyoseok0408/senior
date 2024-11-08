package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Senior {
    private int seniorId;
    private String seniorName;
    private String seniorGender;
    private String seniorTel;
    private Date seniorBirth;
    private String seniorZipcode;
    private String seniorStreetAddr;
    private String seniorDetailAddr1;
    private String seniorDetailAddr2;
    private Date seniorRdate;
    private String seniorStatus;
    private String seniorSignificant;
    private int userId;
}
