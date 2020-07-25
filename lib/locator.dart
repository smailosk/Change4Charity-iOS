import 'package:change4charity/services/repository_service.dart';
import 'package:change4charity/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
export 'package:change4charity/services/navigation_service.dart';
export 'package:change4charity/services/repository_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => RepositoryService());
}
