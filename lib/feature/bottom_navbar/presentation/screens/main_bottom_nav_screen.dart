import '../../../../../../../core/exported_files/exported_file.dart';
import '../../../chat_flow/presentation/screens/chat_list_screen.dart';
import '../../../chat_flow/presentation/controllers/chat_controller.dart';
import '../controllers/bottom_nav_bar_controller.dart';
import '../screens/bottom_nav_bar.dart';

/// Temporary placeholder screens for navigation


class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResponsiveImage(
              path: IconsPath.profile,
              size: 80,
              color: AppColors.mainColor,
            ),
            const SizedBox(height: 20),
            ResponsiveText(
              text: 'Contacts Screen',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            ResponsiveText(
              text: 'Coming Soon',
              fontSize: 14,
              color: AppColors.gray,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResponsiveImage(
              path: IconsPath.profileActive,
              size: 80,
              color: AppColors.mainColor,
            ),
            const SizedBox(height: 20),
            ResponsiveText(
              text: 'Profile Screen',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            ResponsiveText(
              text: 'Coming Soon',
              fontSize: 14,
              color: AppColors.gray,
            ),
          ],
        ),
      ),
    );
  }
}

/// Main Home Screen with Bottom Navigation
class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  late final BottomNavBarController controller;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    controller = Get.find<BottomNavBarController>();
    // Initialize ChatBinding for ChatListScreen
    Get.lazyPut(() => ChatController(), fenix: true);
    screens = const [
      ChatListScreen(),
      ContactsScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => screens[controller.selectedIndex.value],
      ),
      bottomNavigationBar: BottomNavBar(
        onTabChanged: (index) {
          // Handle tab change if needed
          DService().info('Tab changed to: $index');
        },
      ),
    );
  }
}

