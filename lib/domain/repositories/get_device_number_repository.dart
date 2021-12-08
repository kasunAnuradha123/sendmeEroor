

import 'package:sendme/domain/entities/contact_entitiy.dart';

abstract class GetDeviceNumberRepository{
  Future<List<ContactEntity>>getDeviceNumber();
}