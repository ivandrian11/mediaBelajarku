import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/view_model/helper_vm.dart';
import 'package:media_belajarku/widgets/reusable_button.dart';
import 'package:media_belajarku/widgets/auth_container.dart';
import 'package:media_belajarku/widgets/field_nonpassword.dart';
import 'package:media_belajarku/widgets/field_password.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/view_model/user_vm.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final usernameC = TextEditingController();
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameC.dispose();
    nameC.dispose();
    emailC.dispose();
    passwordC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthContainer(
              title: 'Daftar',
              subtitle: 'Yuk daftar untuk mulai belajar sekarang',
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Column(
                children: [
                  // * Username
                  FieldNonPassword(
                    controller: usernameC,
                    label: 'Username',
                    icon: Icon(Icons.person, size: 24.h),
                  ),
                  SizedBox(height: 20.h),
                  // * Nama Lengkap
                  FieldNonPassword(
                    controller: nameC,
                    label: 'Nama Lengkap (Sertifikat)',
                    icon: Icon(Icons.contact_page, size: 24.h),
                  ),
                  SizedBox(height: 20.h),
                  // * Email
                  FieldNonPassword(
                    controller: emailC,
                    label: 'Email',
                    icon: Icon(Icons.mail, size: 24.h),
                  ),
                  SizedBox(height: 20.h),
                  // * Password
                  Consumer<HelperVM>(
                    builder: (context, controller, _) => FieldPassword(
                      controller: passwordC,
                      onPressed: () => controller.toggleObscureP(),
                      isObscure: controller.isObscureP,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Consumer<UserVM>(
                    builder: (context, provider, _) => ReusableButton(
                        style: buttonStyle,
                        isLoading: provider.isLoading,
                        text: 'Daftar',
                        onPressed: () {
                          if (usernameC.text.isEmpty ||
                              nameC.text.isEmpty ||
                              emailC.text.isEmpty ||
                              passwordC.text.isEmpty) {
                            showErrorMessage("Input field must not be empty");
                          } else {
                            if (passwordC.text.length < 8) {
                              showErrorMessage(
                                  "Your password must be at least 8 characters long.");
                            } else {
                              provider.registerUser(
                                usernameC.text,
                                nameC.text,
                                emailC.text,
                                passwordC.text,
                              );
                            }
                          }
                        }),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sudah punya akun? ', style: standardStyle),
                      InkWell(
                        onTap: () {
                          Navigation.off('/login');
                        },
                        child: Text(
                          'Yuk masuk',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: primaryColor,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
