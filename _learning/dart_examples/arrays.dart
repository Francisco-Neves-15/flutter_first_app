void main() {

  List<String> movies = [
    "Matrix",
    "Avatar",
  ];

  movies.add("Batman");

  final upper = movies.map((m) => m.toUpperCase()).toList();

  print(movies);
  print(upper);

  for (final movie in movies) {
    print(movie);
  }

}