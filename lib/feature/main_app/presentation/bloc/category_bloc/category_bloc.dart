import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hm_store/feature/main_app/domain/entities/category_entity.dart';
import 'package:hm_store/feature/main_app/domain/usecases/category_usecase.dart';

import '../../../../../injection_container.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategoryEvent>((event, emit) async {
      emit(CategoryListLoadingState());
      final res = await locator.call<CategoryUsecase>().fetchCategoryUsecase();
      res.fold((l) => emit(CategoryListErrorState(errorMessage: l.message)),
          (r) => emit(CategoryListSuccessState(categoryEntity: r)));
    });
  }
}
