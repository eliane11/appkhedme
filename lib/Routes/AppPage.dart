import 'package:get/get.dart';
import 'package:khedme/Bindings/LoginBinding.dart';
import 'package:khedme/Bindings/RegisterBinding.dart';
import 'package:khedme/Bindings/HomeBinding.dart';
// import 'package:khedme/Bindings/SearchBinding.dart';
import 'package:khedme/Bindings/ProfileBinding.dart';
import 'package:khedme/Bindings/PaymentBinding.dart';
import 'package:khedme/Views/AboutUsPage.dart';
import 'package:khedme/Views/Login.dart';
import 'package:khedme/Views/Register.dart';
import 'package:khedme/Views/HomePage/Home.dart';
// import 'package:khedme/Views/SearchPage.dart';
import 'package:khedme/Views/ProfilePage.dart';
import 'package:khedme/Routes/AppRoute.dart';
import 'package:khedme/Views/PaymentPage.dart';
import 'package:khedme/Views/Splash.dart';
import 'package:khedme/Models/Worker.dart';

class AppPage {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoute.payment,
      page: () {
        // Retrieve the worker object passed via arguments
        final KhedmeWorker worker = Get.arguments;
        return PaymentPage(worker: worker);
      },
      binding: PaymentBinding(), // Ensure the PaymentBinding initializes PaymentController
    ),
    GetPage(
      name: AppRoute.splash,
      page: () => const SplashPage(), // Add splash page
    ),
    GetPage(
      name: AppRoute.home,
      page: () => const HomePage(), 
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoute.login,
      page: () => const Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoute.register,
      page: () => const Register(),
      binding: RegisterBinding(),
    ),
    // GetPage(
    //   name: AppRoute.search,
    //   page: () => const SearchPage(),
    //   binding: SearchBinding(),
    // ),
    GetPage(
      name: AppRoute.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoute.aboutUs,
      page: () => const AboutUs(),
    ),
  ];
}
