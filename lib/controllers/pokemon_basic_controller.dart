import 'package:flutter/material.dart';
import 'package:pokemon_flutter/services/pokemon_basic_service.dart';

import '../models/pokemon_basic_data.dart';

class PokemonBasicDataController with ChangeNotifier {
  List<PokemonBasicData> _pokemons = [];

  List<PokemonBasicData> get pokemons {
    return [..._pokemons];
  }

  // bool _isLoading = false;
  // bool get isLoading {
  //   return _isLoading;
  // }

  // create an instance of the basicDataService class
  final basicDataService = PokemonBasicDataService();

  // get all pokemons basic data
  Future<void> getAllPokemons(int offset) async {
    // update ui
    // _isLoading = true;
    // notifyListeners();
    // print(_isLoading);
    final fetchedPokemons = await basicDataService.getAllPokemons(offset);
    // for lazy loading add every new pokemon to the pokemons list
    for (var pokemon in fetchedPokemons) {
      _pokemons.add(pokemon);
    }
    // update ui
    // _isLoading = false;
    notifyListeners();
  }
}