import 'package:flutter/material.dart';

class PokeColor {
  static const normal = 'normal';
  static const fire = 'fire';
  static const water = 'water';
  static const electric = 'electric';
  static const grass = 'grass';
  static const ice = 'ice';
  static const fighting = 'fighting';
  static const poison = 'poison';
  static const ground = 'ground';
  static const flying = 'flying';
  static const psychic = 'psychic';
  static const bug = 'bug';
  static const rock = 'rock';
  static const ghost = 'ghost';
  static const dragon = 'dragon';
  static const dark = 'dark';
  static const steel = 'steel';
  static const fairy = 'fairy';

  static const _colorMap = {
    normal: Color.fromRGBO(168, 167, 122, 1.000),
    fire: Color.fromRGBO(238, 129, 48, 1.000),
    water: Color.fromRGBO(99, 144, 240, 1.000),
    electric: Color.fromRGBO(247, 208, 44, 1.000),
    grass: Color.fromRGBO(22, 199, 76, 1.000),
    ice: Color.fromRGBO(150, 217, 214, 1.000),
    fighting: Color.fromRGBO(194, 46, 40, 1.000),
    poison: Color.fromRGBO(163, 62, 161, 1.000),
    ground: Color.fromRGBO(226, 191, 101, 1.000),
    flying: Color.fromRGBO(169, 143, 243, 1.000),
    psychic: Color.fromRGBO(249, 85, 135, 1.000),
    bug: Color.fromRGBO(166, 185, 26, 1.000),
    rock: Color.fromRGBO(182, 161, 54, 1.000),
    ghost: Color.fromRGBO(115, 87, 151, 1.000),
    dragon: Color.fromRGBO(111, 53, 252, 1.000),
    dark: Color.fromRGBO(112, 87, 70, 1.000),
    steel: Color.fromRGBO(183, 183, 206, 1.000),
    fairy: Color.fromRGBO(214, 133, 173, 1.000),
  };

  const PokeColor._();
  static getColorFor(String color) => _colorMap[color] ?? _colorMap[normal];
}
