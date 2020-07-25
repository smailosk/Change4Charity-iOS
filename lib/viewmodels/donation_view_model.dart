import 'dart:async';
import 'package:change4charity/locator.dart';
import 'package:change4charity/models/user.dart';
import 'package:change4charity/viewmodels/base_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryService _repositoryService = locator<RepositoryService>();

  User _user;
  User get user => _user;
  StreamSubscription<User> streamSubscription;
  double totalDonationAmount;
  init() {
    _user = _repositoryService.currentUser;
    calculateTotal();

    streamSubscription = _repositoryService.userStream.listen((event) {
      _user = event;
      calculateTotal();
      notifyListeners();
    });
  }

  donate() async {
    if (totalDonationAmount == 0) return;
    String url = 'https://paypal.me/TogetherForUganda/$totalDonationAmount';
    Donation donation =
        Donation(amount: totalDonationAmount, dateTime: DateTime.now());

    List<Donation> donations = new List<Donation>();
    if (_user.donations != null) donations = _user.donations;

    donations.add(donation);
    donations.sort((a, b) => -a.dateTime.compareTo(b.dateTime));
    print(url);
    List<BadHabitRecord> badHabitsRecord = new List<BadHabitRecord>();
    if (await canLaunch(url)) {
      await launch(url);
      _user.badHabitRecords
          .where((element) => element.cleared == false)
          .forEach((element) {
        badHabitsRecord.add(element.copyWith(cleared: true));
      });
      var newUser = _user.copyWith(
          badHabitRecords: badHabitsRecord, donations: donations);
      _repositoryService.saveUser(newUser);
    } else {
      throw 'Could not launch $url';
    }
  }

  double calculateTotal() {
    double sum = 0;
    if (_user.badHabitRecords == null) {
      totalDonationAmount = sum;
      return sum;
    } else {
      _user.badHabitRecords
          .where((element) => element.cleared == false)
          .forEach((element) {
        var habit = _user.habits
            .where((habit) => habit.name == element.habitName)
            .first;
        sum += habit.amount * element.totalTimes;
      });
      totalDonationAmount = sum;
      return sum;
    }
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }
}
