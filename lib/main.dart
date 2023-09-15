import 'package:beinex_test/utils/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(AppRouter()));
}

class MyApp extends StatelessWidget {
  AppRouter router;

  MyApp(this.router, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beinex Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      onGenerateRoute: router.generateRoute,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


