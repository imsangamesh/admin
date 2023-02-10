import 'package:admin/utils/my_textstyles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';
import 'utils/my_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Greenland Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Colors.teal),
        scaffoldBackgroundColor: MyColors.whiteScaffoldBG,
        drawerTheme: const DrawerThemeData(
          backgroundColor: MyColors.whiteScaffoldBG,
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.quicksand(
            textStyle: MyTStyles.kTS20Regular.copyWith(
              fontWeight: FontWeight.w500,
              color: MyColors.black,
            ),
          ),
          centerTitle: true,
        ),
      ),
      home: Home(),
    );
  }
}
