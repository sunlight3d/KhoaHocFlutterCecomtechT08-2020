import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/screens.dart';
import 'package:myapp/types/role_type.dart';
import 'package:myapp/widgets/business_widget.dart';
import 'package:myapp/widgets/products_widget.dart';
import 'package:myapp/widgets/setting_widget.dart';


class TabScreen extends StatefulWidget {
  final int roleType;
  TabScreen({this.roleType});
  @override
  State<StatefulWidget> createState() => _TabScreen();
}

class _TabScreen extends State<TabScreen> {
  int _currentIndex = 0;
  get roleType => this.widget.roleType;
  List<BottomNavigationBarItem> get barItems {
    return roleType == RoleType.admin || roleType == RoleType.owner ?
    [
      BottomNavigationBarItem(
          icon: Icon(Icons.list_rounded,),
          title: Text('Products'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.business),
        title: Text('Business'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        title: Text('Settings'),
      )
    ]:
    [
      BottomNavigationBarItem(icon: Icon(Icons.list_rounded)),
      BottomNavigationBarItem(icon: Icon(Icons.business)),
    ];

  }
  List<Widget> get tabScreens {
    return roleType == RoleType.admin || roleType == RoleType.owner ?
    [
      ProductsWidget(),
      BusinessWidget(),
      SettingWidget()
    ]:
    [
      ProductsWidget(),
      BusinessWidget(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Something'),
        actions: [

        ],
      ),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ]+ tabScreens.asMap().entries.map((entry){
              return ListTile(
                title: barItems[entry.key].title,
                onTap: (){
                  setState(() {
                    _currentIndex = entry.key;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList()
            +[
              ListTile(
                title: Text('Log out', style: TextStyle(color: Colors.red)),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
                      ModalRoute.withName('/'));

                },
              )
              ],
          )// Populate the Drawer in the next step.
      ),
      body: tabScreens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: barItems,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.redAccent,
        onTap: (selectedIndex){
          setState(() {
            _currentIndex = selectedIndex;
          });
        },
      ),

    );
  }
}