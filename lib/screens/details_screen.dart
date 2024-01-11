import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ne_izlesem/colors.dart';
import 'package:ne_izlesem/constant.dart';
import 'package:ne_izlesem/models/movie.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}
class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Container(
              height: 70,
              width: 70,
              margin: EdgeInsets.only(top:16,left: 16),
              decoration: BoxDecoration(
                color: Colours.scaffoldBgColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_rounded),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null, // Favori ise kırmızı rengini uygula.
                ),
                onPressed: () {
                  toggleFavorite(widget.movie.id.toString(), widget.movie.title, widget.movie.posterPath);
                },
              ),
            ],
            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
            background: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24),bottomRight: Radius.circular(24)),
              child: Image.network('${Constants.imagePath}${widget.movie.posterPath}',
              filterQuality: FilterQuality.high,
               fit: BoxFit.fill,

              ),
            ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text('${widget.movie.title}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color:Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Release date: ${widget.movie.releaseDate}'),
                      ),
                      SizedBox(width: 8,),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color:Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:Row(children: [
                          Icon(Icons.star,color: Colors.amber,),
                          Text('${widget.movie.voteAverage?.toStringAsFixed(1)}/10',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Text('Overview',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  SizedBox(height: 12,),
                  Text('${widget.movie.overview}',style: TextStyle(fontSize: 15),),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> toggleFavorite(String movieId, String? title, String? posterPath) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      // Eğer film zaten favorilere ekliyse, kaldır.
      if (isFavorite) {
        await firebaseFirestore
            .collection("favorites")
            .doc(user.uid)
            .collection('movies')
            .doc(movieId)
            .delete();
        setState(() {
          isFavorite = false;
        });
        Fluttertoast.showToast(msg: "Favoriden kaldırıldı!");
      } else {
        // Eğer film favorilere eklenmediyse, ekle.
        await firebaseFirestore
            .collection("favorites")
            .doc(user.uid)
            .collection('movies')
            .doc(movieId)
            .set({
          'addedAt': Timestamp.now(),
          'title': title,         // Film başlığını kaydet.
          'posterPath': posterPath // Film poster yolunu kaydet.
        });
        setState(() {
          isFavorite = true;
        });
        Fluttertoast.showToast(msg: "Favoriye eklendi!");
      }
    }
  }
}
