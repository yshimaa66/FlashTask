import 'package:flash_test/models/rocket_model.dart';
import 'package:flash_test/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DetailsWebViewPage extends StatelessWidget {

  final RocketModel rocketModel;

  const DetailsWebViewPage({Key? key, required this.rocketModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: rocketModel.articleLink,
      appBar: AppBar(
        backgroundColor: navigationColor,
        centerTitle: true,
        title: Text(rocketModel.name,
          style: TextStyle(
            color: titleTextColor,
            fontWeight: FontWeight.w900,
          ),),
      ),
    );
  }
}
