import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = new PeliculasProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
      // Las Acciones de nuestro appbar
      return [
        IconButton(
          icon: Icon(Icons.clear), 
          onPressed: (){
            query = '';
          }
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del appbar
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, 
          progress: transitionAnimation,
        ), 
        onPressed: (){
          close(context, null);
        }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Crea los resultados que vamos a mostrar
      return Container();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Muestra sugerencias de busqueda
    if (query.isEmpty) Container();

    return FutureBuilder(
      future: peliculasProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> asyncSnapshot){
        if (asyncSnapshot.hasData) {
          final peliculas = asyncSnapshot.data;
          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, "detalle", arguments: pelicula);
                },
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                leading: FadeInImage(fit: BoxFit.contain, width: 50.0, placeholder: AssetImage("assets/img/no-image.jpg"), image: NetworkImage(pelicula.getPosterImg())),
              );
            }).toList(),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
  
}