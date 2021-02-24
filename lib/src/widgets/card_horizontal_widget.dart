import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas_model.dart';

class HorizontalPageWid extends StatelessWidget {

  final List<Pelicula> peliculas;

  HorizontalPageWid({ @required this.peliculas });


  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        children: _tarjetas()
      ),
    );
  }

  List<Widget> _tarjetas(){
    return peliculas.map((p){
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget> [
            FadeInImage(
              height: 140.0,
              fit: BoxFit.cover,
              placeholder: AssetImage("assets/img/no-image.jgp"), 
              image: NetworkImage(p.getPosterImg())),
          ],
        ),
      );
    }).toList();
  }
}