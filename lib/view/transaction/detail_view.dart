import 'package:flutter/material.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/data/api/api_response.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/course.dart';
import 'package:media_belajarku/data/model/materials.dart';
import 'package:media_belajarku/data/model/user.dart';
import 'package:media_belajarku/view_model/helper_vm.dart';
import 'package:media_belajarku/view_model/materials_vm.dart';
import 'package:media_belajarku/view_model/order_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
import 'package:media_belajarku/widgets/price_bottombar.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:size_config/util/size_extention.dart';

class DetailView extends StatefulWidget {
  final Course course;

  const DetailView(this.course, {Key? key}) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    Future.microtask(() {
      final provider = Provider.of<MaterialsVM>(context, listen: false);
      provider.fetchMaterials(widget.course.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Kelas'), titleTextStyle: appBarStyle),
      bottomNavigationBar: Consumer<OrderVM>(
        builder: (context, provider, _) => PriceBottomBar(
          isLoading: provider.isLoading,
          price: widget.course.price != 0
              ? rupiahFormating(widget.course.price)
              : 'Free',
          label: widget.course.price != 0 ? 'Beli Sekarang' : 'Mulai Sekarang',
          onTap: widget.course.price != 0
              ? () => Navigation.intentWithData('/transaction', widget.course)
              : () async {
                  User user =
                      Provider.of<UserVM>(context, listen: false).response.data;
                  await provider.processOrder(
                    user.data.username,
                    widget.course.id,
                    0,
                  );
                },
        ),
      ),
      body: Consumer<MaterialsVM>(
        builder: (context, provider, _) {
          switch (provider.response.status) {
            case Status.initial:
              return Center(
                child: Text('Fetching data...', style: standardStyle),
              );
            case Status.loading:
              return Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(
                child: Text(
                  provider.response.message!,
                  style: standardStyle,
                  textAlign: TextAlign.center,
                ),
              );
            case Status.completed:
              final List<Materials> materials = provider.response.data;

              return ListView(
                padding: EdgeInsets.only(
                  left: margin,
                  right: margin,
                  bottom: 16.h,
                ),
                children: [
                  SizedBox(height: 20.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.course.photoUrl,
                      height: 200.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    widget.course.name,
                    style: TextStyle(fontSize: 20.sp, fontWeight: semiBold),
                  ),
                  SizedBox(height: 12.h),
                  ReadMoreText(
                    widget.course.description,
                    trimLines: 4,
                    trimMode: TrimMode.Line,
                    style: TextStyle(color: secondaryTextColor, height: 1.6),
                  ),
                  SizedBox(height: 16.h),
                  Material(
                    color: Colors.white,
                    elevation: 1,
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 24.h,
                        backgroundImage:
                            NetworkImage(widget.course.mentor.photoUrl),
                      ),
                      title: Text(
                        widget.course.mentor.name,
                        style: standardStyle,
                      ),
                      subtitle: Text(
                        widget.course.mentor.job,
                        style: TextStyle(
                          color: secondaryTextColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 20.h),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Consumer<HelperVM>(
                    builder: (context, provider, _) => ExpansionPanelList(
                      elevation: 1,
                      animationDuration: Duration(milliseconds: 500),
                      dividerColor: Colors.grey,
                      expansionCallback: (panelIndex, isExpanded) =>
                          provider.toggleExpanded(),
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, isExpandeda) {
                            return ListTile(
                              title: Text(
                                'Materi yang akan dipelajari',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: semiBold,
                                ),
                              ),
                            );
                          },
                          body: ListTile(
                              title: Column(
                            children: materials
                                .map(
                                  (e) => Padding(
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 8.w,
                                          height: 8.h,
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Text(e.title, style: standardStyle),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          )),
                          isExpanded: provider.isExpanded,
                          canTapOnHeader: true,
                        ),
                      ],
                    ),
                  )
                ],
              );
          }
        },
      ),
    );
  }
}
