import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/peliculas_model.dart';


class CustomCardSwiper extends StatelessWidget {
  final List<Pelicula> lista;

  CustomCardSwiper({ @required this.lista });



  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 25.0),
      //width: double.infinity,
      //height: 250.0,
      child: Swiper(
      itemBuilder: (BuildContext context,int index){
        lista[index].uniqueId = lista[index].id.toString() + "card_swiper";

        return Hero(
                  tag: lista[index].uniqueId,
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: _imgGesture(lista[index], context),
                ),
        );
      },
      itemWidth: _screenSize.width * 0.7,
      itemHeight: _screenSize.height * 0.6,
      layout: SwiperLayout.STACK,
      itemCount: lista.length,
      //pagination: new SwiperPagination(),
      //control: new SwiperControl(),
    ),
    );
  }

  Widget _imgGesture(Pelicula p, BuildContext context){

    final img = FadeInImage(
      placeholder: AssetImage("assets/img/no-image.jgp"), 
      image: NetworkImage(p.getPosterImg()),
      fit: BoxFit.cover,);

    return GestureDetector(
      child: img,
      onTap: (){
        Navigator.of(context).pushNamed("detalle", arguments: p);
      },
    );
  }
}