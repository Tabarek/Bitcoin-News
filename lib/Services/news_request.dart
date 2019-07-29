import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NewsRequest with ChangeNotifier {
  /// the request must contain the API's url and api key in the header
  static String _url =
      "https://newsapi.org/v2/everything?q=bitcoin&from=2019-06-28&sortBy=publishedAt&apiKey=4d990bdd71324572bca39fe31edc3990";
  static Map<String, String> _apiKey = {
    "apiKey": "4d990bdd71324572bca39fe31edc3990"
  };

  //define basic variabls
  Map<String, dynamic> _data;
  List _articles;
  bool _isFetching = false;
  Map<String, dynamic> result;

  //start the request directly in the constructor of Change Notifier
  NewsRequest() {
    fetchData();
  }

  //get the value of [_ifFetching]
  bool get isFetching => _isFetching;

  // Http get request
  Future<Map<String, dynamic>> fetchData() async {

   
    _isFetching = true;
    
    notifyListeners();
    try {
       Response response = await get(Uri.encodeFull(_url), headers: _apiKey)
          .timeout(Duration(seconds: 60));
      print('********** ${response.statusCode}');
      print("STATUSCODE ${response.statusCode}");
      if (response.statusCode == 200) {
        _data = json.decode(response.body);
      }
      _isFetching = false;
      notifyListeners();
    } on SocketException catch (_) {
      print('SOCET EXEPTION');
      _isFetching = false;
      notifyListeners();
      return result = {
        'statusCode': 404,
        'response': 'No Internet Connection',
        'length': ''
      };
    } on TimeoutException catch (_) {
      print('TIMEOUT EXEPTION');
      _isFetching = false;
      notifyListeners();
      return result = {
        'statusCode': 400,
        'response': 'Request Timed out',
        'length': ''
      };
    } catch (e) {
      _isFetching = false;
      notifyListeners();
      e.toString();
      print('CATCH ${e.toString()}');
    }
    return result;
  }

// get request data
  Map<String, dynamic> get getNews => _data;

// get the articales
  Map<String, dynamic> getNewsData() {
    if (_data == null) {
      print('data is null');
      return null;
    } else {
      _articles = _data['articles'];
    }
    return result = {
      'statusCode': 200,
      'response': _articles,
      'length': _articles.length
    };
  }
}
