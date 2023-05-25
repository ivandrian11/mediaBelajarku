import 'package:flutter/material.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/user.dart';
import 'package:media_belajarku/view_model/helper_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';
import 'package:media_belajarku/widgets/field_password.dart';
import 'package:media_belajarku/widgets/reusable_button.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/widgets/white_appbar.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final oldPasswordC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    oldPasswordC.dispose();
    passwordC.dispose();
    confirmPasswordC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildWhiteAppBar('Ubah Password'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: margin),
          child: Column(
            children: [
              SizedBox(height: 24.h),
              Text(
                'Untuk mengamankan akunmu, silahkan verifikasi identitas dengan memasukkan password kamu saat ini.',
                textAlign: TextAlign.center,
                style: standardStyle,
              ),
              SizedBox(height: 24.h),
              Consumer<HelperVM>(
                builder: (context, provider, _) => FieldPassword(
                  label: "Password Saat Ini",
                  controller: oldPasswordC,
                  onPressed: () => provider.toggleObscureOP(),
                  isObscure: provider.isObscureOP,
                ),
              ),
              SizedBox(height: 20.h),
              Consumer<HelperVM>(
                builder: (context, provider, _) => FieldPassword(
                  label: "Password Baru",
                  controller: passwordC,
                  onPressed: () => provider.toggleObscureP(),
                  isObscure: provider.isObscureP,
                ),
              ),
              SizedBox(height: 20.h),
              Consumer<HelperVM>(
                builder: (context, provider, _) => FieldPassword(
                  label: "Konfirmasi Password Baru",
                  controller: confirmPasswordC,
                  onPressed: () => provider.toggleObscureCP(),
                  isObscure: provider.isObscureCP,
                ),
              ),
              SizedBox(height: 30.h),
              Consumer<UserVM>(
                builder: (context, provider, _) => ReusableButton(
                  style: buttonStyle,
                  isLoading: provider.isLoading,
                  text: 'Perbarui',
                  onPressed: () {
                    if (oldPasswordC.text.isEmpty ||
                        passwordC.text.isEmpty ||
                        confirmPasswordC.text.isEmpty) {
                      showErrorMessage("Input field must not be empty");
                    } else {
                      if (passwordC.text.length < 8) {
                        showErrorMessage(
                            "Your password must be at least 8 characters long.");
                      } else {
                        final User user = provider.response.data;
                        provider.changePasswordUser(
                          user.data.username,
                          oldPasswordC.text,
                          passwordC.text,
                          confirmPasswordC.text,
                        );
                      }
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
