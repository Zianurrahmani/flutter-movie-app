import 'package:flutter/material.dart';
import 'package:movie_app/widgets/image.dart';

import '../models/movie_model.dart';

class ItemMovie extends Container {
  final MovieModel movie;
  final double widthBackdrop;
  final double heightBackdrop;

  ItemMovie(
      {required this.movie,
      required this.widthBackdrop,
      required this.heightBackdrop,
      super.key});

  @override
  Clip get clipBehavior => Clip.hardEdge;

  @override
  Decoration? get decoration =>
      BoxDecoration(borderRadius: BorderRadius.circular(10));

  @override
  Widget? get child => Stack(
        children: [
          SizedBox(
            height: heightBackdrop,
            // padding: EdgeInsets.only(top: 10),
            child: ImageWidget(
              imageSrc: '${movie.backdropPath}',
              height: heightBackdrop,
              width: widthBackdrop,
            ),
          ),
          Container(
            // height: 200,
            width: widthBackdrop,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87])),
          ),
          Positioned(
              bottom: 10,
              left: 15,
              right: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Text(
                        '${movie.voteAverage}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      );
}
