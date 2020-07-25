import 'package:change4charity/constants/route_names.dart';
import 'package:change4charity/locator.dart';
import 'package:change4charity/viewmodels/base_model.dart';

class StartUpViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryService _repositoryService = locator<RepositoryService>();

  Future handleStartUpLogic() async {
    await Future.delayed(Duration(seconds: 2));
    var userExists = await _repositoryService.userExists();
    //_navigationService.popAllAndNavigateTo(SignUpViewRoute);

    if (userExists) {
      _navigationService.popAllAndNavigateTo(HomeViewRoute);
    } else {
      _navigationService.popAllAndNavigateTo(SignUpViewRoute);
    }
  }
}
