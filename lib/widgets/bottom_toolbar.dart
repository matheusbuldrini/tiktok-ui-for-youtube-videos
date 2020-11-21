import 'package:flutter/material.dart';
import 'package:yt_tt2/tik_tok_icons_icons.dart';

class BottomToolbar extends StatefulWidget {
  BottomToolbar({Key key}) : super(key: key);

  @override
  _BottomToolbar createState() => _BottomToolbar();
}

/// This is the private State class that goes with MyStatefulWidget.
class _BottomToolbar extends State<BottomToolbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print(index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor:
          Theme.of(context).colorScheme.primary, // Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
