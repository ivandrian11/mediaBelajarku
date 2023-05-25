import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/data/model/course.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:media_belajarku/data/model/materials.dart';
import 'package:media_belajarku/view_model/materials_vm.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/widgets/reusable_button.dart';
import 'package:media_belajarku/widgets/white_appbar.dart';

class LearnView extends StatelessWidget {
  final Course course;

  const LearnView(this.course, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MaterialsVM>(
      builder: (context, provider, _) {
        List<Materials> materials = provider.response.data;
        Materials selected = provider.selected!;

        return Scaffold(
          appBar: buildWhiteAppBar(course.name),
          body: ListView(
            padding: EdgeInsets.all(margin),
            children: [
              SizedBox(height: 8.h),
              HtmlWidget(
                selected.body,
                webView: true,
              ),
              SizedBox(height: 24.h),
              ReusableButton(
                style: buttonStyle,
                text: materials.indexOf(selected) == materials.length - 1
                    ? "Selesai Belajar"
                    : 'Lanjutkan Materi',
                onPressed: materials.indexOf(selected) == materials.length - 1
                    ? () => Navigation.back()
                    : () => provider.nextMaterial(),
              ),
            ],
          ),
        );
      },
    );
  }
}
