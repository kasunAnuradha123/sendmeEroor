

import 'package:contacts_service/contacts_service.dart';
import 'package:sendme/domain/entities/contact_entitiy.dart';

abstract class LocalDataSource{
  Future<List<ContactEntity>>getDeviceNumber();
}

class LocalDataSourceImpl implements LocalDataSource{
  @override
  Future<List<ContactEntity>> getDeviceNumber() async{
    List<ContactEntity>contacts=[];
    final getContactsData=await ContactsService.getContacts();
    
    getContactsData.forEach((myContact) {
      myContact.phones.forEach((phoneData) { 
        contacts.add(ContactEntity(
          phoneNumber: phoneData.value,
          label: myContact.displayName,
        ));
      });
    });
    return contacts;
  }

}