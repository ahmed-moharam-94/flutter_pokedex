import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_flutter/services/pokemon_basic_service.dart';
import 'package:pokemon_flutter/services/pokemons_search_service.dart';
import 'package:pokemon_flutter/utils/colors_generator.dart';

import '../models/pokemon_basic_data.dart';

class SearchPokemonsController with ChangeNotifier {
  PokemonsSearchService pokemonSearchService = PokemonsSearchService();

  List<String> _pokemonsNames = [];

  List<String> get pokemonsNames {
    return [..._pokemonsNames];
  }

  List<String> _pokemonsAbilities = [];

  List<String> get pokemonsAbilities {
    return [..._pokemonsAbilities];
  }


  // get all pokemons names
  Future<void> getAllPokemonsNames() async {
    final fetchedPokemonsAbilities =
        await pokemonSearchService.getAllAbilities();
    _pokemonsNames = fetchedPokemonsAbilities;
    notifyListeners();
  }

  // get all pokemons abilities
  Future<void> getAllAbilities() async {
    final fetchedPokemonsNames =
        await pokemonSearchService.getAllPokemonsNames();
    _pokemonsAbilities = fetchedPokemonsNames;
    notifyListeners();
  }

  // get pokemon data by name
  PokemonBasicDataService pokemonBasicDataService = PokemonBasicDataService();
  ColorsGenerator colorsGenerator = ColorsGenerator();

  Future<Map<String, dynamic>> getPokemonDataByName(
      String name, bool isDarkTheme) async {
    final fetchedPokemonData =
        await pokemonBasicDataService.getPokemonByName(name);

    PokemonBasicData pokemonBasicData = PokemonBasicData(
      name: fetchedPokemonData['name'],
      url: fetchedPokemonData['url'],
    );

    Map<String, dynamic> pokemonData = {
      'name': fetchedPokemonData['name'],
      'id': fetchedPokemonData['id'],
      'imageUrl': fetchedPokemonData['imageUrl'],
      'pokemon': pokemonBasicData
    };
    return pokemonData;
  }


  // get pokemons by ability
  Future<Map<String, dynamic>> getAbilityData(String ability) async {
    Map<String, dynamic> abilityData = {};
    final fetchedAbilityData = await pokemonSearchService.getAbilityData(ability);
    abilityData = {
      'flavorText': fetchedAbilityData['flavorText'],
      'pokemonsNames': fetchedAbilityData['pokemonsNames'],
    };
    return abilityData;
  }
}
