import 'dart:async';
import 'package:delivery_app/repositories/product/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo _productRepo;
  StreamSubscription? _productSubscription;
  ProductBloc({required ProductRepo productRepo})
      : _productRepo = productRepo,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(__onUpdateProducts);
  }

  void _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) {
    _productSubscription?.cancel();
    _productSubscription = _productRepo.getAllProducts().listen(
          (product) => add(
            UpdateProducts(product),
          ),
        );
  }

  void __onUpdateProducts(
    UpdateProducts event,
    Emitter<ProductState> emit,
  ) {
    emit(ProductLoaded(products: event.products));
  }
}
