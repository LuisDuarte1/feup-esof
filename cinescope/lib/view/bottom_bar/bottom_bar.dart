import 'package:cinescope/view/pages/inbox_page.dart';
import 'package:cinescope/view/pages/main_page.dart';
import 'package:cinescope/view/pages/profile_page.dart';
import 'package:cinescope/view/pages/search_page.dart';
import 'package:cinescope/view/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<StatefulWidget> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  bool _isVisible = true;

  @override
  void initState(){
    super.initState();
    final keyboardVisibilityController = KeyboardVisibilityController();

    keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _isVisible = !visible;
      });
     });
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Container(
            color: const Color(0xFFF0EDEE),
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MainPage()));
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.house,
                          color: Colors.black,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.solidUser,
                          color: Colors.black,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const WatchlistPage()));
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.black,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const InboxPage()));
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.inbox,
                          color: Colors.black,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          color: const Color(0xFFD7CCCF),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const SearchPage()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0x00000000),
                                  fixedSize: const Size.square(60),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                              child: const FaIcon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: Colors.black))))
                ]))
        : Container();
  }
}