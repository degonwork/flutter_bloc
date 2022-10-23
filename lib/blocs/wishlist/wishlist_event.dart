part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class StartWishList extends WishlistEvent {
  @override
  List<Object> get props => [];
}

class AddtWishListProduct extends WishlistEvent {
  final Product product;

  const AddtWishListProduct(this.product);
  @override
  List<Object> get props => [product];
}

class RemovetWishListProduct extends WishlistEvent {
  final Product product;

  const RemovetWishListProduct(this.product);
  @override
  List<Object> get props => [product];
}
