import 'package:change4charity/locator.dart';
import 'package:change4charity/models/user.dart';

import 'package:change4charity/viewmodels/base_model.dart';

class AddDonationViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryService _repositoryService = locator<RepositoryService>();

  Habit selectedValue;
  double donationAmount = 0;
  List<Habit> habits;
  int totalTimes;
  init() {
    setBusy(true);
    habits = _repositoryService.currentUser.habits;
    selectedValue = habits[0];
    totalTimes = 1;
    print(habits);

    setBusy(false);
  }

  onTotalTimesChanged(int value) {
    totalTimes = value;
    notifyListeners();
  }

  onSelectedNewValue(Habit value) {
    selectedValue = value;
    notifyListeners();
  }

  onAmountChanged(double amount) {
    donationAmount = amount;
    notifyListeners();
  }

  cancel() {
    _navigationService.pop();
  }

  submit() async {
    var user = _repositoryService.currentUser;
    var badHabits = List<BadHabitRecord>();
    if (user.badHabitRecords != null) {
      badHabits.addAll(user.badHabitRecords);
    }

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);

    badHabits.add(BadHabitRecord(
        dateTime: date,
        cleared: false,
        habitName: selectedValue.name,
        totalTimes: totalTimes));
    var newUser = user.copyWith(badHabitRecords: badHabits);
    await _repositoryService.saveUser(newUser);
    _navigationService.pop();
  }
}
