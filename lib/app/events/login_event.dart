import 'package:hyperplace/resources/pages/base_navigation_hub.dart';
import 'package:nylo_framework/nylo_framework.dart';

class LoginEvent implements NyEvent {
  @override
  final listeners = {
    DefaultListener: DefaultListener(),
  };
}

class DefaultListener extends NyListener {
  @override
  handle(dynamic event) async {
    // Handle the event
    await Auth.authenticate(data: event);
    routeTo(BaseNavigationHub.path);
  }
}
