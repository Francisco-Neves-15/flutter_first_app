import 'models/Catalog/movie.dart';

void main() {

  final movie = Movie(
    id: "45e2e647-2d34-407e-a9af-742cf09b4d43",
    title: "Matrix",
    imageUrl: "matrix.jpg",
  );

  print(movie.title);
  print(movie.imageUrl);

}