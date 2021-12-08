import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:sendme/app_const.dart';
import 'package:sendme/domain/entities/my_chat_entity.dart';
import 'package:sendme/domain/entities/text_message_entity.dart';
import 'package:sendme/domain/usecases/add_to_my_chat_usecase.dart';
import 'package:sendme/domain/usecases/get_one_to_one_single_user_chat_channel_usecase.dart';
import 'package:sendme/domain/usecases/get_text_message_usecase.dart';
import 'package:sendme/domain/usecases/send_text_message_usecase.dart';
part 'communication_state.dart';

class CommunicationCubit extends Cubit<CommunicationState> {
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetOneToOneSingleUserChatChannelUseCase
  getOneToOneSingleUserChatChannelUseCase;
  final GetTextMessagesUseCase getTextMessagesUseCase;
  final AddToMyChatUseCase addToMyChatUseCase;

  CommunicationCubit({
    this.getTextMessagesUseCase,
    this.addToMyChatUseCase,
    this.getOneToOneSingleUserChatChannelUseCase,
    this.sendTextMessageUseCase,
  }) : super(CommunicationInitial());

  Future<void> sendTextMessage({
    String senderName,
    String senderId,
    String recipientId,
    String recipientName,
    String message,
    String recipientPhoneNumber,
    String senderPhoneNumber,
  }) async {
    try {
      final channelId = await getOneToOneSingleUserChatChannelUseCase.call(
          senderId, recipientId);
      await sendTextMessageUseCase.sendTextMessage(
        TextMessageEntity(
          recipientName: recipientName,
          recipientUID: recipientId,
          senderName: senderName,
          time: "",
          sendUID: senderId,
          message: message,
          messageId: "",
          messageType: AppConst.text,
        ),
        channelId,
      );
      await addToMyChatUseCase.call(myChatEntity: MyChatEntity(
        time: "",
        senderName: senderName,
        sendUID: senderId,
        senderPhoneNumber: senderPhoneNumber,
        recipientName: recipientName,
        recipientUID: recipientId,
        recipientPhoneNumber: recipientPhoneNumber,
        recentTextMessage: message,
        profileURl: "",
        isRead: "",
        isArchived: "",
        channelId: channelId,
      ));
    } on SocketException catch(_){
      emit(CommunicationFailure());
    } catch(_) {
      emit(CommunicationFailure());
    }
  }
  Future<void> getMessages({String senderId,String recipientId})async{
    emit(CommunicationLoading());
    try{

      final channelId=await getOneToOneSingleUserChatChannelUseCase.call(senderId, recipientId);

      final messagesStreamData=getTextMessagesUseCase.call(channelId);
      messagesStreamData.listen((messages) {
        emit(CommunicationLoaded(messages: messages));
      });

    }on SocketException catch(_){
      emit(CommunicationFailure());
    }catch(_){
      emit(CommunicationFailure());
    }
  }
}
