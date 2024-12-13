package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Message;
import edu.sm.repository.MessageRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class MessageService implements SMService<Integer, Message> {
    private final MessageRepository messageRepository;
    private final CareworkerService careworkerService;

    @Override
    public void add(Message message) throws Exception {

    }

    @Override
    public void modify(Message message) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public Message get(Integer messageId) throws Exception {
        Message message = messageRepository.selectOne(messageId);
        return message;
    }

    @Override
    public List<Message> get() throws Exception {
        return List.of();
    }

    @Transactional
    public List<Message> getMessagesByReceiverId(Integer receiverId) throws Exception{
        List<Message> messages = messageRepository.findMessagesByReceiverId(receiverId);
        return messages;
    }

    @Transactional
    public int countUnreadMessages(Integer receiverId) throws Exception {
        return messageRepository.countUnreadMessages(receiverId);
    }

    @Transactional
    public void markAsRead(Integer messageId) throws Exception {
        messageRepository.changeRead(messageId);
    }

    @Transactional
    public void aproveContract(Integer userId, Integer cwId) throws Exception {
        Message message = new Message();
        String CareworkerName = careworkerService.get(cwId).getCwName();
        message.setReceiverId(userId);
        message.setTitle("계약이 승인되었습니다.");
        message.setContent(CareworkerName + "님과의 계약이 승인되었습니다.");
        message.setIsRead(false);
        log.info("Message: {}", message);
        messageRepository.insert(message);
    }
}
