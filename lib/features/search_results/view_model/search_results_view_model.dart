import 'package:flutter/material.dart';
import '../model/search_results_model.dart';
import '../../../core/services/hotel_api_service.dart';
import '../../../core/models/hotel.dart';

class SearchResultsViewModel extends ChangeNotifier {
  SearchResultsModel _model = const SearchResultsModel();

  SearchResultsModel get model => _model;

  void _updateModel(SearchResultsModel newModel) {
    _model = newModel;
    notifyListeners();
  }

  Future<void> searchHotels(String query) async {
    try {
      _updateModel(_model.copyWith(
        isLoading: true,
        errorMessage: null,
        hotels: [],
        currentPage: 1,
        searchResponse: null,
        searchQuery: query,
      ));

      final response = await HotelApiService.searchHotelsByQuery(query);
      
      _updateModel(_model.copyWith(
        isLoading: false,
        hotels: response.hotels,
        currentPage: response.currentPage,
        totalPages: response.totalPages,
        hasNextPage: response.hasNextPage,
        searchResponse: response,
      ));
    } catch (e) {
      _updateModel(_model.copyWith(
        isLoading: false,
        errorMessage: 'Search failed: $e',
      ));
    }
  }

  Future<void> loadMoreResults() async {
    if (!_model.hasNextPage || _model.isLoadingMore) return;

    try {
      _updateModel(_model.copyWith(isLoadingMore: true));

      // For now, we'll just return since the API doesn't support pagination
      // In a real implementation, you would make another API call with offset/limit
      _updateModel(_model.copyWith(isLoadingMore: false));
    } catch (e) {
      _updateModel(_model.copyWith(
        isLoadingMore: false,
        errorMessage: 'Failed to load more results: $e',
      ));
    }
  }

  Future<void> refreshSearch() async {
    await searchHotels(_model.searchQuery);
  }

  void clearError() {
    _updateModel(_model.copyWith(errorMessage: null));
  }
}
