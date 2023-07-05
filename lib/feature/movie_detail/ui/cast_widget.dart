import 'package:flutter/material.dart';

import 'package:movie_app/feature/movies/models/cast_model.dart';

class CastWidget extends StatelessWidget {
  final List<CastModels> castList;
  CastWidget({
    required this.castList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: castList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${castList[index].profilePath}',
                    height: 160,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    castList[index].name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    castList[index].character!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
