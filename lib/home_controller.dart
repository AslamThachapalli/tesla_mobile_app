import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  //BottomTab Navigation controller
  int selectedBottomTab = 0;

  void onBottomTabNavigationChange(int index) {
    selectedBottomTab = index;
    notifyListeners();
  }

  //BottomTabNav currentIndex = 0 controllers
  bool isRightDoorLocked = true;
  bool isLeftDoorLocked = true;
  bool isBonnetDoorLocked = true;
  bool isTrunkDoorLocked = true;

  void updateRightDoorLock() {
    isRightDoorLocked = !isRightDoorLocked;
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLocked = !isLeftDoorLocked;
    notifyListeners();
  }

  void updateBonnetDoorLock() {
    isBonnetDoorLocked = !isBonnetDoorLocked;
    notifyListeners();
  }

  void updateTrunkDoorLock() {
    isTrunkDoorLocked = !isTrunkDoorLocked;
    notifyListeners();
  }

  //BottomTabNav currentIndex = 2 controllers
  bool isCoolBtnSelected = true;

  void updateCoolBtnSelection() {
    isCoolBtnSelected = !isCoolBtnSelected;
    notifyListeners();
  }

  int currentTemp = 26;

  void incrementTemp() {
    currentTemp++;
    notifyListeners();
  }

  void decrementTemp() {
    currentTemp--;
    notifyListeners();
  }

  //BottomTabNav currentIndex = 3 controllers
  bool showTyres = false;

  void showTyresController(int index) {
    if (index == 3) {
      Future.delayed(const Duration(milliseconds: 400), () {
        showTyres = true;
        notifyListeners();
      });
    } else {
      showTyres = false;
      notifyListeners();
    }
  }

  bool isShowTypePsi = false;

  void showTyrePsiController(int index) {
    if (index == 3) {
      isShowTypePsi = true;
      notifyListeners();
    } else {
      Future.delayed(const Duration(milliseconds: 600), () {
        isShowTypePsi = false;
        notifyListeners();
      });
    }
  }
}
