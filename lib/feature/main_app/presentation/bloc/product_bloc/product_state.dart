part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class ProductsListLoadingState extends ProductState {}

class ProductsListErrorState extends ProductState {
  final String errorMessage;
  const ProductsListErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ProductsListSuccessState extends ProductState {
  final ProductSectionEntity productSectionEntity;
  const ProductsListSuccessState({required this.productSectionEntity});
  @override
  List<Object> get props => [productSectionEntity];
}
