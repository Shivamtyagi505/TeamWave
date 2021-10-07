// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
    Country({
      required this.countrys,
    });

    List<Map<String, String>> countrys;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        countrys: List<Map<String, String>>.from(json["countrys"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
    );

    Map<String, dynamic> toJson() => {
        "countrys": List<dynamic>.from(countrys.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
    };
}
