import 'package:dartz/dartz.dart';
import 'package:hm_store/core/error.dart';
import 'package:hm_store/feature/main_app/domain/entities/product_section_entity.dart';
import 'package:hm_store/feature/main_app/domain/repository/app_repository.dart';

class ProductUsecase {
  final AppRepository appRepository;
  const ProductUsecase({required this.appRepository});
  Future<Either<CustomError,ProductSectionEntity>> fetchProductSectionUsecase({required String tagCodes,required int page}){
    return appRepository.fetchProductSection(tagCodes: tagCodes,page: page);
  }
}