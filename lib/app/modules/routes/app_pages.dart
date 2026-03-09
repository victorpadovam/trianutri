import 'package:get/get.dart';
import 'package:trianutri_app/app/modules/account/account_binding.dart';
import 'package:trianutri_app/app/modules/account/account_page.dart';
import 'package:trianutri_app/app/modules/copy/copy_binding.dart';
import 'package:trianutri_app/app/modules/copy/copy_page.dart';
import 'package:trianutri_app/app/modules/forget/forget_binding.dart';
import 'package:trianutri_app/app/modules/forget/forget_page.dart';
import 'package:trianutri_app/app/modules/history/history_binding.dart';
import 'package:trianutri_app/app/modules/history/history_page.dart';
import 'package:trianutri_app/app/modules/home/home_binding.dart';
import 'package:trianutri_app/app/modules/home/home_page.dart';
import 'package:trianutri_app/app/modules/imc/imc_binding.dart';
import 'package:trianutri_app/app/modules/imc/imc_page.dart';
import 'package:trianutri_app/app/modules/login/login_binding.dart';
import 'package:trianutri_app/app/modules/login/login_page.dart';
import 'package:trianutri_app/app/modules/register/register_binding.dart';
import 'package:trianutri_app/app/modules/register/register_page.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/modules/screening/screening_binding.dart';
import 'package:trianutri_app/app/modules/screening/screening_page.dart';
import 'package:trianutri_app/app/modules/screening_result/screening_result_binding.dart';
import 'package:trianutri_app/app/modules/screening_result/screening_result_page.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: Routes.FORGET,
        page: () => ForgetPage(),
        binding: ForgetBinding()),
    GetPage(
        name: Routes.REGISTER,
        page: () => RegisterPage(),
        binding: RegisterBinding()),
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: Routes.SCREENING,
        page: () => ScreeningPage(),
        binding: ScreeningBinding()),
    GetPage(
        name: Routes.SCREENINGS,
        page: () => HistoryPage(),
        binding: HistoryBinding()),
    GetPage(
        name: Routes.SCREENING_RESULT,
        page: () => ScreeningResultPage(),
        binding: ScreeningResultBinding()),
    GetPage(name: Routes.IMC, page: () => ImcPage(), binding: ImcBinding()),
    GetPage(
      name: Routes.ACCOUNT,
      page: () => AccountPage(),
      binding: AccountBinding(),
    ),
    GetPage(name: Routes.COPY, page: () => CopyPage(), binding: CopyBinding()),
  ];
}
