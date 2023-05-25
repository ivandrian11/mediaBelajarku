import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:size_config/util/size_extention.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/data/api/api_response.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/course.dart';
import 'package:media_belajarku/data/model/order.dart';
import 'package:media_belajarku/data/model/user.dart';
import 'package:media_belajarku/view_model/course_vm.dart';
import 'package:media_belajarku/view_model/order_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
import 'package:media_belajarku/widgets/white_appbar.dart';
import 'package:provider/provider.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({Key? key}) : super(key: key);

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      User user = Provider.of<UserVM>(context, listen: false).response.data;
      final orderP = Provider.of<OrderVM>(context, listen: false);
      orderP.fetchAllOrder(user.data.username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Navigation.off('/order_history');
      },
      child: Scaffold(
        appBar: buildWhiteAppBar('Riwayat Transaksi'),
        body: Consumer<OrderVM>(
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
                List<Order> orders = provider.response.data;
                List<Course> courses =
                    Provider.of<CourseVM>(context).response.data;

                return orders.isEmpty
                    ? emptyIllustrationOrder(
                        MediaQuery.of(context).size.height / 1.5)
                    : ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: margin,
                          vertical: 16.h,
                        ),
                        children: orders.map((order) {
                          final status = order.status;
                          final course = courses.firstWhere(
                              (course) => course.id == order.course);
                          final colors = {
                            "success": Colors.greenAccent[400],
                            "failed": Colors.redAccent[400],
                            "pending": Colors.orangeAccent[400]
                          };

                          return Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              onTap: status == "pending"
                                  ? () {
                                      final helper = [];
                                      helper.addAll(orders);

                                      helper.retainWhere((element) =>
                                          element.course == order.course &&
                                          element.status == "success");

                                      if (helper.isEmpty) {
                                        Navigation.intentWithData(
                                            '/order', order);
                                      }
                                    }
                                  : null,
                              title: Text(
                                course.name,
                                style: TextStyle(
                                  fontWeight: semiBold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              subtitle: Text(
                                DateFormat.yMMMMEEEEd('id')
                                    .format(order.createdAt),
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              trailing: Text(
                                status,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: semiBold,
                                  fontStyle: FontStyle.italic,
                                  color: colors[status],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
            }
          },
        ),
      ),
    );
  }
}
