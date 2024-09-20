
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/firebase_options.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/pages/startpage.dart';
import 'package:flower_app/provider/GoogleSignInProvider.dart';
import 'package:flower_app/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/Cart.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // للتحقق من الحساب باستخدام قاعده البيانات
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // اذا كان يوجد مشكله بالاتصال بين التطبيق وقاعده البيانات
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }
              // اذا كان في خطأ في البيانات الراجعه من قاعده البيانات
              else if (snapshot.hasError) {
                return showSnackBar(context, "Something went wrong");
              }
              // اذا كانت البيانات متطابقه مع قاعده البيانات
              else if (snapshot.hasData) {
                return  const Home();
              } else {
                return   const StartPage();
              }
            },
          )),
    );
  }
}
