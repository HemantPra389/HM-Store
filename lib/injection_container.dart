import 'package:get_it/get_it.dart';
import 'package:hm_store/feature/main_app/data/datasource/external_db/external_db.dart';
import 'package:hm_store/feature/main_app/data/datasource/external_db/external_db_impl.dart';
import 'package:hm_store/feature/main_app/data/repository/app_repository_impl.dart';
import 'package:hm_store/feature/main_app/domain/repository/app_repository.dart';
import 'package:hm_store/feature/main_app/domain/usecases/category_usecase.dart';
import 'package:hm_store/feature/main_app/domain/usecases/product_usecase.dart';

GetIt locator = GetIt.instance;
Future init() async {
  //UseCases
  locator.registerLazySingleton<CategoryUsecase>(
      () => CategoryUsecase(appRepository: locator()));
  locator.registerLazySingleton<ProductUsecase>(
      () => ProductUsecase(appRepository: locator()));

  //Repository
  locator.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(externalDb: locator()));

  //DataSource
  //ExternalDB
  locator.registerLazySingleton<ExternalDb>(
      () => ExternalDbImpl());
}
