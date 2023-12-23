
import 'package:flutter/material.dart';
import 'package:ne_izlesem/models/movie.dart';
import 'package:ne_izlesem/screens/search_screen.dart';
import 'package:ne_izlesem/services/api_service.dart';
import 'package:ne_izlesem/widgets/movies_slider.dart';
import 'package:ne_izlesem/widgets/trending_slider.dart';

import '../colors.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upComingMovies;


  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovie();
    topRatedMovies = Api().getTopRatedMovie();
    upComingMovies = Api().getUpComingMovie();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
            'assets/neizlesem.png',
          fit: BoxFit.cover,
          height: 40,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text('Hoşgeldiniz.', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
              Text('Milyonlarca Film, Tv Şovu. Şimdi Keşfedin.', style: TextStyle(fontSize: 15,),),
              SizedBox(height: 30,),
              TextField(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.none,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colours.searchBgColor,
                  hintText: "Hangi Filmi arıyorsun?",
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colours.scaffoldBgColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Trend Movies',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                child: FutureBuilder(
                  future: trendingMovies,
                  builder: (context,snapshot) {
                    if(snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }else if(snapshot.hasData){
                      return TrendingSlider(snapshot: snapshot,);
                    }else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
              SizedBox(height: 25,),
              Text('Top Rated movies', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20,),
              SizedBox(
                child: FutureBuilder(
                  future: topRatedMovies,
                  builder: (context,snapshot) {
                    if(snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }else if(snapshot.hasData){
                      return MoviesSlider(snapshot: snapshot,);
                    }else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
              SizedBox(height: 25,),
              Text('Upcoming Movies', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20,),
              SizedBox(
                child: FutureBuilder(
                  future: upComingMovies,
                  builder: (context,snapshot) {
                    if(snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }else if(snapshot.hasData){
                      return MoviesSlider(snapshot: snapshot,);
                    }else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
