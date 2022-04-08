import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() {
  runApp(const AppState());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color.fromRGBO(34, 40, 58, 1),
  ));
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Generic Movie app',
      initialRoute: "home",
      routes: <String, Widget Function(BuildContext)>{
        "home": (_) => const HomeScreen(),
        "details": (_) => const DetailScreen()
      },
      theme: ThemeData.dark().copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          border: OutlineInputBorder(
              gapPadding: 10,
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          filled: true,
        ),
        appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color.fromRGBO(34, 40, 58, 1),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.blue)),
        scaffoldBackgroundColor: const Color.fromRGBO(34, 40, 58, 1),
      ),
    );
  }
}
