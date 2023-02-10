import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_colors.dart';
import 'my_textstyles.dart';

class MyCloseBtn extends StatelessWidget {
  const MyCloseBtn({this.icon, this.ontap, super.key});

  final VoidCallback? ontap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: InkWell(
        onTap: ontap ?? () => Get.back(),
        borderRadius: BorderRadius.circular(30),
        splashColor: MyColors.pink,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.circle,
                color: MyColors.lightPink,
                size: 30,
              ),
            ),
            Icon(icon ?? Icons.close, size: 23, color: MyColors.darkPink),
          ],
        ),
      ),
    );
  }
}

class MyOutlinedBtn extends StatelessWidget {
  const MyOutlinedBtn(this.label, this.ontap, {this.icon, super.key});

  final VoidCallback? ontap;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? OutlinedButton(
            onPressed: ontap,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: BorderSide(width: 0.5, color: MyColors.pink.withAlpha(100)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            ),
            child: Text(
              label,
              style: MyTStyles.kTS16Medium.copyWith(color: MyColors.interPink),
            ),
          )
        : OutlinedButton.icon(
            onPressed: ontap,
            icon: Icon(icon, color: MyColors.interPink),
            label: Text(
              label,
              style: MyTStyles.kTS16Medium.copyWith(color: MyColors.interPink),
            ),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: BorderSide(width: 0.5, color: MyColors.pink.withAlpha(100)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            ),
          );
  }
}
