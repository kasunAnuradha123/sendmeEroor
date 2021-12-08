

import 'package:sendme/domain/entities/user_entity.dart';
import 'package:sendme/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUseCase{
  final FirebaseRepository repository;

  GetCreateCurrentUseCase({ this.repository});

  Future<void> call(UserEntity user)async{
    return await repository.getCreateCurrentUser(user);
  }
}