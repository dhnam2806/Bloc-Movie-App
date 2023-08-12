import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/data/models/movies_model.dart';

class FavoriteRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> removeMovieFromFavorites(int movieId) async {
    if (userId != null) {
      final DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        if (data.containsKey('favoriteMovies')) {
          final List<String> favoriteMovies =
              List<String>.from(data['favoriteMovies']);

          if (favoriteMovies.contains(movieId.toString())) {
            await _firestore.collection('users').doc(userId).update({
              'favoriteMovies': FieldValue.arrayRemove([movieId.toString()]),
            });
          }
        }
      }
    }
  }

  Future<List<String>> getFavoriteMovieIds() async {
    final DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(userId).get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('favoriteMovies')) {
        return List<String>.from(data['favoriteMovies']);
      }
    }

    return [];
  }

  Future<void> switchFavoriteMovie(MovieModels movie) async {
    if (userId != null) {
      final DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        if (data.containsKey('favoriteMovies')) {
          final List<String> favoriteMovies =
              List<String>.from(data['favoriteMovies']);

          if (favoriteMovies.contains(movie.id.toString())) {
            await _firestore.collection('users').doc(userId).update({
              'favoriteMovies': FieldValue.arrayRemove([movie.id.toString()]),
            });
          } else {
            await _firestore.collection('users').doc(userId).update({
              'favoriteMovies': FieldValue.arrayUnion([movie.id.toString()]),
            });
          }
        } else {
          await _firestore.collection('users').doc(userId).update({
            'favoriteMovies': [movie.id.toString()],
          });
        }
      }
    }
  }
}
