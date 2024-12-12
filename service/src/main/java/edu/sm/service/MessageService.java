package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Message;
import edu.sm.repository.MessageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class MessageService implements SMService<Integer, Message> {
    private final MessageRepository messageRepository;

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
}
