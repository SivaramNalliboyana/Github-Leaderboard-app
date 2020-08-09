import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github/viewpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Repos extends StatefulWidget {
  @override
  _ReposState createState() => _ReposState();
}

class _ReposState extends State<Repos> {
  Color getcolorfromhex(String hexcolor) {
    final hexcode = hexcolor.replaceAll('#', '');
    return Color(int.parse('FF$hexcode', radix: 16));
  }

  getrepos() async {
    var url = 'https://ghapi.huchen.dev/repositories';
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    List<Repo> trendingrepolist = List<Repo>();
    for (var trendingrepo in result) {
      Repo repo = Repo(
          trendingrepo['name'],
          trendingrepo['author'],
          trendingrepo['avatar'],
          trendingrepo['url'],
          trendingrepo['stars'],
          trendingrepo['forks'],
          trendingrepo['language'],
          trendingrepo['languageColor']);
      trendingrepolist.add(repo);
    }
    return trendingrepolist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          FutureBuilder(
              future: getrepos(),
              builder: (BuildContext context, dataSnapshot) {
                if (!dataSnapshot.hasData) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 55.0,
                                      height: 55.0,
                                      child: Image(
                                          image: NetworkImage(
                                              dataSnapshot.data[index].avatar)),
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
                                              fontWeight: FontWeight.w700,
                                              fontSize: 22),
                                        ),
                                        SizedBox(width: 5.0),
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.star,
                                                color: Colors.yellow),
                                            Text(dataSnapshot.data[index].stars
                                                .toString()),
                                            SizedBox(width: 10.0),
                                            Text(
                                                "Forks:${dataSnapshot.data[index].forks.toString()}"),
                                            SizedBox(width: 10.0),
                                            Container(
                                              width: 100,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: dataSnapshot
                                                              .data[index]
                                                              .color !=
                                                          null
                                                      ? getcolorfromhex(
                                                          dataSnapshot
                                                              .data[index]
                                                              .color)
                                                      : Colors.grey),
                                              child: Center(
                                                  child: Text(
                                                dataSnapshot.data[index]
                                                            .language !=
                                                        null
                                                    ? dataSnapshot
                                                        .data[index].language
                                                    : "??",
                                                style: GoogleFonts.montserrat(),
                                              )),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              })
        ],
      ),
    ));
  }
}

class Repo {
  final String name;
  final String author;
  final String avatar;
  final String url;
  final int stars;
  final int forks;
  final String language;
  final String color;

  Repo(this.name, this.author, this.avatar, this.url, this.stars, this.forks,
      this.language, this.color);
}
