import 'package:plateau/resources/places/places_page.dart';

import '../resources/places/add_place_page.dart';
import '../resources/profile/choose_login_page.dart';
import '../resources/profile/link_login_page.dart';
import '../resources/profile/signup_page.dart';
import '/resources/pages/base_navigation_hub.dart';
import '../resources/profile/email_login_page.dart';
import '/resources/pages/not_found_page.dart';
import '/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* App Router
|--------------------------------------------------------------------------
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "dart run nylo_framework:main make:page profile_page"
|
| * [Tip] Add authentication 🔑
| Run the below in the terminal to add authentication to your project.
| "dart run scaffold_ui:main auth"
|
| * [Tip] Add In-app Purchases 💳
| Run the below in the terminal to add In-app Purchases to your project.
| "dart run scaffold_ui:main iap"
|
| Learn more https://nylo.dev/docs/6.x/router
|-------------------------------------------------------------------------- */

appRouter() => nyRoutes((router) {
      const noTransition = PageTransitionSettings(
          duration: Duration(milliseconds: 0),
          reverseDuration: Duration(milliseconds: 0));
      router.add(HomePage.path);
      // Add your routes here ...

      // router.add(NewPage.path, transition: PageTransitionType.fade);

      // Example using grouped routes
      // router.group(() => {
      //   "route_guards": [AuthRouteGuard()],
      //   "prefix": "/dashboard"
      // }, (router) {
      //
      // });
      router
          .add(NotFoundPage.path, pageTransitionSettings: noTransition)
          .unknownRoute();
      router
          .add(BaseNavigationHub.path, pageTransitionSettings: noTransition)
          .authenticatedRoute();
      // profiles
      router
          .add(ChooseLoginPage.path, pageTransitionSettings: noTransition)
          .initialRoute();
      router.add(SignupPage.path, pageTransitionSettings: noTransition);
      router.add(EmailLoginPage.path, pageTransitionSettings: noTransition);
      router.add(LinkLoginPage.path, pageTransitionSettings: noTransition);
      // places
      router.add(PlacesPage.path, pageTransitionSettings: noTransition);
      router.add(AddPlacePage.path, transition: PageTransitionType.bottomToTop);
      // nearme
    });
