import 'package:flutter/material.dart';
import 'package:size_config/util/size_extention.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/view_model/helper_vm.dart';
import 'package:provider/provider.dart';
import 'package:media_belajarku/view_model/preferences_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
import 'package:media_belajarku/widgets/reusable_button.dart';
import 'package:media_belajarku/widgets/auth_container.dart';
import 'package:media_belajarku/widgets/field_nonpassword.dart';
import 'package:media_belajarku/widgets/field_password.dart';
import 'package:media_belajarku/common/styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passwordC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preferencesP = Provider.of<PreferencesVM>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          AuthContainer(
            title: 'Masuk',
            subtitle: 'Yuk masuk untuk melanjutkan belajarmu',
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Column(
              children: [
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigation.intent('/forget_password'),
                    child: Text(
                      'Lupa password?',
                      style: TextStyle(
                        fontWeight: semiBold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Consumer<UserVM>(
                  builder: (context, provider, _) => ReusableButton(
                      style: buttonStyle,
                      isLoading: provider.isLoading,
                      text: 'Masuk',
                      onPressed: () {
                        if (emailC.text.isEmpty || passwordC.text.isEmpty) {
                          showErrorMessage("Input field must not be empty");
                        } else {
                          provider.loginUser(
                            emailC.text,
                            passwordC.text,
                            preferencesP.setLogged,
                          );
                        }
                      }),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Belum punya akun? ', style: standardStyle),
                    InkWell(
                      onTap: () {
                        Navigation.off('/register');
                      },
                      child: Text(
                        'Yuk daftar',
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
    );
  }
}
