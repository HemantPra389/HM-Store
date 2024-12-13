import 'package:dartz/dartz.dart';
import 'package:hm_store/core/error.dart';
import 'package:hm_store/feature/main_app/domain/entities/category_entity.dart';

import '../entities/product_section_entity.dart';

abstract class AppRepository {
  Future<Either<CustomError,List<CategoryEntity>>> fetchCategory();
  Future<Either<CustomError,ProductSectionEntity>> fetchProductSection({required String tagCodes,required int page});
}