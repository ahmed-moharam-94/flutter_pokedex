import 'package:flutter/cupertino.dart';
import 'package:pokemon_flutter/services/pokemon_basic_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pokemon_basic_data.dart';

class PokemonFavoritesController with ChangeNotifier {

  PokemonBasicDataService pokemonBasicDataService = PokemonBasicDataService();

  // handle favorite pokemons
  late SharedPreferences prefs;

  List<String> _favoritePokemonsNames = [];


  List<PokemonBasicData> _favoritePokemons = [];

  List<PokemonBasicData> get favoritePokemons {
    return [..._favoritePokemons];
  }

  // sort a list alphabetically descending
  void sortList(List<String> savedPokemons) {
    savedPokemons
      .sort((item1, item2) => item1.compareTo(item2));
  }

  // toggle pokemons from sharedPreferences
  Future<void> toggleFavoritePokemon(String pokemonName) async {
    prefs = await SharedPreferences.getInstance();
    // first get the favorite list from sharedPrefs
    List<String>? savedPokemons = [];
    savedPokemons = prefs.getStringList('favoritePokemons');

    // if the there in no saved pokemons the list is null so make it equal empty
    savedPokemons ??= [];

    if (savedPokemons.contains(pokemonName)) {
      // if the list contain the pokemon delete it
      savedPokemons.removeWhere((name) => pokemonName == name);
      // update favorite list to update ui
      _favoritePokemons.removeWhere((pokemon) => pokemon.name == pokemonName);
    } else {
      // if the list doesn't have the pokemon add it
      savedPokemons.add(pokemonName);
    }
    prefs.setStringList('favoritePokemons', savedPokemons);
    _favoritePokemonsNames = savedPokemons;

    notifyListeners();
  }

  // load favorite pokemons names from sharedPreferences
  Future<void> loadFavoritePokemonsNamesFromSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? savedPokemons = [];
    savedPokemons = prefs.getStringList('favoritePokemons');
    // if the there in no saved pokemons the list is null so make it equal empty
    savedPokemons ??= [];
    // sort the list alphabetically descending
    sortList(savedPokemons);
    _favoritePokemonsNames = savedPokemons;
    notifyListeners();
  }

  // Check if pokemon is favorite in sharedPreferences
  Future<bool> isPokemonFavorite(String pokemonName) async {
    prefs = await SharedPreferences.getInstance();
    // check if the pokemon name is in the saved list
    List<String>? savedPokemons = [];
    savedPokemons = prefs.getStringList('favoritePokemons');

    // if the there in no saved pokemons the list is null so make it equal empty
    savedPokemons ??= [];
    if (savedPokemons.contains(pokemonName)) {
      return true;
    } else {
      return false;
    }
  }

  // get favorite pokemons data
  Future<void> getFavoritePokemonsData() async {
    List<PokemonBasicData> favPokemons = [];
    // load favorite pokemons data from shared pref
    await loadFavoritePokemonsNamesFromSharedPref();

    for (String name in _favoritePokemonsNames) {
      final pokemonData = await pokemonBasicDataService.getPokemonByName(name);
      final PokemonBasicData basicPokemonData = PokemonBasicData(
          name: pokemonData['name'],
          url: pokemonData['url'],
          id: pokemonData['id'],
          imageUrl: pokemonData['imageUrl']);
      favPokemons.add(basicPokemonData);
    }
    _favoritePokemons = favPokemons;
    notifyListeners();
  }
}
