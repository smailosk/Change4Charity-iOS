import 'package:change4charity/ui/shared/size_config.dart';
import 'package:change4charity/ui/widgets/busy_overlay.dart';
import 'package:change4charity/viewmodels/base_model.dart';
import 'package:change4charity/viewmodels/signup_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key key}) : super(key: key);
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController _habitController = TextEditingController();
  TextEditingController _nameController = TextEditingController(text: '');
  TextEditingController _amountController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => BusyOverlay(
        show: model.busy,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: SizeConfig.relativeHeight(100),
              width: SizeConfig.relativeWidth(100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizeConfig.verticalSpacer(10),
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
                  SizeConfig.verticalSpacer(10),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizeConfig.horizontalSpacer(100),
                        Text('Name :'),
                        TextField(
                          controller: _nameController,
                        ),
                        SizeConfig.verticalSpacer(10),
                        Text('Your bad habits :'),
                        SizeConfig.verticalSpacer(5),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              height: SizeConfig.relativeHeight(5),
                              width: SizeConfig.relativeWidth(40),
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: _habitController,
                                decoration: new InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    //focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15, bottom: 5, top: 5, right: 15),
                                    hintStyle: TextStyle(
                                      fontSize: SizeConfig.setSp(12),
                                    ),
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
                                  model.addHabit(
                                      _habitController.text, doubleValue);

                                  _habitController.clear();
                                  _amountController.clear();
                                } else {}
                              },
                            ),
                          ],
                        ),
                        if (model.habits.length > 0)
                          SizedBox(
                            height: SizeConfig.relativeHeight(10),
                            child: ListView(
                                children: model.habits
                                    .map((e) => Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                '- ${e.name}       ${e.amount} €'),
                                            InkWell(
                                                onTap: () =>
                                                    model.removeHabit(e.name),
                                                child: Icon(Icons.close))
                                          ],
                                        ))
                                    .toList()),
                          ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(SizeConfig.relativeWidth(10),
                        0, SizeConfig.relativeWidth(10), 0),
                  ),
                  SizeConfig.verticalSpacer(10),
                  InkWell(
                    onTap: () {
                      model.submit(_nameController.text);
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          'Continue',
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
        ),
      ),
    );
  }

  Widget _textField(String hint, TextEditingController controller,
      {bool readOnly = false, Function onTap, IconData suffix}) {
    return Container(
      width: SizeConfig.relativeWidth(85),
      height: SizeConfig.relativeHeight(4),
      child: CupertinoTextField(
        controller: controller,
        padding: EdgeInsets.only(left: 8),
        suffix: Icon(suffix),
        readOnly: readOnly,
        onTap: onTap,
        enableInteractiveSelection: true,
        style: TextStyle(
          fontSize: SizeConfig.setSp(12),
        ),
        maxLines: 1,
        placeholder: hint,
        placeholderStyle: TextStyle(
          fontSize: SizeConfig.setSp(12),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Colors.black, width: 1.0, style: BorderStyle.solid)),
      ),
    );
  }
}
