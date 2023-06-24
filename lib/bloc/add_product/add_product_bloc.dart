// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic5_bloc_ecatalog/model/request/product_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic5_bloc_ecatalog/data/datasources/product_datasource.dart';
import 'package:fic5_bloc_ecatalog/model/response/product_response_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductDataSource dataSource;
  AddProductBloc(
    this.dataSource,
  ) : super(AddProductInitial()) {
    on<DoAddProductEvent>((event, emit) async {
      emit(AddProductLoading());

      final result = await dataSource.createProduct(event.model);
      result.fold((error) {
        emit(AddProductError(message: error));
      }, (data) {
        emit(AddProductSuccess(model: data));
      });
    });
  }
}
