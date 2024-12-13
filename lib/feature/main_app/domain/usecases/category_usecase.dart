import 'package:dartz/dartz.dart';
import 'package:hm_store/core/error.dart';
import 'package:hm_store/feature/main_app/domain/entities/category_entity.dart';
import 'package:hm_store/feature/main_app/domain/repository/app_repository.dart';

class CategoryUsecase {
  final AppRepository appRepository;
  const CategoryUsecase({required this.appRepository});
  Future<Either<CustomError, List<CategoryEntity>>> fetchCategoryUsecase() {
    return appRepository.fetchCategory();
  }
}
