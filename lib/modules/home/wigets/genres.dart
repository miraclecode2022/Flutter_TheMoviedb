import 'package:flutter/material.dart';
import 'package:movieapp/bloc/get_genres_bloc.dart';
import 'package:movieapp/model/genre.dart';
import 'package:movieapp/model/genre_response.dart';
import 'package:movieapp/modules/home/wigets/genres_list.dart';

class Genres extends StatefulWidget {
  Genres({Key key}) : super(key: key);

  @override
  _GenresWidgetState createState() => _GenresWidgetState();
}

class _GenresWidgetState extends State<Genres> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    genresBLoc.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
      stream: genresBLoc.subject.stream,
      builder: (ctx, snapShot) {
        if (snapShot.hasData) {
          if (snapShot.data.error != null && snapShot.data.error.length > 0) {
            return _buildErrorWidget(snapShot.data.error);
          }
          return _buildGenresWidget(snapShot.data);
        } else if (snapShot.hasError) {
          return _buildErrorWidget(snapShot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error occured $error"),
    );
  }

  Widget _buildGenresWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
    if (genres.length == 0) {
      return Container(
        child: Text("No Genres"),
      );
    } else
      return GenresList(genres: genres);
  }
}
