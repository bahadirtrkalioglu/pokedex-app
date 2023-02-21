import 'package:flutter/material.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({super.key});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
    );
  }
}