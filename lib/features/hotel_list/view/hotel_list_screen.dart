import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/hotel_list_view_model.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/common_text_field.dart';
import '../../../core/navigation/navigation_utils.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/models/hotel.dart';

class HotelListScreen extends StatefulWidget {
  const HotelListScreen({super.key});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HotelListViewModel>(context, listen: false).loadPopularHotels();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Travely'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                if (mounted) {
                  Provider.of<HotelListViewModel>(context, listen: false).logout(context);
                }
              }
            },
          ),
        ],
      ),
      body: Consumer<HotelListViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              // Search Section
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find Your Perfect Stay',
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Search hotels by name, city, state, or country',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Search Bar
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            label: 'Search hotels...',
                            hint: 'Enter hotel name, city, state, or country',
                            controller: _searchController,
                            suffixIcon: Icon(
                              Icons.search,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        CommonButton(
                          text: 'Search',
                          onPressed: viewModel.model.isLoading ? null : () {
                            if (_searchController.text.trim().isNotEmpty) {
                              viewModel.searchHotels(context);
                            }
                          },
                          isLoading: viewModel.model.isLoading,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Content Section
              Expanded(
                child: viewModel.model.isLoading && viewModel.model.hotels.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : viewModel.model.hotels.isEmpty
                        ? _buildEmptyState()
                        : _buildHotelList(viewModel.model.hotels),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hotel,
            size: 80,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'No hotels found',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching for hotels in different cities',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHotelList(List<Hotel> hotels) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: hotels.length,
      itemBuilder: (context, index) {
        final hotel = hotels[index];
        return _buildHotelCard(hotel);
      },
    );
  }

  Widget _buildHotelCard(Hotel hotel) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to hotel details or search results
          NavigationUtils.goToSearchResults(context, hotel.propertyName);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hotel Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: hotel.propertyImage.isNotEmpty
                    ? Image.network(
                        hotel.propertyImage,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: AppColors.surface,
                            child: Icon(
                              Icons.hotel,
                              size: 60,
                              color: AppColors.textSecondary,
                            ),
                          );
                        },
                      )
                    : Container(
                        height: 200,
                        width: double.infinity,
                        color: AppColors.surface,
                        child: Icon(
                          Icons.hotel,
                          size: 60,
                          color: AppColors.textSecondary,
                        ),
                      ),
              ),
              
              const SizedBox(height: 12),
              
              // Hotel Name
              Text(
                hotel.propertyName,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 4),
              
              // Location
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${hotel.city}, ${hotel.state}, ${hotel.country}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Rating and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Rating
                  if (hotel.reviewPresent && hotel.overallRating != null)
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          hotel.overallRating!.toStringAsFixed(1),
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${hotel.totalUserRating ?? 0} reviews)',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  
                  // Price
                  Text(
                    hotel.staticPriceDisplay,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Amenities
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  if (hotel.freeWifi)
                    _buildAmenityChip('Free WiFi'),
                  if (hotel.freeCancellation)
                    _buildAmenityChip('Free Cancellation'),
                  if (hotel.coupleFriendly)
                    _buildAmenityChip('Couple Friendly'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmenityChip(String amenity) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        amenity,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
