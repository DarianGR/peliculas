import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u3_peliculas_clase/providers/movies_provider.dart';
import 'package:u3_peliculas_clase/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined)
          ),
        ],
        title: const Center(
          child: Text('Película'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(
              movies: moviesProvider.onDisplayMovies
            ),
            MovieSlider(
              movies: moviesProvider.popularMovies
            ),
          ],
        ),
      ),
    );
  }
}