import 'package:delivery_app/models/wishlist_model.dart';
import 'package:delivery_app/repositories/local_storage/local_storage_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../models/product_model.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final LocalStorageRepo _localStorageRepo;
  WishlistBloc({required LocalStorageRepo localStorageRepo})
      : _localStorageRepo = localStorageRepo,
        super(WishlistLoading()) {
    on<StartWishList>(_mapStartWishListToState);
    on<AddtWishListProduct>(_mapAddWishListProductToState);
    on<RemovetWishListProduct>(_mapRemoveWishListProductToState);
  }

  Future<void> _mapStartWishListToState(
    StartWishList event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      Box box = await _localStorageRepo.openBox();
      List<Product> products = _localStorageRepo.getWishList(box);
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        WishlistLoaded(wishList: WishList(products: products)),
      );
    } catch (_) {
      emit(WishlistError());
    }
  }

  Future<void> _mapAddWishListProductToState(
    AddtWishListProduct event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepo.openBox();
        _localStorageRepo.addProductToWishlist(box, event.product);
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

  Future<void> _mapRemoveWishListProductToState(
    RemovetWishListProduct event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepo.openBox();
        _localStorageRepo.removeProductToWishlist(box, event.product);
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
