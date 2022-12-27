import 'package:flutter/material.dart';
import 'package:pokemon_flutter/ui/widgets/search_widgets/search_result_widget.dart';
import 'package:pokemon_flutter/utils/constants.dart' as constants;
import 'package:provider/provider.dart';

import '../../../controllers/search_controller.dart';
import '../../../controllers/theme_controller.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool isNameFilterSelected = false;
  bool isAbilityFilterSelected = false;
  List<String> searchList = [];
  late SearchPokemonsController searchProvider;
  List<String> resultList = [];
  final textEditController = TextEditingController();
  String subText = '';

  @override
  void initState() {
    searchProvider =
        Provider.of<SearchPokemonsController>(context, listen: false);
    // when search screen open, search in pokemons names by default
    isNameFilterSelected = true;
    fetchAllPokemonsNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Provider.of<ThemeController>(context).themeData;
    bool isDark = themeData == ThemeData.dark();

    void updateResultList(String text) {
      setState(() {
        subText = text;
        resultList = searchList.where((item) => item.toLowerCase().contains(text)).toList();
      });
    }

    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              ChoiceChip(
                  label: Text('Name',
                      style: TextStyle(
                          color: isDark
                              ? Colors.white
                              : isNameFilterSelected
                              ? Colors.white
                              : Colors.black)),
                  selectedColor: isDark
                      ? constants.selectedDarkThemeColor
                      : constants.selectedLightThemeColor,
                  selected: isNameFilterSelected,
                  onSelected: (selectValue) {
                    setState(() {
                      isNameFilterSelected = true;
                      isAbilityFilterSelected = false;
                      // when filter changes clear the result list
                      resultList = [];
                    });
                    // when filter changes clear the textField
                    textEditController.clear();
                    fetchAllPokemonsNames();
                  }),
              const SizedBox(width: constants.mediumPadding),
              ChoiceChip(
                  label: Text('Ability',
                      style: TextStyle(
                          color: isDark
                              ? Colors.white
                              : isAbilityFilterSelected
                              ? Colors.white
                              : Colors.black)),
                  selectedColor: isDark
                      ? constants.selectedDarkThemeColor
                      : constants.selectedLightThemeColor,
                  selected: isAbilityFilterSelected,
                  onSelected: (selectValue) {
                    setState(() {
                      isAbilityFilterSelected = true;
                      isNameFilterSelected = false;
                      // when filter changes clear the result list
                      resultList = [];
                    });
                    // when filter changes clear the textField
                    textEditController.clear();
                    fetchAllAbilities();
                  }),
            ],
          ),
          const SizedBox(height: constants.mediumPadding),
          Expanded(
            child: Column(
              children: [
                Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: constants.smallPadding),
                    height: constants.searchContainerHeight,
                    decoration: BoxDecoration(
                        color: constants.searchContainerLightThemeColor,
                        borderRadius:
                        BorderRadius.circular(constants.containerCornerRadius)),
                    child:  Center(
                      child: TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: textEditController,
                        cursorColor: constants.leftSearchIconColor,
                        decoration: InputDecoration(
                            hintText: isNameFilterSelected? 'Type the name of the Pokemon': 'Type the name of the ability',
                            hintStyle: const TextStyle(color: constants.searchHintTextColor),
                            border: InputBorder.none,
                            // disable the underline in the TextField
                            icon: const Icon(
                              Icons.search,
                              color: constants.leftSearchIconColor,
                            )),
                        onChanged: (value) {
                          updateResultList(value);
                        },
                      ),
                    )),
                const SizedBox(height: constants.mediumPadding),
                Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: resultList.length,
                        itemBuilder: (context, index) {
                          final resultText = resultList[index];
                          return SearchResultItemWidget(resultText: resultText, nameFilter: isNameFilterSelected);
                        })),
              ],
            ),
          ),
        ],
      ),
    )
    ;
  }

  Future<void> fetchAllPokemonsNames() async {
    await searchProvider.getAllPokemonsNames();
    searchList = searchProvider.pokemonsNames;
  }

  Future<void> fetchAllAbilities() async {
    await searchProvider.getAllAbilities();
    searchList = searchProvider.pokemonsAbilities;
  }
}



