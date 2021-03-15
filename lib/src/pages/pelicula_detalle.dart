
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/peliculas_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DetallePelicula extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar( pelicula ),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 10.0),
                  _posterTitulo( context, pelicula),
                  _descripcionPelicula( pelicula ),
                  _crearCasting( pelicula )
                ]
              )
            )
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula p){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          p.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          background: FadeInImage(
            placeholder: AssetImage("assets/img/loading.gif"), 
            image: NetworkImage(p.getBackgroundImg()), 
            fadeInDuration: Duration(milliseconds: 280),fit: BoxFit.cover,),
      ),
    );
  }

  Widget _posterTitulo (BuildContext context, Pelicula p){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
              tag: p.uniqueId,
              child: ClipRRect(
              child: Image(image: NetworkImage( p.getPosterImg() ), height: 150.0,),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
            SizedBox(width: 20.0,),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(p.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                  Text(p.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star_border),
                      Text(p.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle1)
                    ],
                  )
                ],
              ),
            )
        ]
      ),
    );
  }


  Widget _descripcionPelicula(Pelicula p){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        p.overview,
        textAlign: TextAlign.justify,  
      ),
    );
  }

  Widget _crearCasting( Pelicula p ){
    final pelisProvider = new PeliculasProvider();

    return FutureBuilder(
      future: pelisProvider.getCast( p.id.toString() ),
      builder: (BuildContext context, AsyncSnapshot<List> asyncSnapshot){
        if ( asyncSnapshot.hasData ) {
          return _crearActoresPage( asyncSnapshot.data );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  Widget _crearActoresPage( List<Actor> actores ){
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: actores.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemBuilder: (context, i) => _tarjetaActor( actores[i] ),
      ),
    );
  }

  Widget _tarjetaActor( Actor actor ){
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage("assets/img/no-image.jpg"), 
              image: NetworkImage( actor.getFotoActor() ),
              height: 120.0,
              fit: BoxFit.cover,),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}