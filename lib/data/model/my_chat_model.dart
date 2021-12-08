import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sendme/domain/entities/my_chat_entity.dart';

class MyChatModel extends MyChatEntity {
  MyChatModel(
      {String senderName,
      String sendUID,
      String recipientName,
      String recipientUID,
      String channelId,
      String profileURl,
      String recipientPhoneNumber,
      String senderPhoneNumber,
      String recentTextMessage,
      String isRead,
      String isArchived,
      String time,})
      : super(
          senderName:senderName,
          sendUID:sendUID,
          recipientName:recipientName,
          recipientUID:recipientUID,
          channelId:channelId,
          profileURl:profileURl,
          recipientPhoneNumber:recipientPhoneNumber,
          senderPhoneNumber:senderPhoneNumber,
          recentTextMessage:recentTextMessage,
          isRead:isRead,
          isArchived:isArchived,
          time:time,
        );
  factory MyChatModel.fromSnapShot(DocumentSnapshot snapshot){
          return MyChatModel(
            senderName: snapshot.data(),
            sendUID: snapshot.data(),
            senderPhoneNumber: snapshot.data(),
            recipientName: snapshot.data(),
            recipientUID: snapshot.data(),
            recipientPhoneNumber: snapshot.data(),
            channelId: snapshot.data(),
            time: snapshot.data(),
            isArchived: snapshot.data(),
            isRead: snapshot.data(),
            recentTextMessage: snapshot.data(),
            profileURl: snapshot.data(),
          );
  }
  Map<String,dynamic>toDocument(){
    return{
      "senderName":senderName,
      "sendUID":sendUID,
      "recipientName":recipientName,
      "recipientUID":recipientUID,
      "channelId":channelId,
      "profileURl":profileURl,
      "recipientPhoneNumber":recipientPhoneNumber,
      "senderPhoneNumber":senderPhoneNumber,
      "recentTextMessage":recentTextMessage,
      "isRead":isRead,
      "isArchived":isArchived,
      "time":time,
    };
  }
}
