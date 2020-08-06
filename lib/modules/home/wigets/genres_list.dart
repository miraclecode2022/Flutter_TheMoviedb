import 'package:flutter/material.dart';
import 'package:movieapp/bloc/get_movies_byGenre_bloc.dart';
import 'package:movieapp/modules/home/wigets/genre_movies.dart';
import 'package:movieapp/style/theme.dart' as Style;
import 'package:movieapp/model/genre.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;

  GenresList({@required this.genres});

  @override
  _GenresListState createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  TabController _tabController;

  _GenresListState(this.genres);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: genres.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        moviesListByGenreBloc.drainStream();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Style.ColorsApp.mainColor,
          appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Style.ColorsApp.mainColor,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Style.ColorsApp.secondColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                unselectedLabelColor: Style.ColorsApp.titleColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres.map((Genre genre) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 15, top: 10),
                    child: Text(
                      genre.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            preferredSize: Size.fromHeight(50),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres
                .map((Genre genre) => GenreMovies(genreId: genre.id))
                .toList(),
          ),
        ),
      ),
    );
  }
}
