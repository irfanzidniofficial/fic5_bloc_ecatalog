part of 'update_product_cubit.dart';

@freezed
class UpdateProductStateCubit with _$UpdateProductStateCubit {
  const factory UpdateProductStateCubit.initial() = _Initial;
  const factory UpdateProductStateCubit.loading() = _Loading;
  const factory UpdateProductStateCubit.success(ProductResponseModel model) =
      _Success;
  const factory UpdateProductStateCubit.error(String message) = _Error;
}
