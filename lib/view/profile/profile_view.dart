import 'package:flutter/material.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/data/model/user.dart';
import 'package:media_belajarku/view_model/preferences_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preferencesP = Provider.of<PreferencesVM>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya ☝️'),
        titleTextStyle: appBarStyle,
      ),
      body: Consumer<UserVM>(
        builder: (context, provider, _) {
          final User user = provider.response.data;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  CircleAvatar(
                    radius: 50.h,
                    backgroundImage: NetworkImage(user.data.photoUrl),
                  ),
                  SizedBox(height: 8.h),
                  Text(user.data.username, style: subtitleStyle),
                  SizedBox(height: 30.h),
                  OptionTile(
                    text: 'Ubah Password',
                    icon: Icons.lock_outline,
                    onTap: () => Navigation.intent('/change_password'),
                  ),
                  OptionTile(
                    text: 'Riwayat Transaksi',
                    icon: Icons.history_outlined,
                    onTap: () => Navigation.intent('/order_history'),
                  ),
                  OptionTile(
                    text: 'Tentang Aplikasi',
                    icon: Icons.info_outline,
                    onTap: () => showDialogInformation(),
                  ),
                  OptionTile(
                    text: 'Keluar',
                    icon: Icons.logout_outlined,
                    onTap: () => showDialogConfirmation(() {
                      preferencesP.removeLogged();
                      Navigation.offAll('/login');
                    }),
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  const OptionTile({
    required this.text,
    required this.icon,
    required this.onTap,
    this.color = primaryTextColor,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color color;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      leading: Icon(icon, color: color, size: 24.h),
      title: Text(text, style: TextStyle(color: color)),
      trailing: Icon(Icons.arrow_forward_ios, color: color, size: 20.h),
      onTap: onTap,
    );
  }
}
