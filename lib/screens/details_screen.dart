import 'package:flutter/material.dart';
import 'package:ne_izlesem/colors.dart';
import 'package:ne_izlesem/constant.dart';
import 'package:ne_izlesem/models/movie.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

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

            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
            background: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24),bottomRight: Radius.circular(24)),
              child: Image.network('${Constants.imagePath}${movie.posterPath}',
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
                  Text('${movie.title}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
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
                        child: Text('Release date: ${movie.releaseDate}'),
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
                          Text('${movie.voteAverage?.toStringAsFixed(1)}/10',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Text('Overview',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  SizedBox(height: 12,),
                  Text('${movie.overview}',style: TextStyle(fontSize: 15),),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
