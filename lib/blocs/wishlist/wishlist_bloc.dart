import 'package:delivery_app/models/wishlist_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/product_model.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishList>(_mapStartWishListToState);
    on<AddtWishListProduct>(_mapAddWishListProductToState);
    on<RemovetWishListProduct>(_mapRemoveWishListProductToState);
  }

  void _mapStartWishListToState(
    StartWishList event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        const WishlistLoaded(),
      );
    } catch (_) {
      emit(WishlistError());
    }
  }

  void _mapAddWishListProductToState(
    AddtWishListProduct event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      try {
        emit(
          WishlistLoaded(
            wishList: WishList(
              products: List.from((state as WishlistLoaded).wishList.products)
                ..add(event.product),
            ),
          ),
        );
      } catch (_) {
        emit(WishlistError());
      }
    }
  }

  void _mapRemoveWishListProductToState(
    RemovetWishListProduct event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      try {
        emit(
          WishlistLoaded(
            wishList: WishList(
              products: List.from((state as WishlistLoaded).wishList.products)
                ..remove(event.product),
            ),
          ),
        );
      } catch (_) {
        emit(WishlistError());
      }
    }
  }
}
