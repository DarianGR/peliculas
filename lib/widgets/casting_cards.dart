import 'package:flutter/material.dart';
import '../models/models.dart';

class CastingCards extends StatelessWidget {
  final Movie pelicula;
  final List<dynamic>? actors;

  const CastingCards({super.key, required this.pelicula, required this.actors});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("Casting: ");
    List<CastElement> castMovies = actors!.cast<CastElement>();
    print(castMovies[0].name);

    return Container(
      width: double.infinity,
      height: size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              "Actores",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
            itemCount: 20,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastingPoster(castMovies: castMovies[index]),
          )),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _CastingPoster extends StatelessWidget {
  CastElement castMovies;
  _CastingPoster({super.key, required this.castMovies});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: NetworkImage('https://via.placeholder.com/300x400'),
              image: NetworkImage(castMovies.getFoto()),
              width: 120,
              height: 155,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            castMovies.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}