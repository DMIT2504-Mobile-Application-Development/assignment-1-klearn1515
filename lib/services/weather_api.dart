import 'dart:convert';
import 'package:http/http.dart' as http;

const String weatherApiKey = 'e759bed878fa347165f20395a525e2fb';
const String currentWeatherEndpoint = 'https://api.openweathermap.org/data/2.5/weather';

Future<dynamic> getWeatherForCity({String? city}) async{
  final url = '$currentWeatherEndpoint?q=$city&appid=$weatherApiKey&units=metric';

  try{
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else{
      throw Exception('There was a problem with the request: status ${response.statusCode} received');
    }
  }
  catch(e)
  {
    throw Exception('there was a problem with the request: $e');
  }
}