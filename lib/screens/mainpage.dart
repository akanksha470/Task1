import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task1/screens/favourite.dart';
import 'package:task1/screens/news.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 2,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.1,

          child: TabBar(
            labelColor: Colors.indigo,
            tabs: <Widget>[
              Tab(text: 'News', icon: Icon(Icons.format_list_bulleted)),
              Tab(text: 'Favs', icon: Icon(Icons.favorite, color: Colors.red,),)
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[NewsPage(), FavouritePage()],
        ),
      ),
    );
  }
}
