import '../../../../../../../core/exported_files/exported_file.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavItem {
  final String activeIcon;
  final String inactiveIcon;
  final String label;

  BottomNavItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}

class BottomNavBar extends StatelessWidget {
  final Function(int) onTabChanged;

  const BottomNavBar({
    super.key,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavBarController>();

    final items = [
      BottomNavItem(
        activeIcon: IconsPath.message,
        inactiveIcon: IconsPath.message,
        label: 'Chats',
      ),
      BottomNavItem(
        activeIcon: IconsPath.profile,
        inactiveIcon: IconsPath.profile,
        label: 'Contacts',
      ),
      BottomNavItem(
        activeIcon: IconsPath.profileActive,
        inactiveIcon: IconsPath.profile,
        label: 'Profile',
      ),
    ];

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: AppColors.gray,
          currentIndex: controller.selectedIndex.value,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          onTap: (index) {
            controller.onTabChanged(index);
            onTabChanged(index);
          },
          items: List.generate(
            items.length,
            (index) => BottomNavigationBarItem(
              icon: ResponsiveImage(
                path: items[index].inactiveIcon,
                size: 24,
                color: AppColors.gray,
              ),
              activeIcon: ResponsiveImage(
                path: items[index].activeIcon,
                size: 24,
                color: AppColors.mainColor,
              ),
              label: items[index].label,
            ),
          ),
        ),
      ),
    );
  }
}

