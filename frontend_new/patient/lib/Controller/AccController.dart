import 'dart:developer';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend_new/UserData.dart';
import 'package:frontend_new/model/AccModel.dart';

import 'package:http/http.dart' as http;

class PaDataProvider with ChangeNotifier {
  Accmodel responseData = Accmodel(); 
  bool isLoggedIn = false;
  bool isLoading = false;

  // Accmodel? _account;
  // Accmodel? get account => _account;


  String? _firstName;
  String? get firstName => _firstName;

  void setLoginStatusActive(){
    isLoggedIn = true;
    notifyListeners();
  }

  getMyData() async {
    isLoading = true;
    responseData = await getAllData();
    isLoading = false;
    notifyListeners();
  }

  void setUserLoginData(String name){
    _firstName = name;
    notifyListeners();
  }

  Future<Accmodel> getAllData() async {
    try {
      final response = await http.get(Uri.parse(
          "http://127.0.0.1:8000/api/paview-detail/1")); //afno ip address use
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        responseData = Accmodel.fromJson(item);
        notifyListeners();
      } else {
        print("else");
      }
    } catch (e) {
      log(e.toString());
    }

    return responseData;
  }
}
