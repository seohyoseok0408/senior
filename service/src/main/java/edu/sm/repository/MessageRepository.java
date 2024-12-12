package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.Message;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MessageRepository extends SMRepository<Integer, Message> {
     List<Message> findMessagesByReceiverId(Integer receiverId) throws Exception;
     int countUnreadMessages(Integer receiverId) throws Exception;
     void changeRead(Integer messageId) throws Exception;
}
