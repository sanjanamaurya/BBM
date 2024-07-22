import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiranga/res/api_urls.dart';

class MyModel with ChangeNotifier {
  var id;
  var bonusWallet;
  var datetime;
  var deposit_balance;
  var image;
  var mobile;
  var referral_code;
  var ruserid;
  var status;
  // var total_balance;
  var username;
  var wallet;
  var winning_wallet;
  var win_lose;
  //var withdrawanle_balance;
  var u_id;
  bool loading = false;

  void loadingchange(){
    loading =!loading;
    notifyListeners();
  }

  void getprofile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString("userId");

      final url = Uri.parse("${ApiUrl.profileAndar}$userId");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)["data"];

        // Extracting data from the response
        id = responseData["id"];
        bonusWallet = responseData["bonus_wallet"];
        datetime = responseData["datetime"];
        deposit_balance = responseData["deposit_balance"];
        image = responseData["userimage"];
        mobile = responseData["mobile"];
        referral_code = responseData["referral_code"];
        ruserid = responseData["ruserid"];
        status = responseData["status"];
        // total_balance = responseData["total_balance"];
        username = responseData["username"];
        wallet = responseData["wallet"];
        winning_wallet = responseData["winning_wallet"];
        win_lose = responseData["win_lose"];
        // withdrawanle_balance = responseData["withdrawanle_balance"]; // Corrected variable name
        u_id = responseData["u_id"];
        notifyListeners();
      } else {
        throw Exception("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load data. $e");
    }
  }
}