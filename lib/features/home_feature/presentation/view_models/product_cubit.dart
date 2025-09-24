import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:supplements_app/features/home_feature/data/product_model.dart';
import 'package:supplements_app/features/home_feature/data/product_repository.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;
  StreamSubscription? _subscription;

  ProductCubit(this.repository) : super(const ProductState.initial());

  Future<void> initialize() async {
    emit(state.copyWith(status: ProductStatus.loading, errorMessage: ''));
    try {
      await repository.seedFakeProductsIfEmpty();
      subscribeToProducts();
    } catch (e) {
      emit(
        state.copyWith(status: ProductStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void subscribeToProducts() {
    emit(state.copyWith(status: ProductStatus.loading, errorMessage: ''));
    _subscription?.cancel();
    _subscription = repository.streamProducts().listen(
      (products) {
        emit(state.copyWith(status: ProductStatus.success, products: products));
      },
      onError: (e) {
        emit(
          state.copyWith(
            status: ProductStatus.error,
            errorMessage: e.toString(),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
