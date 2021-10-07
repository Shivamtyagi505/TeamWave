// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teamwave/screen/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> getcountry = [];

  getCountry() async {
    var response = await http.get(Uri.parse('https://www.thesportsdb.com/api/v1/json/1/all_countries.php'));

    if (response.statusCode != 200) {
      print('Internal Server Error');
    } else if (response.body != '') {
      var data = jsonDecode(response.body);
        setState(() {
          getcountry = data['countries'];
        });
    }
  }

  @override
  void initState() {
    getCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.red[300],
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height*0.1,
              ),
              Center(
                  child: Text(
                'The Sports DB',
                style: TextStyle(color: Colors.white, fontSize: 40),
                textAlign: TextAlign.center,
              )),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: height*0.05),
                  height: height,
                  child: ListView.builder(
                      itemCount: getcountry.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(
                              countryname: getcountry[index]['name_en'] ?? '',
                            )));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            height: height*0.05,
                            decoration: BoxDecoration(
                            color: Colors.red[200],
                            borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width/2,
                                    child: Text(getcountry[index]['name_en'].toString(),style: TextStyle(fontSize: 20),overflow: TextOverflow.ellipsis,)),
                                  Icon(Icons.arrow_forward)
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
