import 'package:get/get.dart';

class RankSwitchController extends GetxController {
  String? orderFieldID;

  void changeOrderFieldID(String? newOrderFieldID) {
    orderFieldID = newOrderFieldID;
    update();
  }
}