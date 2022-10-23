part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCatgories extends CategoryEvent {}

class UpdateCatgories extends CategoryEvent {
  final List<Category> categories;

  const UpdateCatgories(this.categories);
  @override
  List<Object> get props => [categories];
}
