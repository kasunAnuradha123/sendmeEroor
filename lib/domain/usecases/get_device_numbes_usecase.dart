

import 'package:sendme/domain/repositories/get_device_number_repository.dart';
import 'package:sendme/domain/entities/contact_entitiy.dart';

class GetDeviceNumberUseCase{
  final GetDeviceNumberRepository deviceNumberRepository;

  GetDeviceNumberUseCase({this.deviceNumberRepository});

  Future<List<ContactEntity>>call()async{
    return deviceNumberRepository.getDeviceNumber();
  }
}