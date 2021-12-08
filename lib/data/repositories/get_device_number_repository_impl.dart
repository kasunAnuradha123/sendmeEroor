

import 'package:sendme/data/local_datasource/local_datasource.dart';
import 'package:sendme/domain/entities/contact_entitiy.dart';
import 'package:sendme/domain/repositories/get_device_number_repository.dart';

class GetDeviceNumberRepositoryImpl implements GetDeviceNumberRepository{
  final LocalDataSource localDataSource;

  GetDeviceNumberRepositoryImpl({this.localDataSource});
  @override
  Future<List<ContactEntity>> getDeviceNumber() {
   return localDataSource.getDeviceNumber();
  }

}