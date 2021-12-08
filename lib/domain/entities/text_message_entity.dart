import 'package:equatable/equatable.dart';

class TextMessageEntity extends Equatable {
  final String senderName;
  final String sendUID;
  final String recipientName;
  final String recipientUID;
  final String messageType;
  final String message;
  final String messageId;
  final String time;

  TextMessageEntity({
    this.senderName,
    this.sendUID,
    this.recipientName,
    this.recipientUID,
    this.messageType,
    this.message,
    this.messageId,
    this.time,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
    senderName,
    sendUID,
    recipientName,
    messageType,
    message,
    messageId,
    time,
    time,
  ];
}
