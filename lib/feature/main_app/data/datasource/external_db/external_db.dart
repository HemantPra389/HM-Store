import 'package:dartz/dartz.dart';
import 'package:hm_store/core/error.dart';
import 'package:hm_store/feature/main_app/domain/entities/category_entity.dart';

import '../../../domain/entities/product_section_entity.dart';

abstract class ExternalDb {
  Future<Either<CustomError,List<CategoryEntity>>> fetchCategory();
  Future<Either<CustomError, ProductSectionEntity>> fetchProductSection();
}