import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_horizontal_widget.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Peliculas"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){})
        ]),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperCrear(),
              _footer(context)
          ],)
        ),
    );
  }

  Widget _swiperCrear(){
    
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if (snapshot.hasData){
          return CustomCardSwiper(
            lista: snapshot.data,
          );
        }else{
          return Container(
            height: 300.0,
            child: Center(child: CircularProgressIndicator()));
        }
        
      });
  }

  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        children : <Widget>[
          Text(
            "Populares",
            style: Theme.of(context).textTheme.subtitle1),
          FutureBuilder(
            future: peliculasProvider.getPopular(),
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot){
              if (asyncSnapshot.hasData){
                return HorizontalPageWid(peliculas: asyncSnapshot.data,);
              }else{
                return CircularProgressIndicator();
              }
              
            } ),
        ],
      ),
    );
  }

}