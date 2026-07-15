import 'package:elitestate/firebase_options.dart';
import 'package:elitestate/view/Bottom_navigation/Bottombar.dart';
import 'package:elitestate/view/splashscreen/splashscreen.dart';

import 'package:elitestate/view_model/add_propertyviewmodel.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:elitestate/view_model/bottombar_viewmodel.dart';
import 'package:elitestate/view_model/homeviewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => BottomNavViewModel()),

        ChangeNotifierProvider(create: (_) => PropertyViewModel()),
        ChangeNotifierProvider(create: (_) => Homeviewmodel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData(primarySwatch: Colors.blue),
          home: Splashscreen(),
        );
      },
    );
  }
}
