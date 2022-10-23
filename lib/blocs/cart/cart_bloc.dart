import 'package:delivery_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>(_mapCartStartedToState);
    on<CartProductAdded>(_mapCartAddToState);
    on<CartProductRemoved>(_mapCartRemoveToState);
  }

  void _mapCartStartedToState(
    CartStarted event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        const CartLoaded(),
      );
    } catch (_) {
      emit(CartError());
    }
  }

  void _mapCartAddToState(
    CartProductAdded event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from((state as CartLoaded).cart.products)
                ..add(event.product),
            ),
          ),
        );
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _mapCartRemoveToState(
    CartProductRemoved event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from((state as CartLoaded).cart.products)
                ..remove(event.product),
            ),
          ),
        );
      } catch (_) {
        emit(CartError());
      }
    }
  }
}
