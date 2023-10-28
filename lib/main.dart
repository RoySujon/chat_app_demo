import 'package:chat_app_demo/view/auth/splash_scren.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.dark,

      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.grey.shade100,
            shadowColor: Colors.grey.shade100,
            titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18)),
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),

      // home: const SplashScreen(),
      // initialRoute: RouteName.profileScreen,
      // home: HomeScreen(),
      home: SplashScreen(),
    );
  }
}
