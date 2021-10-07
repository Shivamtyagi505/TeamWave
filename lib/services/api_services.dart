import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teamwave/model/country_model.dart';

Future<Country> getCountry() async {
  var response = await http.get(Uri.parse('https://www.thesportsdb.com/api/v1/json/1/all_countries.php'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Country.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
