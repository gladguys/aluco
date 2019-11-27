import 'package:connectivity_alert_widget/connectivity_alert_widget.dart';
import 'package:flutter/material.dart';

class ALConnectivityAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConnectivityAlertWidget(
      onlineWidget: Icon(Icons.network_wifi, color: Colors.green),
      offlineWidget: Icon(Icons.signal_wifi_off, color: Colors.red),
    );
  }
}
