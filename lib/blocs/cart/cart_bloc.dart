import 'package:delivery_app/blocs/checkout/checkout_bloc.dart';
import 'package:delivery_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>(_onCartStartedToState);
    on<CartProductAdded>(_onCartAddToState);
    on<CartProductRemoved>(_onCartRemoveToState);
  }

  void _onCartStartedToState(
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

  void _onCartAddToState(
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

  void _onCartRemoveToState(
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
