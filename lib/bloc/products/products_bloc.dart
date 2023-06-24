// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic5_bloc_ecatalog/data/datasources/product_datasource.dart';
import 'package:fic5_bloc_ecatalog/model/response/product_response_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductDataSource dataSource;
  ProductsBloc(
    this.dataSource,
  ) : super(ProductsInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductsLoading());
      final result = await dataSource.getPaginationProduct(
        limit: 20,
        offset: 0,
      );
      result.fold((error) => emit(ProductsError(message: error)), (result) {
        bool isNext = result.length == 20;
        emit(
          ProductsSuccess(
            data: result,
            isNext: isNext,
          ),
        );
      });
    });

    on<NextProductsEvent>((event, emit) async {
      final currenState = state as ProductsSuccess;
      final result = await dataSource.getPaginationProduct(
          limit: 20, offset: currenState.offset + 20);
      result.fold(
        (error) => emit(ProductsError(message: error)),
        (result) {
          bool isNext = result.length == 20;
          emit(
            ProductsSuccess(
              data: [...currenState.data, ...result],
              offset: currenState.offset + 20,
              isNext: isNext,
            ),
          );
        },
      );
    });

    on<AddSingleProductsEvent>(
      (event, emit) async {
        final currenState = state as ProductsSuccess;

        emit(
          ProductsSuccess(
            data: [
              ...currenState.data,
              event.data,
            ],
          ),
        );
      },
    );

    on<ClearProductsEvent>(
      (event, emit) async {
        emit(ProductsInitial());
      },
    );
  }
}
