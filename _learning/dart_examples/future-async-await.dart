import 'models/Catalog/movie.dart';

// Future is the Promise

Future<List<Movie>> fetchMovies() async {
  return [];
}

Future<String> getName() async {
  return "Francisco";
}

Future<void> loadMovies() async {
  // final movies = await api.getMovies();
  // print(movies.length);
}

void main() async {

  // the "await" is used to say "a awaiting for the content, not for the Instance of 'Future<List<Movie>>'"

  final name = await getName();
  final data = await fetchMovies();
  print(name);
  print(data);
  loadMovies();
}