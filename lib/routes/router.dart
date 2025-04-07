import 'package:plateau/resources/chat/chats_page.dart';
import 'package:plateau/resources/chat/view_chat_page.dart';
import 'package:plateau/resources/places/edit_new_place_page.dart';

import '../resources/places/own_place_visits_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

import 'package:plateau/resources/pages/base_navigation_hub.dart';
import 'package:plateau/resources/pages/not_found_page.dart';
import 'package:plateau/resources/places/profile_history_page.dart';
import 'package:plateau/resources/places/profile_places_page.dart';
import 'package:plateau/resources/places/profile_visibility_page.dart';
import 'package:plateau/resources/places/profile_wallet_page.dart';
import 'package:plateau/resources/places/new_place_page.dart';
import 'package:plateau/resources/places/view_new_place_page.dart';
import 'package:plateau/resources/places/places_page.dart';
import 'package:plateau/resources/places/view_own_place_page.dart';
import 'package:plateau/resources/profile/choose_login_page.dart';
import 'package:plateau/resources/profile/email_login_page.dart';
import 'package:plateau/resources/profile/link_login_page.dart';
import 'package:plateau/resources/profile/signup_page.dart';

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
      // profile
      router
          .add(ChooseLoginPage.path, pageTransitionSettings: noTransition)
          .initialRoute();
      router.add(SignupPage.path, pageTransitionSettings: noTransition);
      router.add(EmailLoginPage.path, pageTransitionSettings: noTransition);
      router.add(LinkLoginPage.path, pageTransitionSettings: noTransition);
      router.add(ProfileVisibilityPage.path,
          pageTransitionSettings: noTransition);
      router.add(ProfileWalletPage.path, pageTransitionSettings: noTransition);
      router.add(ProfileHistoryPage.path, pageTransitionSettings: noTransition);
      router.add(ProfilePlacesPage.path, pageTransitionSettings: noTransition);

      // places
      router.add(PlacesPage.path, pageTransitionSettings: noTransition);
      router.add(ViewOwnPlacePage.path, pageTransitionSettings: noTransition);
      router.add(NewPlacePage.path, pageTransitionSettings: noTransition);
      router.add(ViewNewPlacePage.path, pageTransitionSettings: noTransition);
      router.add(EditNewPlacePage.path, pageTransitionSettings: noTransition);

      // nearme
      router.add(OwnPlaceVisitsPage.path);

      // chats
      router.add(ChatsPage.path, pageTransitionSettings: noTransition);
      router.add(ViewChatPage.path, pageTransitionSettings: noTransition);
    });
