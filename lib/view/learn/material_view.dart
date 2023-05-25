import 'package:flutter/material.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/data/model/course.dart';
import 'package:media_belajarku/data/model/materials.dart';
import 'package:media_belajarku/view_model/materials_vm.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';

class MaterialView extends StatelessWidget {
  final Course course;

  const MaterialView(this.course, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final materialP = Provider.of<MaterialsVM>(context);
    List<Materials> materials = materialP.response.data;

    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
        titleTextStyle: appBarStyle,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: margin),
        children: [
          SizedBox(height: 24.h),
          Text('Materi', style: subtitleStyle),
          SizedBox(height: 12.h),
          Column(
            children: materials
                .map(
                  (e) => Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: ListTile(
                      onTap: () {
                        materialP.selectAMaterial(e);
                        Navigation.intentWithData('/learn', course);
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: secondaryTextColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      dense: true,
                      title: Text(
                        '${materials.indexOf(e) + 1}. ${e.title}',
                        style: TextStyle(fontWeight: semiBold),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 '${materials.indexOf(e) + 1}. ${e.title}',
//                                 style: TextStyle(fontWeight: semiBold),
//                               ),
//                               DecoratedBox(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(32),
//                                   border: Border.all(
//                                     color: secondaryTextColor,
//                                     width: 1.5,
//                                   ),
//                                 ),
//                                 child: true
//                                     ? SizedBox(height: 24, width: 24)
//                                     : Icon(Icons.check_circle,
//                                         color: Colors.green),
//                               )
//                             ],
//                           ),