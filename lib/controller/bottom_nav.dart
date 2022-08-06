// package
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// routes
import '../routes/map.dart';
import '../components/message.dart';

enum PageName {
  HOME,
  MAP,
  APTLIST,
  MY
}

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  bool isHome = true;
  DateTime? currentBackPressTime;

  void _changePage(int value) {
    pageIndex(value);
    if (value == PageName.HOME.index) {
      isHome = false;
    }
  }

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    // TODO: refact later
    switch (page) {
      case PageName.HOME:
        isHome = true;
        _changePage(value);
        break;
      case PageName.MAP:
      case PageName.APTLIST:
      case PageName.MY:
        isHome = false;
        _changePage(value);
        break;
    }
  }

  Future<bool> willPopAction() async {
    if (isHome) {
      return exitApp();
    } else {
      _changePage(PageName.HOME.index);
      return false;
    }
  }

  bool exitApp() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "'뒤로' 버튼을 한번 더 누르시면 종료됩니다.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xff6E6E6E),
          fontSize: 20,
          toastLength: Toast.LENGTH_SHORT);
      return false;
    }
    return true;
  }
}