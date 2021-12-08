import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sendme/domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  TextMessageModel({
    String senderName,
    String sendUID,
    String recipientName,
    String recipientUID,
    String messageType,
    String message,
    String messageId,
    String time,
  }) : super(
          senderName:senderName,
          sendUID:sendUID,
          recipientName:recipientName,
          recipientUID:recipientUID,
          messageType:messageType,
          message:message,
          messageId:messageId,
          time:time,
        );
  factory TextMessageModel.fromSnapShot(DocumentSnapshot snapshot){
    return TextMessageModel(
      senderName:snapshot.data(),
      sendUID:snapshot.data(),
      recipientName:snapshot.data(),
      recipientUID:snapshot.data(),
      messageType:snapshot.data(),
      message:snapshot.data(),
      messageId:snapshot.data(),
      time:snapshot.data(),
    );
  }
  Map<String,dynamic>toDocumen(){
    return{
      "senderName":senderName,
      "sendUID":sendUID,
      "recipientName":recipientName,
      "recipientUID":recipientUID,
      "messageType":messageType,
      "message":message,
      "messageId":messageId,
      "time":time,
    };
  }
}
