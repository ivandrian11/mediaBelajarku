import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/data/api/api_service.dart';
import 'package:media_belajarku/data/model/order.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OrderView extends StatefulWidget {
  final Order order;

  const OrderView(this.order, {Key? key}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Stream<dynamic> getStatus() async* {
    yield* Stream.periodic(Duration(seconds: 3), (_) {
      return http.get(
        Uri.parse(
            'https://api.sandbox.midtrans.com/v2/${widget.order.id}/status'),
        headers: { HttpHeaders.authorizationHeader: 'useYourOwn', },
      );
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<dynamic>(
        stream: getStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error', style: standardStyle);
            } else if (snapshot.hasData) {
              final data = jsonDecode(snapshot.data.body);

              if (data["transaction_status"] == "settlement") {
                ApiService.updateStatusOrder(widget.order.id, "success").then(
                    (value) => Navigation.offWithData('/status_order', value));
              }

              if (data["transaction_status"] == "expire" ||
                  DateTime.now().difference(widget.order.createdAt).inHours >=
                      24) {
                ApiService.updateStatusOrder(widget.order.id, "failed").then(
                    (value) => Navigation.offWithData('/status_order', value));
              }

              return SafeArea(
                child: WebView(
                  initialUrl: widget.order.url,
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              );
            } else {
              return Text('Empty data', style: standardStyle);
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}
