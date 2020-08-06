import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/bloc/get_persons_bloc.dart';
import 'package:movieapp/model/person.dart';
import 'package:movieapp/model/person_response.dart';
import 'package:movieapp/style/theme.dart' as Style;

class Persons extends StatefulWidget {
  Persons({Key key}) : super(key: key);

  @override
  _PersonsState createState() => _PersonsState();
}

class _PersonsState extends State<Persons> {
  @override
  void initState() {
    super.initState();
    personsBLoc.getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            "TRENDING PERSONS ON THIS WEEK",
            style: TextStyle(
              color: Style.ColorsApp.titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        StreamBuilder<PersonResponse>(
          stream: personsBLoc.subject.stream,
          builder: (ctx, snapShot) {
            if (snapShot.hasData) {
              if (snapShot.data.error != null &&
                  snapShot.data.error.length > 0) {
                return _buildErrorWidget(snapShot.data.error);
              }
              return _buildPersonsWidget(snapShot.data);
            } else if (snapShot.hasError) {
              return _buildErrorWidget(snapShot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        ),
      ],
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

  Widget _buildPersonsWidget(PersonResponse data) {
    List<Person> persons = data.persons;

    return Container(
      height: 140,
      padding: EdgeInsets.only(left: 10),
      child: ListView.builder(
        itemCount: persons.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Container(
            width: 120,
            padding: EdgeInsets.only(top: 10, right: 8),
            child: Column(
              children: <Widget>[
                persons[index].profileImg == null
                    ? Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Style.ColorsApp.secondColor,
                        ),
                        child: Icon(
                          FontAwesomeIcons.userAlt,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w200" +
                                    persons[index].profileImg),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                SizedBox(height: 10),
                Text(
                  persons[index].name,
                  maxLines: 2,
                  style: TextStyle(
                    height: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "Trending for ${persons[index].know}",
                  style: TextStyle(
                    color: Style.ColorsApp.titleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 7,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
