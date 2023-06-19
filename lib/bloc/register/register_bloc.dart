// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic5_bloc_ecatalog/model/request/register_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic5_bloc_ecatalog/data/datasources/auth_datasource.dart';
import 'package:fic5_bloc_ecatalog/model/response/register_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDatasource datasource;

  RegisterBloc(
    this.datasource,
  ) : super(RegisterInitial()) {
    on<DoRegisterEvent>((event, emit) async {
      emit(RegisterLoading());

      final result = await datasource.register(event.model);
      result.fold((error) {
        RegisterError(message: error);
      }, (data) {
        emit(RegisterSuccess(model: data));
      });

      // emit(RegisterSuccess());
    });
  }
}
