import 'package:change4charity/models/user.dart';
import 'package:change4charity/ui/shared/size_config.dart';
import 'package:change4charity/viewmodels/add_donation_view_model.dart';
import 'package:change4charity/viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class AddDonationView extends StatelessWidget {
  const AddDonationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AddDonationViewModel>.withConsumer(
        viewModelBuilder: () => AddDonationViewModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: SizeConfig.relativeWidth(5),
                        right: SizeConfig.relativeWidth(5),
                        child: InkWell(
                          onTap: model.cancel,
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: SizeConfig.relativeWidth(5),
                          ),
                        )),
                    Container(
                      height: SizeConfig.screenHeight,
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.relativeWidth(10),
                          SizeConfig.relativeHeight(10),
                          SizeConfig.relativeWidth(10),
                          SizeConfig.relativeHeight(10)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: SizeConfig.relativeWidth(20),
                            height: SizeConfig.relativeWidth(20),
                            child: Hero(
                              tag: 'sadFace',
                              child: Image.asset('assets/sad_face.png'),
                            ),
                          ),
                          SizeConfig.verticalSpacer(10),
                          Text('Select bad Habit :'),
                          DropdownButton<Habit>(
                              value: model.selectedValue,
                              items: model.habits
                                  .map((e) => DropdownMenuItem<Habit>(
                                        child: Text(e.name),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (Habit value) {
                                model.onSelectedNewValue(value);
                              }),
                          SizeConfig.verticalSpacer(5),
                          Text('How many times :'),
                          DropdownButton<int>(
                              value: model.totalTimes,
                              items: List.generate(20, (index) => index + 1)
                                  .map((e) => DropdownMenuItem<int>(
                                        child: Text(e.toString()),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (int value) {
                                model.onTotalTimesChanged(value);
                              }),
                          SizeConfig.verticalSpacer(5),
                          /*
                          Text('Donation Amount :'),
                          TextField(
                            onSubmitted: (value) {
                              model.submit();
                            },
                            expands: false,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              var doubleValue = double.parse(value);
                              model.onAmountChanged(doubleValue);
                            },
                          ),*/
                          SizeConfig.verticalSpacer(10),
                          InkWell(
                            onTap: () {
                              model.submit();
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  'Submit',
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
                          SizeConfig.verticalSpacer(3),
                          InkWell(
                            onTap: () {
                              model.cancel();
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              height: SizeConfig.relativeHeight(5),
                              width: SizeConfig.relativeWidth(50),
                              decoration: BoxDecoration(
                                color: Colors.red.shade400,
                                borderRadius: BorderRadius.circular(23),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
