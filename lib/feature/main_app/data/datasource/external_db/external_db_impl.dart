import 'package:dartz/dartz.dart';
import 'package:hm_store/core/error.dart';
import 'package:hm_store/core/http_handler.dart';
import 'package:hm_store/core/logger_helper.dart';
import 'package:hm_store/core/url_constants.dart';
import 'package:hm_store/feature/main_app/data/datasource/external_db/external_db.dart';
import 'package:hm_store/feature/main_app/domain/entities/category_entity.dart';
import 'package:hm_store/feature/main_app/domain/entities/product_section_entity.dart';

class ExternalDbImpl implements ExternalDb {
  @override
  Future<Either<CustomError, List<CategoryEntity>>> fetchCategory() async {
    try {
      final parseData = await THttpHandler.get(
          endPointUrl: TUrlConstants.categoryListUrl,
          queryParameters: {"lang": "en", "country": "us"});
      if (parseData != null) {
        List<CategoryEntity> dataList = [];
        parseData.forEach((e) => dataList.add(CategoryEntity.fromJson(e)));
        return Right(dataList);
      } else {
        return Left(CustomError("Unable to fetch data"));
      }
    } catch (e) {
      TLoggerHelper.error(e.toString());
      return Left(CustomError(e.toString()));
    }
  }

  @override
  Future<Either<CustomError, ProductSectionEntity>>
      fetchProductSection() async {
    // try {
    final parseData = await THttpHandler.get(
        endPointUrl: TUrlConstants.productListUrl,
        queryParameters: {
          "country": "us",
          "lang": "en",
          "currentpage": "0",
          "pageSize": "5",
          "categories": "men_all",
          "concepts": "H%26M%20MAN"
        });
    if (parseData != null) {
      return Right(ProductSectionEntity.fromJson(parseData));
    } else {
      return Left(CustomError("Unable to fetch data"));
    }
    // } catch (e) {
    //   TLoggerHelper.error(e.toString());
    //   return Left(CustomError(e.toString()));
    // }
  }
}
