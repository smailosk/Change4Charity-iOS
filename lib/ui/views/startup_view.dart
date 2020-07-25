import 'package:change4charity/ui/shared/size_config.dart';
import 'package:change4charity/viewmodels/startup_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ViewModelProvider<StartUpViewModel>.withConsumer(
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset('assets/logo.png'),
              ),
              CupertinoActivityIndicator(
                radius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
