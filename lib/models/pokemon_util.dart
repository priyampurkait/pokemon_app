import 'package:flutter/material.dart';

class PokemonUtil {
  // "Bug" "Dark" "Dragon" "Electric" "Fairy" "Fighting" "Fire" "Flying"
  // "Ghost" "Grass" "Ground" "Ice" "Normal" "Poison" "Psychic" "Rock"
  // "Steel" "Water"

  static Color typeColor(String type) {
    switch (type) {
      case "Bug":
        return const Color(0xffA8A878);
      case "Dark":
        return const Color(0xff705848);
      case "Dragon":
        return const Color(0xff7563F7);
      case "Electric":
        return const Color(0xffF8D030);
      case "Fairy":
        return const Color(0xffEE99AC);
      case "Fighting":
        return const Color(0xffC13A37);

      case "Fire":
        return const Color(0xffF08030);
      case "Flying":
        return const Color(0xffA990F0);
      case "Ghost":
        return const Color(0xff705898);
      case "Grass":
        return const Color(0xff78C851);
      case "Ground":
        return const Color(0xffE0C068);
      case "Ice":
        return const Color(0xff98D8D8);

      case "Normal":
        return const Color(0xffA8A878);
      case "Poison":
        return const Color(0xffA04AA0);
      case "Psychic":
        return const Color(0xffEE5588);
      case "Rock":
        return const Color(0xffB8A038);
      case "Steel":
        return const Color(0xffB8B8D0);
      case "Water":
        return const Color(0xff6890F0);

      default:
        return Colors.black54;
    }
  }
}
