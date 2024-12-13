part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductsList extends ProductEvent{
  final String tagCodes;
  final int page;
  const FetchProductsList({required this.tagCodes,required this.page});
  @override
  List<Object> get props => [tagCodes,page];
}