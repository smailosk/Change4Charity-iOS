import 'package:change4charity/ui/shared/size_config.dart';
import 'package:change4charity/viewmodels/donation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider_architecture/provider_architecture.dart';

class DonationView extends StatelessWidget {
  const DonationView({Key key}) : super(key: key);
  static final nubmerFormat = NumberFormat("#,###.##", "en_US");
  static final dateFormatter = new DateFormat('yyyy-MM-dd');
  static final timeFormatter = new DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DonationViewModel>.withConsumer(
        onModelReady: (model) => model.init(),
        viewModelBuilder: () => DonationViewModel(),
        builder: (context, model, child) {
          return Container(
            padding: EdgeInsets.only(
                left: SizeConfig.relativeWidth(1),
                right: SizeConfig.relativeWidth(1),
                top: SizeConfig.relativeHeight(1),
                bottom: SizeConfig.relativeHeight(5)),
            child: Column(
              children: <Widget>[
                Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.relativeHeight(6),
                    padding: EdgeInsets.only(left: SizeConfig.relativeWidth(5)),
                    child: Align(
                      child: Text('Current Amount'),
                      alignment: Alignment.centerLeft,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5))),
                SizeConfig.verticalSpacer(5),
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.relativeWidth(5),
                      right: SizeConfig.relativeWidth(5),
                      top: SizeConfig.relativeHeight(1),
                      bottom: SizeConfig.relativeHeight(1)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${nubmerFormat.format(model.totalDonationAmount)} \$',
                        style: TextStyle(fontSize: SizeConfig.setSp(20)),
                      ),
                      InkWell(
                        onTap: model.donate,
                        child: Container(
                            child: Center(
                              child: Text(
                                'Donate',
                                style:
                                    TextStyle(fontSize: SizeConfig.setSp(18)),
                              ),
                            ),
                            width: SizeConfig.relativeWidth(40),
                            height: SizeConfig.relativeHeight(6),
                            decoration: new BoxDecoration(
                                color: model.totalDonationAmount > 0
                                    ? Colors.yellow.shade400
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(23))),
                      )
                    ],
                  ),
                ),
                SizeConfig.verticalSpacer(5),
                Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.relativeHeight(6),
                    padding: EdgeInsets.only(left: SizeConfig.relativeWidth(5)),
                    child: Align(
                      child: Text('History'),
                      alignment: Alignment.centerLeft,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5))),
                Expanded(
                  child: Container(
                      child: model.user.donations != null
                          ? ListView.builder(
                              itemCount: model.user.donations.length,
                              itemBuilder: (context, index) {
                                var donation = model.user.donations[index];
                                return Column(
                                  children: <Widget>[
                                    SizeConfig.verticalSpacer(2),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(dateFormatter
                                                  .format(donation.dateTime)),
                                              Text(timeFormatter
                                                  .format(donation.dateTime))
                                            ],
                                          ),
                                          VerticalDivider(
                                            color: Colors.grey,
                                            thickness: 1,
                                            width: SizeConfig.relativeWidth(10),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                  '${nubmerFormat.format(donation.amount)} \$'),
                                              SizeConfig.verticalSpacer(1),
                                              Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                      width: SizeConfig
                                                          .relativeHeight(3),
                                                      height: SizeConfig
                                                          .relativeHeight(3),
                                                      child: Image.asset(
                                                          'assets/paypal.png')),
                                                  SizeConfig.horizontalSpacer(
                                                      2),
                                                  Text(
                                                      'Donation sent via Paypal')
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizeConfig.verticalSpacer(2),
                                  ],
                                );
                              })
                          : Container(),
                      padding: EdgeInsets.only(
                          left: SizeConfig.relativeWidth(5),
                          right: SizeConfig.relativeWidth(5),
                          top: SizeConfig.relativeHeight(1),
                          bottom: SizeConfig.relativeHeight(1))),
                )
              ],
            ),
          );
        });
  }
}
