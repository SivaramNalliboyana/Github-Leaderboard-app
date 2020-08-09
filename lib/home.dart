import 'package:flutter/material.dart';
import 'package:github/repos.dart';

import 'developer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController tabController;
  void initState(){
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  int page = 0;
  List pageoptions = [
    Repos(),
    Developers()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        indicatorColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.black,
        controller: tabController,
        tabs: [
        Tab(icon: Icon(Icons.trending_up),text: "Trending Repos"),
        Tab(icon: Icon(Icons.person),text: "Trending Developers"),
      ],
      onTap: (index){
        setState(() {
          page = index;
        });
      },),
      body: pageoptions[page] ,
    );
  }
}