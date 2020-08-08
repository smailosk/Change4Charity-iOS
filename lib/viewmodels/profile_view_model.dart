import 'dart:async';
import 'dart:io';

import 'package:change4charity/locator.dart';
import 'package:change4charity/models/user.dart';
import 'package:change4charity/viewmodels/base_model.dart';

class ProfileViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryService _repositoryService = locator<RepositoryService>();

  User _user;
  User get user => _user;
  StreamSubscription<User> streamSubscription;
  File profilePicture;

  init() {
    _user = _repositoryService.currentUser;
    if (_user.profileImagePath != '') {
      profilePicture = File(_user.profileImagePath);
    }
    streamSubscription = _repositoryService.userStream.listen((event) {
      _user = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  selectProfilePicture() async {
    var image = await _repositoryService.selectImage();
    profilePicture = image;
    notifyListeners();
  }

  removeHabit(String habitName) {
    print(habitName);
    _user.habits.forEach((habit) {
      if (habit.name == habitName) {
        _user.habits.remove(habit);
        notifyListeners();
      }
    });
  }

  addHabit(Habit habitName) {
    if (habitName.amount <= 0) return;
    var habit = _user.habits.where((habit) => habit.name == habitName.name);
    if (habit != null) {
      _user.habits.add(habitName);
    }
    notifyListeners();
  }

  submit(String name) async {
    setBusy(true);

    await _repositoryService.saveUser(user.copyWith(fullName: name));
    //await Future.delayed(Duration(seconds: 2));
    setBusy(false);
  }
}
