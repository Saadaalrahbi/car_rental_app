import 'package:auto_access/features/personalization/screens/settings/settings.dart';
import 'package:auto_access/features/rent/screens/car_review/car_reviews.dart';
import 'package:auto_access/features/rent/screens/home/home.dart';
import 'package:auto_access/features/rent/screens/rent_now/rent_now.dart';
import 'package:auto_access/features/rent/screens/rental/rental.dart';
import 'package:auto_access/features/rent/screens/store/shop.dart';
import 'package:auto_access/routes/routes.dart';
import 'package:get/get.dart';
import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/onboarding/onboarding.dart';
import '../features/authentication/screens/password_configuration/forget_password.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/signup/widgets/verify_email.dart';
import '../features/personalization/screens/address/address.dart';
import '../features/personalization/screens/profile/profile_screen.dart';
import '../features/rent/screens/search/search.dart';

class AppRoutes{
  static final pages = [
    GetPage(name: Routes.home, page: () => const HomeScreen()),
    GetPage(name: Routes.store, page: () => const StoreScreen()),
    GetPage(name: Routes.settings, page: () => const SettingsScreen()),
    GetPage(name: Routes.search, page: () => SearchScreen()),
    GetPage(name: Routes.carReviews, page: () => const CarReviewScreen()),
    GetPage(name: Routes.rental, page: () => const RentalScreen()),
    GetPage(name: Routes.rentNow, page: () => const RentNowScreen()),
    GetPage(name: Routes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: Routes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: Routes.signup, page: () => const SignupScreen()),
    GetPage(name: Routes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: Routes.signIn, page: () => const LoginScreen()),
    GetPage(name: Routes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: Routes.onBoarding, page: () => const OnBoardingScreen()),

  ];
}