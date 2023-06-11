import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../providers/movies_provider.dart';
import '../widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pelicula = ModalRoute.of(context)?.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(pelicula: pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(pelicula: pelicula),
              _Overview(pelicula: pelicula),
              _crearCasting(pelicula),
            ])
          ),
        ],
      ),
    );
  }
}

Widget _crearCasting(Movie pelicula) {
  final movieProvider = MoviesProvider();

  return FutureBuilder(
    future: movieProvider.getActors(pelicula.id.toString()),
    builder: (context, AsyncSnapshot<List> snapshot) {
      if (snapshot.hasData) {
        return CastingCards(pelicula: pelicula, actors: snapshot.data);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

class _CustomAppBar extends StatelessWidget {
  final Movie pelicula;
  const _CustomAppBar({super.key, required this.pelicula});
  

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true, 
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            pelicula.title,
            style: TextStyle(fontSize: 18),
          ),
        ),
        background: FadeInImage(
          placeholder: NetworkImage('https://via.placeholder.com/300x400'),
          image: NetworkImage(pelicula.fullPosterImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({super.key, required this.pelicula});
  final Movie pelicula;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder:
                  const NetworkImage('https://via.placeholder.com/300x400'),
              image: NetworkImage(pelicula.fullPosterImg),
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  pelicula.originalTitle,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_outline,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({super.key, required this.pelicula});
  final Movie pelicula;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}