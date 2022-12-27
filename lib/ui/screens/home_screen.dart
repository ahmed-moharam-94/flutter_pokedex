import 'package:flutter/material.dart';
import 'package:pokemon_flutter/controllers/pokemon_basic_controller.dart';
import 'package:provider/provider.dart';
import '../../controllers/theme_controller.dart';
import '../widgets/bottom_loading_bar_widget.dart';
import '../widgets/home_screen_sliver_app_bar.dart';
import '../widgets/custom_sliver_grid_view.dart';
import 'package:pokemon_flutter/utils/constants.dart' as constants;


class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  int offset = 0;
  bool atBottom = false;
  bool loadData = false;

  @override
  void initState() {
    fetchPokemons();
    pokemonLazyLoading();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Provider.of<ThemeController>(context).themeData;
    bool isDark = themeData == ThemeData.dark();
    return Scaffold(
        backgroundColor: isDark
            ? constants.scaffoldDarkThemeColor
            : constants.scaffoldLightThemeColor,
        body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: constants.mediumPadding),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                const CustomSliverAppBar(),
                // add space between the appBar and the gridview
                const SliverToBoxAdapter(
                    child: SizedBox(height: constants.mediumPadding)),
                const CustomSliverGridView(),
                // bottom circular progress indicator show when at the bottom of the grid and fetch new data
                if (atBottom && loadData) const BottomLoadingBarWidget(),
                // if at the end of the grid and no more data just add some space to the bottom of the grid
                if (atBottom && !loadData)
                  const SliverToBoxAdapter(
                      child: SizedBox(height: constants.mediumPadding))
              ],
            )));
  }

  Future<void> fetchPokemons() async {
    // Call the future one in init state
    await Provider.of<PokemonBasicDataController>(context, listen: false)
        .getAllPokemons(offset);
  }

  Future<void> pokemonLazyLoading() async {
    // fire at the bottom of the screen
    setState(() {
      atBottom = true;
      loadData = true;
    });
    // set the scroll Controller
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        // if reached the bottom of the grid change offset and fetch new data
        if (!isTop) {
          offset += 20;
          fetchPokemons();
        }
      } else if (offset >= 980) {
        setState(() {
          loadData = false;
          atBottom = false;
        });
      }
    });
  }
}
