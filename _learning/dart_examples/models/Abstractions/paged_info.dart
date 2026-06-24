class PagedInfo {
  final int pageNumber;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  PagedInfo({
    required this.pageNumber,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });
}