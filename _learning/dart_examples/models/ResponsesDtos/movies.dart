import "../Abstractions/paged_info.dart";
import "../Catalog/movie.dart";

class MovieResponse {
  final PagedInfo pagedInfo;
  final List<Movie> items;

  MovieResponse({
    required this.pagedInfo,
    required this.items,
  });
}