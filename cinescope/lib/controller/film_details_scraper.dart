import 'package:cinescope/model/film.dart';
import 'package:cinescope/controller/IMDB_scrapper.dart';

class FilmDetailsScraper {
  static Future<Film> getFilmDetails(String url) async {
    final filmData = await ImdbScraper.getFilmData(url);
    String title = filmData['title'];
    int year = filmData['year'];
    String imgUrl = filmData['imgUrl'];
    String duration = filmData['duration'];
    String description = filmData['description'];
    double rating = filmData['rating'].toDouble();
    Map<String, Map<String, List<String>>> cast = filmData['cast'];

    print(cast);
    final film =
        Film(url, title, year, imgUrl, duration, description, rating, cast);
    return film;
  }
}
