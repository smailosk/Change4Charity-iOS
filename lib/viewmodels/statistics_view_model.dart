import 'dart:async';

import 'package:change4charity/locator.dart';
import 'package:change4charity/models/statistics_model.dart';
import 'package:change4charity/models/user.dart';
import 'package:change4charity/viewmodels/base_model.dart';

class StatisticsViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryService _repositoryService = locator<RepositoryService>();

  User _user;
  User get user => _user;
  StreamSubscription<User> streamSubscription;
  List<StatisticsModel> statList = List<StatisticsModel>();

  init() {
    _user = _repositoryService.currentUser;

    streamSubscription = _repositoryService.userStream.listen((event) {
      _user = event;
      notifyListeners();
    });
    // _user.badHabitRecords.sort((a, b) => -a.dateTime.compareTo(b.dateTime));
  }

  List<StatisticsModel> getDataPoints(String habitName) {
    List<StatisticsModel> statsList = List<StatisticsModel>();
    List<BadHabitRecord> habitRecords = List<BadHabitRecord>();
    habitRecords = _user.badHabitRecords
        .where((element) => element.habitName == habitName)
        .toList();

    List<DateTime> dates = List<DateTime>();
    dates.clear();
    habitRecords.forEach((element) {
      if (!dates.contains(element.dateTime)) {
        dates.add(element.dateTime);
      }
    });

    dates.forEach((element) {
      var events = habitRecords.where((record) => record.dateTime == element);
      int totalTimes = 0;
      events.forEach((event) {
        totalTimes += event.totalTimes;
      });
      statsList
          .add(StatisticsModel(dateTime: element, totalAmount: totalTimes));
    });
    statsList.forEach((element) {
      print('habit : $habitName => ${element.totalAmount}');
    });
    return statsList;
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }
}
