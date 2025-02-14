import 'package:flutter/cupertino.dart';

class GlobalKeys{
  static GlobalKey<FormState>? loginWindowKey;
  static GlobalKey<FormState>? addAccountWindowKey;
  static GlobalKey<FormState>? createAccountWindowKey;
  static GlobalKey<FormState>? addCreditCardKey;
  static GlobalKey<FormState>? changePasswordKey;

  static void resetKeys() {
    loginWindowKey = GlobalKey<FormState>(debugLabel: "loginWindowKey");
    addAccountWindowKey = GlobalKey<FormState>(debugLabel: "addAccountWindowKey");
    createAccountWindowKey = GlobalKey<FormState>(debugLabel: "createAccountWindowKey");
    addCreditCardKey = GlobalKey<FormState>(debugLabel: "addCreditCardKey");
    changePasswordKey = GlobalKey<FormState>(debugLabel: "changePasswordKey");
  }
}