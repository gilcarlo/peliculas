import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas_model.dart';

class HorizontalPageWid extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  HorizontalPageWid({ @required this.peliculas, @required this.siguientePagina });

  final _pageController = new PageController(initialPage: 1, viewportFraction: 0.3);


  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() { 
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
     });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _tarjetas()
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i]),
        itemCount: peliculas.length,
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula p){
    p.uniqueId = p.id.toString() + "card_hor";

    final peliculaTarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget> [
            Hero(
                  tag: p.uniqueId,
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                  height: 140.0,
                  fit: BoxFit.cover,
                  placeholder: AssetImage("assets/img/no-image.jgp"), 
                  image: NetworkImage(p.getPosterImg())),
              ),
            ),
            SizedBox(height: 5.0),
            Text(p.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption,)
          ],
        ),
      );

      return GestureDetector(
        child: peliculaTarjeta,
        onTap: (){
          Navigator.pushNamed(context, "detalle", arguments: p);
        },
      );
  }

  
}