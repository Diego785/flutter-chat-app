import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }

  @override
  bool get wantKeepAlive => true;
}
