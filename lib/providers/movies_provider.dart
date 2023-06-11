import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class MoviesProvider extends ChangeNotifier{
  String _baseUrl='api.themoviedb.org';
  String _apikey='089f162a3cfc6626f84608a202f6b588';
  String _language='es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies=[];
  List<CastElement> castMovies = [];

  MoviesProvider(){
    print('MoviesProvider Inicializado');
    getOnDisplayMovies();
    getPopularMovies();
    getMovieDetails();
  }

  getOnDisplayMovies() async{
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {'api_key': _apikey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;
    //notifyListeners(); Le comunica a todos los widgets que estan escuchando
    //que se cambio la data por lo tanto se redibujan.
    notifyListeners();
  }

   Future<List<CastElement>> getActors(String movieId) async {
    final url = Uri.https(_baseUrl, '3/movie/$movieId/credits',
        {'api_key': _apikey, 'language': _language});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final cast = Cast.fromJson(decodedData);
    castMovies = cast.cast;
    return castMovies;
  }

  getPopularMovies()async{
    var url =Uri.https(_baseUrl,'3/movie/popular',
    {'api_key':_apikey, 'language':_language, 'page':'1'});
    final response =await http.get(url);
    final popularResponse = PopularResponse.fromRawJson(response.body);
    popularMovies=popularResponse.results;
    notifyListeners();
    return;
  }

  getMovieDetails() async{
    var url = Uri.https(_baseUrl, '3/movie/315162', {'api_key': _apikey, 'language': _language});
    final response = await http.get(url);
    print(response.body);
  }


}