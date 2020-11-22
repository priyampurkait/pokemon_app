import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';

class FetchingDataState with ChangeNotifier, DiagnosticableTreeMixin {
  String url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
  Future<Pokemon> _pokemonList;

  FetchingDataState() {
    debugPrint('FetchingDataState');
    _pokemonList = fetchData();
  }

  Future<Pokemon> get pokemonList => _pokemonList;

  // Await the http get response, then decode the json-formatted response.
  Future<Pokemon> fetchData() async {
    dynamic jsonResponse;
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);

      // print(jsonResponse);
      notifyListeners();
    } else {
      debugPrint('Failed to load data!');
    }
    final Pokemon pokemon = Pokemon.fromJson(jsonResponse);

    // var pokemons = List<Pokemon>.from(pokemon.map((x) => x.toJson()));
    debugPrint('pokemon: ${pokemon.pokemon[1].toRawJson()}');
    return pokemon;
  }
}
