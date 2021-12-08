import 'package:equatable/equatable.dart';

class MyChatEntity extends Equatable {
  final String senderName;
  final String sendUID;
  final String recipientName;
  final String recipientUID;
  final String channelId;
  final String profileURl;
  final String recipientPhoneNumber;
  final String senderPhoneNumber;
  final String recentTextMessage;
  final String isRead;
  final String isArchived;
  final String time;

  MyChatEntity({
    this.senderName,
    this.sendUID,
    this.recipientName,
    this.recipientUID,
    this.channelId,
    this.profileURl,
    this.recipientPhoneNumber,
    this.senderPhoneNumber,
    this.recentTextMessage,
    this.isRead,
    this.isArchived,
    this.time,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
    senderName,
    sendUID,
    recipientName,
    recipientUID,
    channelId,
    profileURl,
    recipientPhoneNumber,
    senderPhoneNumber,
    recentTextMessage,
    isRead,
    isArchived,
    time,
  ];
}
