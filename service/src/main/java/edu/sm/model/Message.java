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
public class Message {
    private Integer messageId;
    private Integer receiverId;
    private String title;
    private String content;
    private LocalDateTime createdAt;
    private Boolean isRead;
}
