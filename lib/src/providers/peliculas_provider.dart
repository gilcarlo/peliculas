import 'dart:async';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/peliculas_model.dart';

class PeliculasProvider{
  String _apiKey = '76fc1c36ba7dc6383fb1001091006dbf';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;

  bool _cargandoData = false;

  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

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

  Future<List<Pelicula>> searchMovie(String query)async{
    final urlConsultada = Uri.https(_url, '/3/search/movie',{
      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : query
    });

    return _procesarRespuesta(urlConsultada);
  }

  Future<List<Pelicula>> getPopular()async{
    if (_cargandoData) return[];

    _cargandoData = true;
    _popularesPage++;
    final urlConsultada = Uri.https(_url, '/3/movie/popular',{
      'api_key' : _apiKey,
      'language' : _language,
      'page' : _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(urlConsultada);
    _populares.addAll(resp);
    popularesSink( _populares );
    _cargandoData = false;

    return resp;
  }

  Future<List<Actor>> getCast( String peliculaId )async{
    final url = Uri.https(_url, "/3/movie/$peliculaId/credits",{
      'api_key'  : _apiKey,
      'language' : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode( resp.body );

    final cast = new Cast.fromJsonList( decodedData['cast'] );

    return cast.actoresList;
  }
}