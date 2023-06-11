import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../models/movie.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    //obtener tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    return Container(
      //establecer contenedor a lo ancho de la pantalla
      width: double.infinity,
      //establecer el contenedor a lo alto en un 50%
      height: size.height * 0.5,
      child: Swiper(
        //tamaño de carrusel de imagen
        itemCount: movies.length,
        //tipo de carrusel
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        //lo que contiene el carrusel
        itemBuilder: (_, int index) {

          final movie = movies[index];


          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            //widget para redondear bordes
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                //web api que descarga una imagen de 300 x 400
                placeholder: NetworkImage('https://via.placeholder.com/300x400'),
                image: NetworkImage(movie.fullPosterImg),
                //tomar forma de contenedor padre
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}