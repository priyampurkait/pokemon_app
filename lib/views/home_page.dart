import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_util.dart';
import 'package:pokedex/utils/navigation_route.dart';
import 'package:pokedex/views/details_page.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/controllers/fetching_data_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<Pokemon> pokemonList =
        context.watch<FetchingDataState>().pokemonList;
    // final mediaQuery = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Pokedex",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.black54, fontWeight: FontWeight.w600),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white.withOpacity(0.9), // Color(0xffF9F9F9)
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FutureBuilder(
          future: pokemonList,
          builder: (BuildContext context, AsyncSnapshot<Pokemon> snapshot) {
            // print('Data: ${snapshot.data.pokemon}');
            debugPrint('Data: ${snapshot.hasData}');

            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(child: Text("Loading"));
              case ConnectionState.waiting:
                return const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 5.2,
                ));
              case ConnectionState.active:
                return const Center(child: CupertinoActivityIndicator());
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return const Center(child: Text("Some Error Occured!"));
                }
                // fetching and showing data
                return _GridView(
                  snapshot: snapshot,
                );
              default:
                return const Center(child: Text("Something wrong!"));
            }
          },
        ),
      ),
    );
  }
}

class _GridView extends StatelessWidget {
  final AsyncSnapshot<Pokemon> snapshot;

  _GridView({
    Key key,
    this.snapshot,
  }) : super(key: key);

  final Map<dynamic, String> _typeValues = typeValues.reverse;
  // var op = List<Pokemon>.from(snapshot.data.pokemon.map((x) => x.toJson()));

  @override
  Widget build(BuildContext context) {
    final List<PokemonElement> pokemonElementList = snapshot.data.pokemon;
    return ListView.builder(
      // padding: EdgeInsets.symmetric(horizontal: 16.0),
      physics: const BouncingScrollPhysics(),
      itemCount: pokemonElementList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            final MaterialPageRoute route =
                NavigationRoute(builder: (BuildContext context) {
              return DetailsPage(
                pokemonElement: pokemonElementList[index],
              );
            });
            Navigator.push(context, route);
          },
          child: _card(pokemonElementList, index, context),
        );
      },
    );
  }

  Widget _card(List<PokemonElement> pokemonElementList, int index,
      BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(6.0),
      ),
      margin: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          top: pokemonElementList[index].id < 2 ? 16.0 : 0.0),
      color:
          PokemonUtil.typeColor(_typeValues[pokemonElementList[index].type[0]])
              .withOpacity(1.0),
      child: Stack(
        children: [
          Align(
            // alignment: Alignment.center,
            child: Opacity(
              opacity: 0.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Image.asset(
                  "assets/images/pokeball.png",
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              // alignment: Alignment.center,
              child: _listItem(pokemonElementList, index, context),
            ),
          ),
        ],
      ),
    );
  }

  ListTile _listItem(List<PokemonElement> pokemonElementList, int index,
      BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: pokemonElementList[index].name,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          imageUrl: pokemonElementList[index].img,
          placeholder: (context, url) => const CupertinoActivityIndicator(
              // radius: 10,
              ),
          errorWidget: (context, url, error) =>
              const Icon(Icons.broken_image_outlined),
        ),
      ),
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(pokemonElementList[index].name,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                )),
      ),
      subtitle: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: pokemonElementList[index]
              .type
              .map((type) => Padding(
                    padding: const EdgeInsets.only(top: 16, right: 8),
                    child: Chip(
                      backgroundColor: PokemonUtil.typeColor(_typeValues[type])
                          .withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      label: Text(
                        _typeValues[type],
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
      trailing: Text('#${pokemonElementList[index].num}',
          style: Theme.of(context).textTheme.button.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              )),
    );
  }
}
