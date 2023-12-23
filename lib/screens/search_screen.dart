import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ne_izlesem/screens/details_screen.dart';
import '../colors.dart';
import '../constant.dart';
import '../models/movie.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<Movie> searchResults = [];
  TextEditingController searchController = TextEditingController();

  static const _searchBaseUrl = 'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}';

  Future<void> _searchMovies(String title) async {
    final _searchUrl = '$_searchBaseUrl&query=$title&include_adult=false&language=en-US&page=1';
    final response = await http.get(Uri.parse(_searchUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      setState(() {
        searchResults = decodedData.map((movie) => Movie.fromJson(movie)).toList();
      });
    } else {
      throw Exception('Something Happened');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          style: TextStyle(color: Colors.white),
          controller: searchController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colours.searchBgColor,
            hintText: "Film Ara...",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            _searchMovies(value);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _searchMovies(searchController.text);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25,),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(movie: searchResults[index])));
                  },
                  title: Text(searchResults[index].title ?? '',style:  TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(searchResults[index].releaseDate ?? '',style: TextStyle(fontWeight: FontWeight.w600),),
                  trailing: Text(
                          "${searchResults[index].voteAverage?.toStringAsFixed(1)}",
                           style: TextStyle(color: Colors.amber),
                      ),
                  leading: Image.network(
                    '${Constants.imagePath}${searchResults[index].posterPath}',
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                      return Image.asset('assets/resim-yok.jpg',
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}