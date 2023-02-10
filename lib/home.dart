import 'package:admin/request_page.dart';
import 'package:admin/utils/my_textstyles.dart';
import 'package:admin/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils/my_colors.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final nameCntr = TextEditingController();
  final emailCntr = TextEditingController();

  checkValidations() {
    if (nameCntr.text.trim() == '' || emailCntr.text.trim() == '') {
      Utils.showAlert(
        'Alert!',
        'please make sure you have filled all the fields before submiting.n',
      );
      return;
    }

    if (nameCntr.text.trim().length < 3) {
      Utils.showAlert(
        'Alert!',
        'please enter the valid username.',
      );
      return;
    }

    // -------------------------------- email
    if (!emailCntr.text.contains('@') || !emailCntr.text.contains('.')) {
      Utils.showAlert(
        'Alert!',
        'please enter the valid email address.',
      );
      return;
    }

    final id = 'id:${nameCntr.text.trim()}~~~${emailCntr.text.trim()}}';

    addAdmins(id);
  }

  addAdmins(String id) {
    try {
      FirebaseFirestore.instance.collection('admins').doc(id).set({
        'id': id,
        'email': emailCntr.text.trim(),
        'name': nameCntr.text.trim(),
      });

      nameCntr.clear();
      emailCntr.clear();
      Utils.showSnackBar('Hurray!, admins updated.');
    } catch (e) {
      Utils.showAlert(
        'Oops!',
        'Something went wrong, please check your internet connection and try again.',
      );
    }
  }

  deleteAdmins(String id) {
    try {
      FirebaseFirestore.instance.collection('admins').doc(id).delete();
    } catch (e) {
      Utils.showAlert(
        'Oops!',
        'Something went wrong, please check your internet connection and try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greenland Admin Panel'),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const RequestPage()),
            icon: const Icon(Icons.crisis_alert_rounded),
          )
        ],
      ),
      body: Center(
        child: Container(
          color: MyColors.whiteScaffoldBG,
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ---------------------------------- title
              Text(
                'Enter your credentials:',
                style: GoogleFonts.berkshireSwash(
                  textStyle: MyTStyles.kTS20Bold,
                  color: MyColors.emerald,
                ),
              ),
              const SizedBox(height: 15),
              // ---------------------------------- name
              TextFieldWrapper(
                TextField(
                  controller: nameCntr,
                  style: MyTStyles.kTS20Medium,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Admin name:',
                    hintStyle: MyTStyles.kTS15Medium,
                  ),
                ),
                Icons.short_text,
              ),
              // ---------------------------------- email
              TextFieldWrapper(
                TextField(
                  controller: emailCntr,
                  style: MyTStyles.kTS20Medium,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Admin email:',
                    hintStyle: MyTStyles.kTS15Medium,
                  ),
                ),
                Icons.email_outlined,
              ),
              // ---------------------------------- submit
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: checkValidations,
                  child: const Text('Submit'),
                ),
              ),

              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('admins')
                      .snapshots(),
                  builder: (context, snapshot) {
                    final snapData = snapshot.data;

                    if (snapData == null || snapData.docs.isEmpty) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            SizedBox(height: 40),
                            Icon(Icons.bubble_chart_outlined, size: 30),
                            SizedBox(height: 5),
                            Text(
                              'there are no admins for now\nadd some!',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Current Admins:',
                          style: GoogleFonts.berkshireSwash(
                            textStyle: MyTStyles.kTS20Bold,
                            color: MyColors.emerald,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapData.docs.length,
                            itemBuilder: (context, index) {
                              final adminData = snapData.docs[index].data();

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Container(
                                  color: Colors.teal.shade200.withAlpha(100),
                                  child: ListTile(
                                    title: Text(
                                      adminData['name'],
                                      style: MyTStyles.kTS16Medium,
                                    ),
                                    subtitle: Text(
                                      adminData['email'],
                                      style: MyTStyles.kTS16Medium,
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: MyColors.darkPink,
                                      ),
                                      onPressed: () =>
                                          deleteAdmins(adminData['id']),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWrapper extends StatelessWidget {
  const TextFieldWrapper(this.widget, this.icon, {super.key});

  final Widget widget;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.teal,
          ),
          const SizedBox(width: 10),
          Expanded(child: widget),
        ],
      ),
    );
  }
}
