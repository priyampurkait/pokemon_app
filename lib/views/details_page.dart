import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_util.dart';

class DetailsPage extends StatelessWidget {
  final PokemonElement pokemonElement;
  const DetailsPage({this.pokemonElement});
  // final PokemonUtil pokemonUtil = PokemonUtil();

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, String> _typeValues = typeValues.reverse;
    // List<Type> _elementType = pokemonElement.type;
    final Type _firstElement = pokemonElement.type[0];
    // final mediaQuery = MediaQuery.of(context).platformBrightness;
    debugPrint('${pokemonElement.prevEvolution}');
    debugPrint('${pokemonElement.nextEvolution}');
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor:
          PokemonUtil.typeColor(_typeValues[_firstElement]).withOpacity(1.0),
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black54, //change your color here
        ),
        title: Text("#${pokemonElement.num}",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.black54, fontWeight: FontWeight.w600)),
        elevation: 0.0,
        backgroundColor:
            PokemonUtil.typeColor(_typeValues[_firstElement]).withOpacity(0.9),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            systemNavigationBarColor:
                PokemonUtil.typeColor(_typeValues[_firstElement])
                    .withOpacity(1.0),
            systemNavigationBarIconBrightness: Brightness.light),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Opacity(
                        opacity: 0.1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Image.asset(
                            "assets/images/pokeball_dark.png",
                            height: MediaQuery.of(context).size.height / 2.6,
                            width: MediaQuery.of(context).size.height / 2.6,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                        child: Center(
                      child: Hero(
                        tag: pokemonElement.name,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height / 4,
                          // width: MediaQuery.of(context).size.width / 2,
                          filterQuality: FilterQuality.high,
                          imageUrl: pokemonElement.img,
                          placeholder: (context, url) =>
                              const CupertinoActivityIndicator(
                                  // radius: 10,
                                  ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.broken_image_outlined),
                        ),
                      ),
                    ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(pokemonElement.name,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 16.0),
                    Text("Type",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700)),
                    Row(
                      children: pokemonElement.type
                          .map((type) => Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, right: 8),
                                child: Chip(
                                  backgroundColor:
                                      PokemonUtil.typeColor(_typeValues[type])
                                          .withOpacity(0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  label: Text(
                                    _typeValues[type],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800],
                                        ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text("Weaknesses",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700)),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: pokemonElement.weaknesses
                            .map((weaknesses) => Padding(
                                  padding:
                                      const EdgeInsets.only(top: 16, right: 8),
                                  child: Chip(
                                    backgroundColor: PokemonUtil.typeColor(
                                            _typeValues[weaknesses])
                                        .withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    label: Text(
                                      _typeValues[weaknesses],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                          ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text("Height: ${pokemonElement.height}",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text("Weight: ${pokemonElement.weight}",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    if (pokemonElement.nextEvolution != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text("Next Evolution",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700)),
                          ),
                          Row(
                            children: pokemonElement.nextEvolution
                                .map((evolution) => Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, right: 8),
                                      child: Chip(
                                        backgroundColor: PokemonUtil.typeColor(
                                                _typeValues[_firstElement])
                                            .withOpacity(0.4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        label: Text(
                                          evolution.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[800],
                                              ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    if (pokemonElement.prevEvolution != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text("Previous Evolution",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700)),
                          ),
                          Row(
                            children: pokemonElement.prevEvolution
                                .map((evolution) => Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, right: 8),
                                      child: Chip(
                                        backgroundColor: PokemonUtil.typeColor(
                                                _typeValues[_firstElement])
                                            .withOpacity(0.4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        label: Text(
                                          evolution.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[800],
                                              ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
