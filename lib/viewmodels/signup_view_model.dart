import 'dart:io';

import 'package:change4charity/constants/route_names.dart';
import 'package:change4charity/locator.dart';
import 'package:change4charity/models/user.dart';
import 'package:change4charity/viewmodels/base_model.dart';

class SignUpViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryService _repositoryService = locator<RepositoryService>();

  List<Habit> _habits = new List<Habit>();
  List<Habit> get habits => _habits.toList();
  File profilePicture;

  addHabit(String name, double amount) {
    if (amount <= 0) return;
    var firstLetter = name[0];
    var camelCaseValue = firstLetter.toUpperCase() + name.substring(1);
    if (!_habits.contains(camelCaseValue)) {
      _habits.add(Habit(name: camelCaseValue, amount: amount));
    }
    notifyListeners();
  }

  removeHabit(String value) {
    print(value);
    if (_habits.contains(value)) {
      _habits.remove(value);
    }
    notifyListeners();
  }

  selectProfilePicture() async {
    var image = await _repositoryService.selectImage();
    profilePicture = image;
    notifyListeners();
  }

  // Ajouter un User
  submit(String name) async {
    setBusy(true);
    // ignore: missing_required_param
    var user = User(
        habits: _habits,
        fullName: name,
        profileImagePath: profilePicture == null ? '' : profilePicture.path);
    await _repositoryService.saveUser(user);
    setBusy(false);
    _navigationService.popAllAndNavigateTo(HomeViewRoute);
  }
}
