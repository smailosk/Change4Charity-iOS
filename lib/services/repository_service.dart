import 'dart:async';
import 'dart:io';

import 'package:change4charity/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class RepositoryService {
  final _storage = FlutterSecureStorage();
  final _picker = ImagePicker();

  User _currentUser = User();
  User get currentUser => _currentUser;

  StreamController<User> _userStream = StreamController<User>.broadcast();
  Stream<User> get userStream => _userStream.stream;
  saveUser(User user) async {
    populateUser(user);
    await _storage.write(key: 'user', value: user.toRawJson());
    var x = await _storage.read(key: 'user');
    print(x);
  }

  Future<User> fetchUser() async {
    var rawJson = await _storage.read(key: 'user');
    var user = User.fromRawJson(rawJson);
    populateUser(user);
    return user;
  }

  Future<bool> userExists() async {
    //await _storage.deleteAll();

    var rawJson = await _storage.read(key: 'user');
    if (rawJson == null)
      return false;
    else {
      await fetchUser();
      return true;
    }
  }

  populateUser(User user) {
    _currentUser = user;
    _userStream.sink.add(user);
  }

  Future<File> selectImage() async {
    var image = await _picker.getImage(source: ImageSource.gallery);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final String ext = image.path.substring(image.path.lastIndexOf('.'));
    final String path = appDocDir.path + '/profilePic$ext';

    var newImage = await image.readAsBytes();
    var file = await File(path).writeAsBytes(newImage);
    saveUser(_currentUser.copyWith(profileImagePath: file.path));
    return file;
  }
}
