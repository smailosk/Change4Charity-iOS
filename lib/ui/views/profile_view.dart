import 'package:change4charity/models/user.dart';
import 'package:change4charity/ui/shared/size_config.dart';
import 'package:change4charity/ui/widgets/busy_overlay.dart';
import 'package:change4charity/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:change4charity/viewmodels/profile_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key key}) : super(key: key);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController _habitController = TextEditingController();
  TextEditingController _nameController = TextEditingController(text: '');
  TextEditingController _amountController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) {
        _nameController.text = model.user.fullName;
        return SingleChildScrollView(
          child: BusyOverlay(
            show: model.busy,
            child: Container(
              //height: double.infinity,
              //width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizeConfig.verticalSpacer(2),
                  InkWell(
                    onTap: model.selectProfilePicture,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent.shade200,
                        child: model.profilePicture != null
                            ? Container()
                            : Image.asset(
                                'assets/camera.png',
                                width: 30,
                                height: 30,
                              ),
                        backgroundImage: model.profilePicture == null
                            ? null
                            : FileImage(
                                model.profilePicture,
                              ),
                        radius: 50,
                      ),
                    ),
                  ),
                  SizeConfig.verticalSpacer(3),
                  Container(
                    width: SizeConfig.screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Name :'),
                        TextField(
                          controller: _nameController,
                        ),
                        SizeConfig.verticalSpacer(5),
                        Text('Your bad habits :'),
                        SizeConfig.verticalSpacer(2),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              height: SizeConfig.relativeHeight(5),
                              width: SizeConfig.relativeWidth(50),
                              child: TextField(
                                controller: _habitController,
                                decoration: new InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    //focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15, bottom: 5, top: 5, right: 15),
                                    hintText: 'Add your bad Habit'),
                              ),
                            ),
                            SizeConfig.horizontalSpacer(2),
                            SizedBox(
                              height: SizeConfig.relativeHeight(5),
                              width: SizeConfig.relativeWidth(25),
                              child: TextField(
                                controller: _amountController,
                                textAlign: TextAlign.center,
                                decoration: new InputDecoration(
                                    suffix: SizedBox(
                                      width: SizeConfig.relativeHeight(3),
                                      height: SizeConfig.relativeHeight(3),
                                      child: Center(
                                        child: Icon(
                                          Icons.euro_symbol,
                                          size: SizeConfig.relativeHeight(2),
                                        ),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    //focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 10, bottom: 5, top: 5, right: 10),
                                    hintStyle: TextStyle(
                                      fontSize: SizeConfig.setSp(12),
                                    ),
                                    hintText: '0.00'),
                              ),
                            ),
                            SizeConfig.horizontalSpacer(2),
                            InkWell(
                                child: Icon(Icons.add_circle),
                                onTap: () {
                                  var doubleValue =
                                      double.tryParse(_amountController.text);
                                  if (_habitController.text != '' &&
                                      doubleValue != null) {
                                    model.addHabit(Habit(
                                        name: _habitController.text,
                                        amount: doubleValue));

                                    _habitController.clear();
                                    _amountController.clear();
                                  }
                                }),
                          ],
                        ),
                        SizeConfig.verticalSpacer(3),
                        if (model.user.habits.length > 0)
                          SizedBox(
                            height: SizeConfig.relativeHeight(10),
                            child: ListView(
                                children: model.user.habits
                                    .map((e) => Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                '- ${e.name}       ${e.amount} €'),
                                            InkWell(
                                              child: Icon(Icons.close),
                                              onTap: () =>
                                                  model.removeHabit(e.name),
                                            )
                                          ],
                                        ))
                                    .toList()),
                          ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(SizeConfig.relativeWidth(7), 0,
                        SizeConfig.relativeWidth(7), 0),
                  ),
                  SizeConfig.verticalSpacer(10),
                  InkWell(
                    onTap: () {
                      model.submit(_nameController.text);
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      height: SizeConfig.relativeHeight(5),
                      width: SizeConfig.relativeWidth(50),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.shade200,
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
