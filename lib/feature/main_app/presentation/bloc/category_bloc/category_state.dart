part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

class CategoryListLoadingState extends CategoryState {}

class CategoryListSuccessState extends CategoryState {
  final List<CategoryEntity> categoryEntity;
  const CategoryListSuccessState({required this.categoryEntity});
  @override
  List<Object> get props => [categoryEntity];
}

class CategoryListErrorState extends CategoryState {
  final String errorMessage;
  const CategoryListErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
