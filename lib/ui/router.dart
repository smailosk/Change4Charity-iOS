import 'package:change4charity/constants/route_names.dart';
import 'package:change4charity/ui/views/add_donation_view.dart';
import 'package:change4charity/ui/views/home_view.dart';
import 'package:change4charity/ui/views/signup_view.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case SignUpViewRoute:
      return _getPageRoute(
          routeName: settings.name, viewToShow: SignUpView(), args: args);

    case HomeViewRoute:
      return _getPageRoute(
          routeName: settings.name, viewToShow: HomeView(), args: args);

    case AddDonationViewRoute:
      return _getPageRoute(
          routeName: settings.name, viewToShow: AddDonationView(), args: args);

    default:
      return CupertinoPageRoute(
          builder: (_) => Container(
                child: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow, dynamic args}) {
  return CupertinoPageRoute(
      settings: RouteSettings(
        arguments: args,
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
