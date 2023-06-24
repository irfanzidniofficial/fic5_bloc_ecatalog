// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic5_bloc_ecatalog/model/request/product_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic5_bloc_ecatalog/data/datasources/product_datasource.dart';

import '../../model/response/product_response_model.dart';

part 'update_product_bloc.freezed.dart';
part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductDataSource dataSource;
  UpdateProductBloc(
    this.dataSource,
  ) : super(const _Initial()) {
    on<_DoUpdate>((event, emit) async {
      emit(const _Loading());
      final result = await dataSource.createProduct(event.requestData);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
