import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hm_store/feature/main_app/domain/entities/product_section_entity.dart';
import 'package:hm_store/feature/main_app/domain/usecases/product_usecase.dart';

import '../../../../../injection_container.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProductsList>((event, emit) async {
      emit(ProductsListLoadingState());
      final res =
          await locator.call<ProductUsecase>().fetchProductSectionUsecase();
      res.fold((l) => emit(ProductsListErrorState(errorMessage: l.message)),
          (r) => emit(ProductsListSuccessState(productSectionEntity: r)));
    });
  }
}
