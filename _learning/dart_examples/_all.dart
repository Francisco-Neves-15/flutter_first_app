// Class "Movie"
class Movie {
  final String id;
  final String title;
  final String genre;
  bool watched;

  // Constructor
  Movie({
    required this.id,
    required this.title,
    required this.genre,
    this.watched = false,
  });

  @override
  String toString() {
    return "Movie(id: $id, title: $title, genre: $genre, watched: $watched)";
  }
}

final allMovies = [
  Movie(
    id: "85471287",
    title: "Matrix",
    genre: "Sci-Fi",
  ),
  Movie(
    id: "01293842",
    title: "Avatar",
    genre: "Action",
  ),
];

Future<List<Movie>> loadMovies() async {
  return allMovies;
}

void main() async {
  final movies = await loadMovies();
  print(movies);

  final whoCheck = "01293842";

  // For Using
  for (var movie in movies) {
    print("${movie.id}: ${movie.title} | ${movie.genre} | ${movie.watched}");
    if (movie.id == whoCheck) {
      movie.watched = true;
    }
    print("${movie.id}: ${movie.title} | ${movie.genre} | ${movie.watched}");
  }

  // Map Usugin
  final allMoviesTitle = movies.map((movie) => movie.title).toList();
  print(allMoviesTitle);

  // Where (filter)
  final sciFi = movies.where((movie) => movie.genre == "Sci-Fi").toList();
  for (var sf in sciFi) {
    print(sf.title);
    print(sf);
  }

}
