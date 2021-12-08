
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sendme/domain/entities/contact_entitiy.dart';
import 'package:sendme/domain/usecases/get_device_numbes_usecase.dart';
part 'get_device_numbers_state.dart';

class GetDeviceNumbersCubit extends Cubit<GetDeviceNumbersState>{
  final GetDeviceNumberUseCase getDeviceNumberUseCase;
  GetDeviceNumbersCubit({this.getDeviceNumberUseCase}) : super (GetDeviceNumbersInitial());

  Future<void> getDeviceNumber()async{
    try{
      final contactNumber= await getDeviceNumberUseCase.call();
      emit(GetDeviceNumbersLoaded(contacts: contactNumber));
    }catch(_){
      emit(GetDeviceNumbersFailure());
    }
  }
}