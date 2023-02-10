import 'package:admin/utils/my_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'buttons.dart';
import 'my_colors.dart';

class Utils {
  //
  static void normalDialog() {
    showAlert(
      'Oops',
      'Sorry, something went wrong, please report us while We work on it.',
    );
  }

  // ------------------------------------------------------------------------------------ `default`
  static void showAlert(String title, String description,
      {bool? isDismissable}) {
    Get.defaultDialog(
      backgroundColor: Get.isDarkMode ? MyColors.lightPurple : MyColors.wheat,
      barrierDismissible: isDismissable ?? true,
      //
      content: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      title,
                      style: GoogleFonts.berkshireSwash(
                        textStyle: MyTStyles.kTS20Medium.copyWith(
                          color: MyColors.darkPink,
                        ),
                      ),
                    ),
                  ),
                ),
                const MyCloseBtn()
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                description,
                style: MyTStyles.kTS16Regular,
              ),
            ),
          ],
        ),
      ),
      //
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      titlePadding: EdgeInsets.zero,
      //
      middleText: '',
      middleTextStyle: const TextStyle(fontSize: 0),
      contentPadding: EdgeInsets.zero,
      //
    );
  }

  // ------------------------------------------------------------------------------------ `snack bar`
  static showSnackBar(String message, {bool? yes}) {
    Color myColor(int num) => yes == null
        ? Colors.amber
        : yes
            ? Colors.green
            : Colors.red;

    Get.showSnackbar(GetSnackBar(
      padding: const EdgeInsets.all(0),
      messageText: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: myColor(50),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: myColor(100)),
        ),
        child: Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              yes == null
                  ? Icons.add_alert_rounded
                  : yes
                      ? Icons.check
                      : Icons.close,
              size: 20,
              color: Colors.black,
            ),
            const SizedBox(width: 10),
            Text(
              message,
              style: TextStyle(
                  color: Get.isDarkMode ? MyColors.white : MyColors.black),
            ),
          ],
        )),
      ),
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      duration: const Duration(milliseconds: 2000),
    ));
  }

  // ------------------------------------------------------------------------------------ `loading`
  static progressIndctr({String? label}) {
    Get.dialog(Scaffold(
      backgroundColor: MyColors.pink.withOpacity(0.05),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: MyColors.pink.withAlpha(100),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: MyColors.wheat,
                  color: MyColors.pink,
                ),
              ),
            ),
            const SizedBox(height: 5),
            if (label != null)
              Text(
                label,
                style: MyTStyles.kTS18Medium.copyWith(color: MyColors.wheat),
              )
          ],
        ),
      ),
    ));
  }

  // ------------------------------------------------------------------------------------ `confirm`
  static void confirmDialogBox(
    String title,
    String description, {
    required VoidCallback yesFun,
    bool? isDismissable,
    VoidCallback? noFun,
  }) {
    Get.defaultDialog(
      backgroundColor: Get.isDarkMode ? MyColors.lightPurple : MyColors.wheat,
      barrierDismissible: isDismissable ?? true,
      //
      content: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      title,
                      style: GoogleFonts.berkshireSwash(
                        textStyle: MyTStyles.kTS20Medium.copyWith(
                          color: MyColors.darkPink,
                        ),
                      ),
                    ),
                  ),
                ),
                const MyCloseBtn()
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                description,
                style: MyTStyles.kTS16Regular,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyOutlinedBtn(
                    'Nope',
                    noFun ?? () => Get.back(),
                    icon: Icons.close_rounded,
                  ),
                  const Text('|'),
                  MyOutlinedBtn('Yup ', yesFun, icon: Icons.check_rounded),
                ],
              ),
            )
          ],
        ),
      ),
      //
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      titlePadding: EdgeInsets.zero,
      //
      middleText: '',
      middleTextStyle: const TextStyle(fontSize: 0),
      contentPadding: EdgeInsets.zero,
      //
    );
  }
}
