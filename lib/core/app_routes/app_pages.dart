import 'package:message/feature/auth/login/presentation/bindings/login_binding.dart';
import 'package:message/feature/auth/login/presentation/screens/login_screen.dart';
import 'package:message/feature/auth/registration/presentation/bindings/registration_binding.dart';
import 'package:message/feature/auth/registration/presentation/screens/registration_screen.dart';
import 'package:message/feature/bottom_navbar/presentation/screens/main_bottom_nav_screen.dart';
import 'package:message/feature/sp_and_onboarding_flow/onboarding/presentations/bindings/onboarding_binding.dart';
import 'package:message/feature/sp_and_onboarding_flow/onboarding/presentations/screens/onboarding_screen.dart';

import '../../feature/bottom_navbar/presentation/bindings/bottom_nav_bar_binding.dart';
import '../../feature/chat_flow/presentation/bindings/chat_binding.dart';
import '../../feature/chat_flow/presentation/screens/chat_list_screen.dart';
import '../../feature/chat_flow/presentation/screens/chat_screen.dart';
import '../../feature/sp_and_onboarding_flow/splash/presentations/bindings/splash_binding.dart';
import '../../feature/sp_and_onboarding_flow/splash/presentations/screens/splash_screen.dart';
import '../exported_files/exported_file.dart';

class AppPages {
  static List<GetPage<dynamic>> appPages() {
    return [
      _getPages(
        name: AppRoutes.splashScreen,
        page: const SplashScreen(),
        binding: SplashBinding(),
      ),

      _getPages(
        name: AppRoutes.onboardingScreen,
        page: const OnboardingScreen(),
        binding: OnboardingBinding(),
      ),

      _getPages(
        name: AppRoutes.loginScreen,
        page: const LoginScreen(),
        binding: LoginBinding(),
      ),

      _getPages(
        name: AppRoutes.registrationScreen,
        page: const RegistrationScreen(),
        binding: RegistrationBinding(),
      ),

      _getPages(
        name: AppRoutes.mainBottomNavScreen,
        page: const MainBottomNavScreen(),
        binding: BottomNavBarBinding(),
      ),
      _getPages(
        name: AppRoutes.chatListScreen,
        page: const ChatListScreen(),
        binding: ChatBinding(),
      ),

      // _getPages(
      //   name: AppRoutes.chatScreen,
      //   page: const ChatScreen(chat: null,),
      //   binding: ChatBinding(),
      // ),

    ];
  }

  static GetPage<dynamic> _getPages({
    required String name,
    required Widget page,
    Bindings? binding,
  }) => GetPage(name: name, page: () => page, binding: binding);
}




