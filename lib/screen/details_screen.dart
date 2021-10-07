import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  final String countryname;
  DetailsScreen({required this.countryname});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<dynamic> getcountryLeague = [];

  getCountryLeague() async {
    var response = await http
        .get(Uri.parse('https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=${widget.countryname}'));

    if (response.statusCode != 200) {
      print('Internal Server Error');
    } else if (response.body != '') {
      var data = jsonDecode(response.body);
      setState(() {
        getcountryLeague = data['countrys'];
      });
    }
  }

  @override
  void initState() {
    getCountryLeague();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text(widget.countryname),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Icon(Icons.search),
                const SizedBox(
                  width: 20,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: 300,
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Search Leagues'
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 900,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
                itemCount: getcountryLeague.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(getcountryLeague[index]['strLogo']??''), fit: BoxFit.cover),
                    ),
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10,left: 10),
                          child: Text(
                            getcountryLeague[index]['strLeague'],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,left: 10),
                          child: Row(
                            children: [
                              Image.asset('assets/images/facebook.png',height: 30,),
                              Image.asset('assets/images/twitter.png',height: 30,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      )),
    );
  }
}
