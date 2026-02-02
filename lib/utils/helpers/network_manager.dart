import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../popups/loaders.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  /// Initialize the network manager and set up a stream to continually check the connection status.
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    checkConnectivity();
  }

  /// Update the connection status based on changes in connectivity and show a relevant popup for no internet connection.
  void _updateConnectionStatus(List<ConnectivityResult> result) {
    // The list can be empty, so we handle that case.
    if (result.isEmpty) {
      _connectionStatus.value = ConnectivityResult.none;
      return;
    }

    // The new API returns a list of connection types. If the list contains anything other than 'none', we consider it connected.
    if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)) {
      _connectionStatus.value = result.firstWhere((e) => e != ConnectivityResult.none, orElse: () => ConnectivityResult.none);
    } else {
      _connectionStatus.value = ConnectivityResult.none;
    }

    if (_connectionStatus.value == ConnectivityResult.none) {
      TLoaders.warningSnackBar(title: 'No Internet Connection');
    }
  }

  /// Check the internet connection status.
  /// Returns `true` if connected, `false` otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      // The new API returns a list. If it contains mobile or wifi, we are connected.
      return result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);
    } on PlatformException catch (_) {
      return false;
    }
  }
  
  /// Check the initial connectivity of the device.
  Future<void> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  /// Dispose or close the active connectivity stream.
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
