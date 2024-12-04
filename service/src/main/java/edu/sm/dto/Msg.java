package edu.sm.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
public class Msg {
    private String sendid;
    private String receiveid;
    private String content1;
}