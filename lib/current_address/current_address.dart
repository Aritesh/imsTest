import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lms_test/config/common_functions.dart';
import 'package:provider/provider.dart';

import 'current_address_model.dart';

class CurrentAddress extends StatefulWidget {
  @override
  _CurrentAddressState createState() => _CurrentAddressState();
}

class _CurrentAddressState extends State<CurrentAddress>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration.zero, () async {
      WidgetsBinding.instance.addObserver(this);
      final model = Provider.of<CurrentAddressModel>(context);
      model.initTast(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        showToast(
            Provider.of<CurrentAddressModel>(context).address?.addressLine);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentAddressModel>(builder: (context, model, _) {
      return Scaffold(
        appBar: appBarWidget(haddingText: "Current Address"),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${model.address?.addressLine ?? '_'}",
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
