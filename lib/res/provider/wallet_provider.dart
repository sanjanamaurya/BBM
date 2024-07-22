import 'package:flutter/material.dart';
import 'package:tiranga/model/wallet_model.dart';


class WalletProvider with ChangeNotifier {

  WalletModel? _walletList;

  WalletModel? get walletlist => _walletList;

  void setWalletList(WalletModel walletss) {
    _walletList = walletss;
    notifyListeners();
  }
}