import 'package:science_platform/src/feature/authentication/root/repository/auth_repository.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:get/get.dart';

class DashboardViewController extends GetxController {
  final AuthenticationRepository _repository = AuthenticationRepository();

  final RxInt _index = 0.obs;

  int get currentIndex => _index.value;

  void updateIndex(int index) => _index.value = index;

  /// Navbar visibility
  final RxBool _navBarVisibility = true.obs;

  bool get navBarVisibility => _navBarVisibility.value;

  void updateNavBarVisibility(bool value) => _navBarVisibility.value = value;

  /// Logout
  void logout() {
    _repository.signOut();
    Get.offAllNamed(Routes.login);
  }
}
