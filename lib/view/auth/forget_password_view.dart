import 'package:flutter/material.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/view_model/helper_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
import 'package:media_belajarku/widgets/field_nonpassword.dart';
import 'package:media_belajarku/widgets/field_password.dart';
import 'package:media_belajarku/widgets/reusable_button.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  String? username;
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passwordC.dispose();
    confirmPasswordC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lupa Kata Sandi', style: appBarStyle)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: margin),
          child: Column(
            children: [
              SizedBox(height: 24.h),
              Text(
                'Untuk keamanan sistem, silahkan verifikasi identitas dengan memasukkan email kamu.',
                textAlign: TextAlign.center,
                style: standardStyle,
              ),
              SizedBox(height: 24.h),
              FieldNonPassword(
                controller: emailC,
                label: 'Email',
                icon: Icon(Icons.mail, size: 24.h),
                isLastField: true,
              ),
              Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: username != null,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Consumer<HelperVM>(
                      builder: (context, provider, _) => FieldPassword(
                        controller: passwordC,
                        onPressed: () => provider.toggleObscureP(),
                        isObscure: provider.isObscureP,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Consumer<HelperVM>(
                      builder: (context, provider, _) => FieldPassword(
                        controller: confirmPasswordC,
                        label: "Konfirmasi Password",
                        onPressed: () => provider.toggleObscureCP(),
                        isObscure: provider.isObscureCP,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Consumer<UserVM>(
                builder: (context, provider, _) => ReusableButton(
                  style: buttonStyle,
                  isLoading: provider.isLoading,
                  text: username != null ? 'Perbarui' : 'Lanjut',
                  onPressed: username != null
                      ? () {
                          if (emailC.text.isEmpty ||
                              passwordC.text.isEmpty ||
                              confirmPasswordC.text.isEmpty) {
                            showErrorMessage("Input field must not be empty");
                          } else {
                            if (passwordC.text.length < 8) {
                              showErrorMessage(
                                  "Your password must be at least 8 characters long.");
                            } else {
                              provider.forgetPasswordUser(
                                username!,
                                passwordC.text,
                                confirmPasswordC.text,
                              );
                            }
                          }
                        }
                      : () {
                          if (emailC.text.isEmpty) {
                            showErrorMessage("Input field must not be empty");
                          } else {
                            provider.checkEmailUser(emailC.text).then((value) =>
                                setState(
                                    () => username = provider.response.data));
                          }
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
