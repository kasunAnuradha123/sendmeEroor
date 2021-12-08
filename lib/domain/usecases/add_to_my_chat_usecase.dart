

import 'package:sendme/domain/entities/my_chat_entity.dart';
import 'package:sendme/domain/repositories/firebase_repository.dart';

class AddToMyChatUseCase{
  final FirebaseRepository repository;
   AddToMyChatUseCase({this.repository});

   Future<void>call({MyChatEntity myChatEntity})async{
     return await repository.addToMyChat(myChatEntity);
   }
}