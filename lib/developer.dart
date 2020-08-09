import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github/viewpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Developers extends StatefulWidget {
  @override
  _DevelopersState createState() => _DevelopersState();
}

class _DevelopersState extends State<Developers> {
  getdevelopers() async {
    var url = 'https://ghapi.huchen.dev/developers';
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    List<Developer> trendingdeveloperlist = List<Developer>();
    for (var person in result) {
      Developer developer = Developer(
          person['avatar'], person['url'], person['username'], person['name']);
      trendingdeveloperlist.add(developer);
    }
    return trendingdeveloperlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          FutureBuilder(
              future: getdevelopers(),
              builder: (BuildContext context, dataSnapshot) {
                if (!dataSnapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dataSnapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPage(dataSnapshot.data[index].url)));
                        },
                                              child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 55.0,
                                              height: 55.0,
                                              child: Image(
                                                  image: NetworkImage(dataSnapshot
                                                      .data[index].avatar)),
                                            ),
                                            SizedBox(width: 10.0),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    dataSnapshot.data[index].name,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.purple,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 22),
                                                  ),
                                                  SizedBox(height:10.0),
                                                  Text(dataSnapshot.data[index].username,style: GoogleFonts.montserrat(
                                                    fontWeight:FontWeight.w700,
                                                    color:Colors.grey,
                                                    fontSize:18
                                                  ),)
                                                ])
                                          ])
                                    ]))),
                      );
                    });
              })
        ],
      )),
    );
  }
}

class Developer {
  final String avatar;
  final String url;
  final String username;
  final String name;

  Developer(this.avatar, this.url, this.username, this.name);
}
