import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/home_view_model.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Travely'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                
                // Welcome Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Profile Picture
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary,
                        backgroundImage: viewModel.userPhoto != null
                            ? NetworkImage(viewModel.userPhoto!)
                            : null,
                        child: viewModel.userPhoto == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.onPrimary,
                              )
                            : null,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // User Name
                      Text(
                        viewModel.userName ?? 'User',
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: AppColors.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // User Email
                      Text(
                        viewModel.userEmail ?? '',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.onPrimaryContainer.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Features Section
                Text(
                  'Quick Actions',
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Feature Cards
                _buildFeatureCard(
                  icon: Icons.explore,
                  title: 'Explore Destinations',
                  subtitle: 'Discover amazing places to visit',
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                
                const SizedBox(height: 12),
                
                _buildFeatureCard(
                  icon: Icons.bookmark,
                  title: 'My Bookmarks',
                  subtitle: 'Your saved destinations',
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                
                const SizedBox(height: 12),
                
                _buildFeatureCard(
                  icon: Icons.calendar_today,
                  title: 'Trip Planner',
                  subtitle: 'Plan your next adventure',
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                
                const SizedBox(height: 32),
                
                // Logout Button
                CommonButton(
                  text: 'Sign Out',
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  isOutlined: true,
                  backgroundColor: AppColors.error,
                  textColor: AppColors.error,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.textSecondary,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<HomeViewModel>().logout(context);
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Coming Soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
