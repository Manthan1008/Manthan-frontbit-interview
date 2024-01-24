import 'dart:convert';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class home extends StatelessWidget {
  home({super.key});

  bool isfreespp = true;
  bool ispaidapp = true;
  SearchController searchcontroller = SearchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Apps'))),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getdata(),
              builder: (context, snapshot) {
                print('!!!!!!!!!!!!! ${snapshot.connectionState}');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error'),
                  );
                } else {
                  print('abc${snapshot.data}');
                  return Column(
                    children: [
                      SearchBar(
                        controller: searchcontroller,
                        hintText: 'search',
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text('Free App'),
                            ),
                          ),
                          GestureDetector(
                            child: Center(
                              child: Text('Paid App'),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage('url')),
                            color: Colors.yellow),
                      )
                    ],
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<Map> getdata() async {
    var url = Uri.parse(
        'https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    var map = jsonDecode(response.body);
    print('map1 status: ${map}');

    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
    return map;
  }
}
