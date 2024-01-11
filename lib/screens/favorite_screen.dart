import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ne_izlesem/constant.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(child: Text('Lütfen giriş yapın.'));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Favorilerim'),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('favorites')
            .doc(user.uid)
            .collection('movies')
            .orderBy('addedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var movie = snapshot.data!.docs[index];
              String title = movie['title'] ?? '';
              String posterPath = movie['posterPath'] ?? '';

              if (title.isEmpty || posterPath.isEmpty) {
                print("Eksik alan: ${movie.id} - $movie");  // Hangi belgenin eksik alanı olduğunu görmek için
              }

              return ListTile(
                leading: Image.network('${Constants.imagePath}${posterPath}'), // Film posteri
                title: Text(title), // Film başlığı
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => removeFromFavorites(context, movie.id),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> removeFromFavorites(BuildContext context,String movieId) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection("favorites")
          .doc(user.uid)
          .collection('movies')
          .doc(movieId)
          .delete()
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Favori kaldırıldı!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $error')),
        );
      });
    }
  }
}