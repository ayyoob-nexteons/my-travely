import '../../../core/models/hotel.dart';

class SearchResultsModel {
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final List<Hotel> hotels;
  final String searchQuery;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;
  final HotelSearchResponse? searchResponse;

  const SearchResultsModel({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.hotels = const [],
    this.searchQuery = '',
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasNextPage = false,
    this.searchResponse,
  });

  SearchResultsModel copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    List<Hotel>? hotels,
    String? searchQuery,
    int? currentPage,
    int? totalPages,
    bool? hasNextPage,
    HotelSearchResponse? searchResponse,
  }) {
    return SearchResultsModel(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
      hotels: hotels ?? this.hotels,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      searchResponse: searchResponse ?? this.searchResponse,
    );
  }
}
