import 'package:flutter/material.dart';
import 'package:pokemon_flutter/controllers/search_controller.dart';
import 'package:pokemon_flutter/ui/widgets/search_widgets/search_terminal_widget.dart';
import 'package:provider/provider.dart';

import '../../controllers/theme_controller.dart';
import 'package:pokemon_flutter/utils/constants.dart' as constants;


class SearchedAbilityScreen extends StatefulWidget {
  final String abilityName;
  const SearchedAbilityScreen({Key? key, required this.abilityName}) : super(key: key);

  @override
  State<SearchedAbilityScreen> createState() => _SearchedAbilityScreenState();
}

class _SearchedAbilityScreenState extends State<SearchedAbilityScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Provider.of<ThemeController>(context).themeData;
    bool isDark = themeData == ThemeData.dark();

    String flavorText = '';
    List<String> pokemonsNames = [];

    Future<void> getAbilityData() async {
      final Map<String, dynamic> abilityData = await Provider.of<SearchPokemonsController>(context, listen: false).getAbilityData(widget.abilityName);
      flavorText = abilityData['flavorText'];
      pokemonsNames = abilityData['pokemonsNames'];
    }

    // navigate to pokemon data
    void navigateToPokemonData(String name, bool isDarkTheme) async {
      final Map<String, dynamic> pokemonData =
      await Provider.of<SearchPokemonsController>(context, listen: false)
          .getPokemonDataByName(name, isDarkTheme);
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                SearchedPokemonTerminalWidget(
                    isDark: isDark,
                    pokemon: pokemonData['pokemon'],
                    imageUrl: pokemonData['imageUrl'],
                    id: pokemonData['id'])));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.abilityName),
        backgroundColor: isDark
            ? constants.appBarDarkThemeColor
            : constants.appBarLightThemeColor,
      ),
    body: FutureBuilder(
      future: getAbilityData(),
      builder: (context, dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: constants.circularProgressIndicatorColor,));
        } else{
          return Padding(
            padding: const EdgeInsets.all(constants.mediumPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ability Description:', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.grey)),
                const SizedBox(height: constants.smallPadding),
                Text(flavorText, style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: constants.largePadding),
                Text('Pokemons who use this ability:', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.grey)),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: pokemonsNames.length,
                      itemBuilder: (context, index) {
                      final String pokemonName = pokemonsNames[index];
                        return GestureDetector(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: constants.mediumPadding),
                              Text('${index + 1}.$pokemonName', style: Theme.of(context).textTheme.headline6,),
                              const SizedBox(height: constants.mediumPadding),
                              const Divider(height: 5),
                            ],
                          ),
                          onTap: () {
                            navigateToPokemonData(pokemonName, isDark);
                          },
                        );
                      }),
                ),
              ],
            ),
          );
        }
      },
    ),);
  }
}
