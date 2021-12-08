part of 'communication_cubit.dart';

// import 'package:equatable/equatable.dart';
// import 'package:sendme/domain/entities/text_message_entity.dart';

abstract class CommunicationState extends Equatable {
  const CommunicationState();
}

class CommunicationInitial extends CommunicationState {
  @override
  List<Object> get props => [];
}
class CommunicationLoaded extends CommunicationState {
  final List<TextMessageEntity>messages;

  CommunicationLoaded({this.messages});
  @override
  List<Object> get props => [messages];
}
class CommunicationFailure extends CommunicationState {
  @override
  List<Object> get props => [];
}
class CommunicationLoading extends CommunicationState {
  @override
  List<Object> get props => [];
}