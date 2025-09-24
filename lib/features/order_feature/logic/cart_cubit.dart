import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplements_app/features/order_feature/data/cart_repository.dart';

class CartState extends Equatable {
  final List<Map<String, dynamic>> items;
  final bool isLoading;
  final String? error;

  const CartState({required this.items, this.isLoading = false, this.error});

  CartState copyWith({
    List<Map<String, dynamic>>? items,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [items, isLoading, error];
}

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;

  CartCubit(this._repository) : super(const CartState(items: []));

  Future<void> initialize() async {
    emit(state.copyWith(isLoading: true));
    try {
      final loaded = await _repository.loadCart();
      emit(CartState(items: loaded));
    } catch (e) {
      emit(CartState(items: const [], error: 'Failed to load cart'));
    }
  }

  Future<void> addItem(Map<String, dynamic> item) async {
    final newItems = List<Map<String, dynamic>>.from(state.items)..add(item);
    emit(state.copyWith(items: newItems));
    await _repository.saveCart(newItems);
  }

  Future<void> removeAt(int index) async {
    final newItems = List<Map<String, dynamic>>.from(state.items)
      ..removeAt(index);
    emit(state.copyWith(items: newItems));
    await _repository.saveCart(newItems);
  }

  Future<void> clear() async {
    emit(state.copyWith(items: const []));
    await _repository.saveCart(const []);
  }

  int get count => state.items.length;
}
