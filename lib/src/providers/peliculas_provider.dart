import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/peliculas_model.dart';

class PeliculasProvider{
  String _apiKey = '76fc1c36ba7dc6383fb1001091006dbf';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri urlConsultada) async{
    final respuesta = await http.get(urlConsultada);

    final datosDecodificados = json.decode(respuesta.body);

    final peliculas = new Peliculas.fromJsonList(datosDecodificados['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines()async{
    final urlConsultada = Uri.https(_url, '/3/movie/now_playing',{
      'api_key' : _apiKey,
      'language' : _language,
    });

    return _procesarRespuesta(urlConsultada);
  }

  Future<List<Pelicula>> getPopular()async{
    final urlConsultada = Uri.https(_url, '/3/movie/popular',{
      'api_key' : _apiKey,
      'language' : _language,
    });

    return _procesarRespuesta(urlConsultada);
    
  }

}