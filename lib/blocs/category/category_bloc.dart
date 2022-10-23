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
    on<LoadCatgories>(_mapLoadCatgoriesToState);
    on<UpdateCatgories>(_mapUpdateCatgoriesToState);
  }

  void _mapLoadCatgoriesToState(
      LoadCatgories event, Emitter<CategoryState> emit) async {}

  void _mapUpdateCatgoriesToState(
      UpdateCatgories event, Emitter<CategoryState> emit) async {}
}
