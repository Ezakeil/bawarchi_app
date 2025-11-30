import 'package:go_router/go_router.dart';
import '../navigation/main_wrapper.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/onboarding/presentation/screens/preferences_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/recipes/presentation/screens/recipes_screen.dart';
import '../../features/scan/presentation/screens/scan_screen.dart';
import '../../features/pantry/presentation/screens/pantry_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/scanner/presentation/screens/scanner_screen.dart';
import '../../features/scanner/presentation/screens/scanner_confirm_screen.dart';
import '../../features/scanner/presentation/screens/confirm_items_screen.dart';
import '../../features/recipes/presentation/screens/recipe_detail_screen.dart';
import '../../features/reinventor/presentation/screens/reinventor_screen.dart';
import '../../features/nutrition/presentation/screens/healthy_swaps_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/settings/presentation/screens/household_screen.dart';
import '../../features/settings/presentation/screens/allergy_shield_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    // Auth Routes (before login)
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/preferences',
      builder: (context, state) => const PreferencesScreen(),
    ),

    // Scanner Routes (full screen, outside shell)
    GoRoute(
      path: '/scanner',
      builder: (context, state) => const ScannerScreen(),
    ),
    GoRoute(
      path: '/scanner/confirm',
      builder: (context, state) => const ScannerConfirmScreen(),
    ),
    GoRoute(
      path: '/scanner/review',
      builder: (context, state) => const ConfirmItemsScreen(),
    ),

    // Main App Shell with Bottom Navigation
    ShellRoute(
      builder: (context, state, child) {
        return MainWrapper(child: child);
      },
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/recipes',
          builder: (context, state) => const RecipesScreen(),
          routes: [
            GoRoute(
              path: 'detail/:title',
              builder: (context, state) {
                final recipeTitle = state.pathParameters['title'] ?? 'Recipe';
                final matchPercentage =
                    int.tryParse(state.uri.queryParameters['match'] ?? '0') ??
                    0;
                return RecipeDetailScreen(
                  recipeTitle: recipeTitle,
                  matchPercentage: matchPercentage,
                );
              },
            ),
          ],
        ),
        GoRoute(path: '/scan', builder: (context, state) => const ScanScreen()),
        GoRoute(
          path: '/pantry',
          builder: (context, state) => const PantryScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/reinventor',
          builder: (context, state) => const ReinventorScreen(),
        ),
        GoRoute(
          path: '/healthy-swaps',
          builder: (context, state) => const HealthySwapsScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
          routes: [
            GoRoute(
              path: 'household',
              builder: (context, state) => const HouseholdScreen(),
            ),
            GoRoute(
              path: 'allergy-shield',
              builder: (context, state) => const AllergyShieldScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
