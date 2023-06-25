// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fic5_bloc_ecatalog/model/response/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic5_bloc_ecatalog/data/datasources/product_datasource.dart';
import 'package:fic5_bloc_ecatalog/model/request/product_request_model.dart';

part 'update_product_cubit.freezed.dart';
part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductStateCubit> {
  final ProductDataSource dataSource;
  UpdateProductCubit(
    this.dataSource,
  ) : super(const UpdateProductStateCubit.initial());

  void addProduct(ProductRequestModel model) async {
    final result = await dataSource.createProduct(model);
    result.fold(
      (l) => emit(_Error(l)),
      (r) => emit(_Success(r)),
    );
  }
}
