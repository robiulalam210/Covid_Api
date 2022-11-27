import 'dart:convert';

import 'package:covid_19_api/Model/WorldStatesModel.dart';
import 'package:covid_19_api/Services/Utilies/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices{
  Future<WorldStatesModel> futureWorldStatesModel() async{

    final response=await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));
    var data=jsonDecode(response.body.toString());

    if(response.statusCode==200){

      print("pppppppp${response.body}");
      return WorldStatesModel.fromJson(data);

    }else{

      throw Exception("Error");
    }
  }

}