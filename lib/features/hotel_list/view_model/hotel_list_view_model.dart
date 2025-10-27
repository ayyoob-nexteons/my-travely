import 'package:flutter/material.dart';
import '../model/hotel_list_model.dart';
import '../../../core/navigation/navigation_utils.dart';
import '../../../core/services/hotel_api_service.dart';
import '../../../core/storage/local_storage_service.dart';

class HotelListViewModel extends ChangeNotifier {
  LocalStorageService? _storageService;
  HotelListModel _model = const HotelListModel();

  HotelListModel get model => _model;

  void _updateModel(HotelListModel newModel) {
    _model = newModel;
    notifyListeners();
  }

  Future<void> initializeStorage() async {
    _storageService ??= await LocalStorageService.getInstance();
  }

  void updateSearchQuery(String query) {
    _updateModel(_model.copyWith(searchQuery: query));
  }

  Future<void> loadPopularHotels() async {
    try {
      _updateModel(_model.copyWith(isLoading: true, errorMessage: null));

      final hotels = await HotelApiService.getPopularHotels(limit: 20);
      
      _updateModel(_model.copyWith(
        isLoading: false,
        hotels: hotels,
        isShowingSearchResults: false,
      ));
    } catch (e) {
      _updateModel(_model.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load hotels: $e',
      ));
    }
  }

  Future<void> searchHotels(BuildContext context) async {
    try {
      if (_model.searchQuery.trim().isEmpty) {
        _updateModel(_model.copyWith(
          errorMessage: 'Please enter a search query',
        ));
        return;
      }

      _updateModel(_model.copyWith(isLoading: true, errorMessage: null));

      final response = await HotelApiService.searchHotelsByQuery(_model.searchQuery.trim());
      
      _updateModel(_model.copyWith(
        isLoading: false,
        hotels: response.hotels,
        isShowingSearchResults: true,
        searchResponse: response,
      ));

      // Navigate to search results page
      NavigationUtils.goToSearchResults(context, _model.searchQuery);
    } catch (e) {
      _updateModel(_model.copyWith(
        isLoading: false,
        errorMessage: 'Search failed: $e',
      ));
    }
  }

  Future<void> loadHotelsByCity(String city) async {
    try {
      _updateModel(_model.copyWith(isLoading: true, errorMessage: null));

      final hotels = await HotelApiService.getHotelsByCity(city, limit: 20);
      
      _updateModel(_model.copyWith(
        isLoading: false,
        hotels: hotels,
        isShowingSearchResults: false,
      ));
    } catch (e) {
      _updateModel(_model.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load hotels: $e',
      ));
    }
  }

  Future<void> logout(BuildContext context) async {
    await initializeStorage();
    await _storageService!.clearUserSession();
    NavigationUtils.goToLogin(context);
  }

  void clearError() {
    _updateModel(_model.copyWith(errorMessage: null));
  }
}
