import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/modules/home/wigets/genres.dart';
import 'package:movieapp/modules/home/wigets/now_playing.dart';
import 'package:movieapp/modules/home/wigets/persons.dart';
import 'package:movieapp/modules/home/wigets/top_movies.dart';
import 'package:movieapp/style/theme.dart' as Style;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.ColorsApp.mainColor,
      appBar: AppBar(
        backgroundColor: Style.ColorsApp.mainColor,
        centerTitle: true,
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        title: Text("Movie App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              EvaIcons.searchOutline,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          Genres(),
          Persons(),
          TopMovies(),
        ],
      ),
    );
  }
}
