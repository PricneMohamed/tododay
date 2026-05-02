import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tododay/screens/todolisttoday_screen.dart';
import 'package:tododay/widget/custom_btn.dart';
import 'package:tododay/widget/custom_fieldtext.dart';
import 'package:tododay/widget/main/dialog_alert.dart';
import 'package:tododay/widget/main/myloading.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  @override
  String email = "";
  bool emailisGood = true;
  String password = "";
  bool passwordisGood = true;
  String Confirmpassword = "";
  bool ConfirmpasswordisGood = true;
  bool isLoading = false;

  final _auth = FirebaseAuth.instance;
  late User user;
  Widget build(BuildContext context) {
    if (isLoading) {
      return Myloading();
    }

    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            "انشئ حسابك الان و انضم الينا ",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            child: Column(
              spacing: 40,
              children: [
                // CustomTextField(
                //   icon: Icon(Icons.person),
                //   type: TextInputType.text,
                //   text: 'الاسم الاول',
                //   hint: 'محمد',
                //   obscure: false,
                //   onChanged: (value) {
                //     print(value);
                //   },
                // ),
                // CustomTextField(
                //   icon: Icon(Icons.family_restroom),
                //   type: TextInputType.text,
                //   text: 'الاسم الثاني',
                //   hint: 'حنفي',
                //   obscure: false,
                //   onChanged: (value) {
                //     print(value);
                //   },
                // ),
                CustomTextField(
                  icon: Icon(Icons.email),
                  type: TextInputType.streetAddress,
                  state: emailisGood,
                  text: 'البريد الالكتروني',
                  hint: 'prince@example.com',
                  obscure: false,
                  onChanged: (value) {
                    email = value;
                    print(email);
                  },
                ),

                CustomTextField(
                  icon: Icon(Icons.security),
                  type: TextInputType.visiblePassword,
                  state: passwordisGood,
                  text: 'كلمة السر',
                  hint: '***********',
                  obscure: true,
                  onChanged: (value) {
                    password = value;
                    print(password);
                  },
                ),
                CustomTextField(
                  icon: Icon(Icons.security),
                  type: TextInputType.visiblePassword,
                  state: ConfirmpasswordisGood,
                  text: 'تأكيد كلمة السر',
                  hint: '**********',
                  obscure: true,
                  onChanged: (value) {
                    Confirmpassword = value;

                    print(Confirmpassword);
                  },
                ),
                CustomBtn(
                  onPressed: () {
                    setState(() async {
                      isLoading = true;
                      if (!email.contains("@") || !email.contains(".")) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'بريد إلكتروني غير صالح',
                          text: 'تأكد من كتابة البريد الإلكتروني بشكل صحيح.',
                        );
                        return;
                      } else {
                        emailisGood = true;
                      }
                      if (password.length < 6) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'كلمة المرور ضعيفة',
                          text: 'يجب أن تكون كلمة المرور 6 أحرف على الأقل.',
                        );
                        return;
                      } else {
                        passwordisGood = true;
                      }
                      if (Confirmpassword.isEmpty) {
                        ConfirmpasswordisGood = false;
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'حقل مطلوب',
                          text: 'من فضلك أدخل تأكيد كلمة المرور.',
                          confirmBtnText: "تمام",
                          confirmBtnColor: Colors.teal,
                        );
                        return;
                      } else {
                        ConfirmpasswordisGood = true;
                      }

                      if (password != Confirmpassword) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'خد بالك 😊',
                          text: 'كلمة المرور مش زي التأكيد، راجعهم تاني.',
                          confirmBtnText: "تمام",
                          confirmBtnColor: Colors.teal,
                        );
                        return;
                      }
                      if (emailisGood &&
                          passwordisGood &&
                          ConfirmpasswordisGood) {
                        try {
                          final user = await _auth
                              .createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                          print("user => ${user}");
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: 'تم بنجاح 🎉',
                            text:
                                'تم إنشاء الحساب بنجاح، يمكنك تسجيل الدخول الآن.',
                            confirmBtnText: "تمام",
                            confirmBtnColor: Colors.teal,
                          );

                          Navigator.of(
                            context,
                          ).pushNamed(TodolisttodayScreen.screenRoute);
                        } on FirebaseException catch (e) {
                          String message = "";
                          if (e.code == 'email-already-in-use') {
                            message = 'البريد الإلكتروني مستخدم بالفعل.';
                          } else if (e.code == 'weak-password') {
                            message = 'كلمة المرور ضعيفة جدًا.';
                          } else if (e.code == 'invalid-email') {
                            message = 'البريد الإلكتروني غير صالح.';
                          } else {
                            message = 'حدث خطأ، حاول مرة أخرى.';
                          }
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: 'Oops...',
                            text: '$message',
                          );
                        } finally {
                          isLoading = false;
                        }
                      }
                    });
                  },
                  color: Colors.teal,
                  text: "انشاء حساب",
                  textColor: Colors.white,
                  icon: Icon(Icons.create, size: 30),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
