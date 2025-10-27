import '../../../core/models/hotel.dart';

class HotelListModel {
  final bool isLoading;
  final String? errorMessage;
  final List<Hotel> hotels;
  final String searchQuery;
  final bool isShowingSearchResults;
  final HotelSearchResponse? searchResponse;

  const HotelListModel({
    this.isLoading = false,
    this.errorMessage,
    this.hotels = const [],
    this.searchQuery = '',
    this.isShowingSearchResults = false,
    this.searchResponse,
  });

  HotelListModel copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Hotel>? hotels,
    String? searchQuery,
    bool? isShowingSearchResults,
    HotelSearchResponse? searchResponse,
  }) {
    return HotelListModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      hotels: hotels ?? this.hotels,
      searchQuery: searchQuery ?? this.searchQuery,
      isShowingSearchResults: isShowingSearchResults ?? this.isShowingSearchResults,
      searchResponse: searchResponse ?? this.searchResponse,
    );
  }
}
