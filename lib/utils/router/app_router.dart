import 'package:beinex_test/utils/router/router_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/splash_screen/cubit/splash_cubit.dart';
import '../../core/splash_screen/splash_screen.dart';
import '../../modules/dashboard/cubit/dashboard_cubit.dart';
import '../../modules/dashboard/data_model/pass_mock_data.dart';
import '../../modules/dashboard/view/dashboard.dart';
import '../../modules/details/cubit/details_cubit.dart';
import '../../modules/details/view/details_screen.dart';
import '../../network/network_service.dart';
import '../../repository/repository.dart';

class AppRouter {
  late Repository repository;

  AppRouter() {
    repository = Repository(NetworkService());
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (BuildContext context) => SplashCubit(repository),
              child: SplashScreen(),
            ));

      case dashboard:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (BuildContext context) => DashboardCubit(repository),
              child: DashboardScreen(),
            ));

      case details:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (BuildContext context) => DetailsCubit(repository),
              child: DetailsScreen(settings.arguments as MockPassingData),
            ));


    }
  }

}