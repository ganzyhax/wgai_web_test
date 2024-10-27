import 'package:get_it/get_it.dart';
import 'package:wg_app/app/screens/community/pages/news/bloc/news_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => NewsBloc());
}
