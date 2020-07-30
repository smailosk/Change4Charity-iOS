import 'package:change4charity/ui/views/donation_view.dart';
import 'package:change4charity/ui/views/statistics_view.dart';
import 'package:change4charity/viewmodels/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'profile_view.dart';
import 'package:share/share.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex;
  PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  navigateTo() {
    setState(() {
      _controller.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              drawer: Drawer(
                child: Container(
                  color: Colors.grey,
                  child: ListView(
                    children: <Widget>[
                      DrawerHeader(
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/logo.png"),
                            backgroundColor: Colors.red,
                            radius: 60,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Share"),
                        trailing: Icon(Icons.share),
                        onTap: () {
                          Share.share(
                              'Charity4Change http://www.miteinanderfueruganda.de/');
                        },
                      )
                    ],
                  ),
                ),
              ),
              resizeToAvoidBottomPadding: false,
              appBar: AppBar(
                actions: <Widget>[],
                title: Text("Charity4Change"),
              ),
              extendBody: true,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.transparent,
                heroTag: 'sadFace',
                child: Image.asset('assets/sad_face.png'),
                onPressed: () {
                  model.showPopUp();
                },
              ),
              bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                notchMargin: 12,
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        color: _currentIndex == 0 ? Colors.blue : Colors.black,
                      ),
                      iconSize: 32,
                      onPressed: () {
                        _currentIndex = 0;

                        navigateTo();
                      },
                    ),

                    IconButton(
                      icon: Icon(
                        Icons.insert_chart,
                        color: _currentIndex == 1 ? Colors.blue : Colors.black,
                      ),
                      iconSize: 32,
                      onPressed: () {
                        _currentIndex = 1;

                        navigateTo();
                      },
                    ),
                    SizedBox(width: 40), // The dummy child

                    IconButton(
                      icon: Icon(
                        Icons.euro_symbol,
                        color: _currentIndex == 2 ? Colors.blue : Colors.black,
                      ),
                      iconSize: 32,
                      onPressed: () {
                        _currentIndex = 2;

                        navigateTo();
                      },
                    ),

                    IconButton(
                      icon: Icon(
                        Icons.person_outline,
                        color: _currentIndex == 3 ? Colors.blue : Colors.black,
                      ),
                      iconSize: 32,
                      onPressed: () {
                        _currentIndex = 3;

                        navigateTo();
                      },
                    )
                  ],
                ),
              ),
              body: Center(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: <Widget>[
                    WebView(
                      initialUrl: 'http://www.miteinanderfueruganda.de/',
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                    StatisticsView(),
                    DonationView(),
                    ProfileView()
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => HomeViewModel());
  }
}
