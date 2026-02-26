import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/task/bindings/task_binding.dart';
import '../modules/task/views/task_view.dart';
import '../modules/wallet/bindings/wallet_binding.dart';
import '../modules/wallet/views/wallet_view.dart';
import '../modules/wallet/wallet_detail/bindings/wallet_detail_binding.dart';
import '../modules/wallet/wallet_detail/views/wallet_detail_view.dart';
import '../modules/wallet/wallet_transaction/bindings/wallet_transaction_binding.dart';
import '../modules/wallet/wallet_transaction/views/wallet_transaction_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
      children: [
        GetPage(
          name: _Paths.WALLET_DETAIL,
          page: () => const WalletDetailView(),
          binding: WalletDetailBinding(),
        ),
        GetPage(
          name: _Paths.WALLET_TRANSACTION,
          page: () => const WalletTransactionView(),
          binding: WalletTransactionBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.TASK,
      page: () => const TaskView(),
      binding: TaskBinding(),
    ),
  ];
}
