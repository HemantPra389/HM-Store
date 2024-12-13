import 'package:dartz/dartz.dart';
import 'package:hm_store/core/error.dart';
import 'package:hm_store/feature/main_app/data/datasource/external_db/external_db.dart';
import 'package:hm_store/feature/main_app/domain/entities/category_entity.dart';
import 'package:hm_store/feature/main_app/domain/entities/product_section_entity.dart';
import 'package:hm_store/feature/main_app/domain/repository/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final ExternalDb externalDb;
  const AppRepositoryImpl({required this.externalDb});
  @override
  Future<Either<CustomError, List<CategoryEntity>>> fetchCategory() {
    return externalDb.fetchCategory();
  }

  @override
  Future<Either<CustomError, ProductSectionEntity>> fetchProductSection({required String tagCodes,required int page}) {
    return externalDb.fetchProductSection(tagCodes:tagCodes,page:page);
  }
}
