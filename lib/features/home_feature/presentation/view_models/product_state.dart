part of 'product_cubit.dart';

enum ProductStatus { initial, loading, success, error }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<Product> products;
  final String errorMessage;

  const ProductState({
    required this.status,
    required this.products,
    required this.errorMessage,
  });

  const ProductState.initial()
    : status = ProductStatus.initial,
      products = const [],
      errorMessage = '';

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage];
}
