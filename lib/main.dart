import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:foodlink/controllers/auth_controller.dart';
import 'package:foodlink/provider/app_data.dart';
import 'package:foodlink/provider/cart_provider.dart';
import 'package:foodlink/provider/favourite_provider.dart';
import 'package:foodlink/provider/product_provider.dart';
import 'package:foodlink/views/screens/auth/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(
    riverpod.ProviderScope(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppData()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => FavouriteProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodLink',
      home: LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}
