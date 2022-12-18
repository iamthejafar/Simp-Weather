import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class GetData{
  GetData(this.url);
  String url;
  Future fetchData() async {
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      String data = response.body;
      var decodeData = jsonDecode(data);
      return decodeData;
    }
  }
}