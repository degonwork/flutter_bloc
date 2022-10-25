import 'dart:async';

import 'package:delivery_app/models/category_model.dart';
import 'package:delivery_app/repositories/category/category_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepo _categoryRepo;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRepo categoryRepo})
      : _categoryRepo = categoryRepo,
        super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategories>(_onUpdateCategories);
  }

  void _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) {
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepo.getAllCategories().listen(
          (products) => add(
            UpdateCategories(products),
          ),
        );
  }

  void _onUpdateCategories(
    UpdateCategories event,
    Emitter<CategoryState> emit,
  ) {
    emit(
      CategoryLoaded(categories: event.categories),
    );
  }
}
