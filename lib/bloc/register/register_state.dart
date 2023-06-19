// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponseModel model;
  RegisterSuccess({
    required this.model,
  });
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError({
    required this.message,
  });
}
