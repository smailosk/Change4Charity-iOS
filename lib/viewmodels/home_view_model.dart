import 'package:change4charity/constants/route_names.dart';
import 'package:change4charity/locator.dart';
import 'package:change4charity/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryService _repositoryService = locator<RepositoryService>();

  showPopUp() {
    var habits = _repositoryService.currentUser.habits;
    print(habits);
    if (habits.isNotEmpty || habits.length > 0) {
      _navigationService.navigateTo(AddDonationViewRoute);
    }
  }
}
