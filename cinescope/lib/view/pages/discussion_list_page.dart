import 'package:cinescope/model/providers/discussion_provider.dart';
import 'package:cinescope/view/general_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DiscussionListPage extends GeneralPage {
  final String filmId;
  DiscussionListPage(this.filmId, {super.key})
      : super(
            floatingActionButton: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                child:FloatingActionButton(
                  backgroundColor: const Color(0xFFD7CCCF),
                  onPressed: () {
                    print("siuuu");
                  },
                  child: const FaIcon(FontAwesomeIcons.plus, color: Colors.black,),
                )));

  @override
  State<StatefulWidget> createState() => DiscussionListPageState();
}

class DiscussionListPageState extends GeneralPageState<DiscussionListPage> {
  Widget buildDiscussionCard(BuildContext context) {
    return Container();
  }

  @override
  List<Widget> getBody(BuildContext context) {
    return [
      Consumer<DiscussionProvider>(
          builder: (context, provider, _) => FutureBuilder(
                future: provider.getDiscussionsByFilmId(widget.filmId),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return buildDiscussionCard(context);
                  } else if (!snapshot.hasError) {
                    return const Text("Loading...");
                  }
                  return const Text(
                      "Something went wrong while loading discussions...");
                }),
              )),
    ];
  }

  @override
  Widget getTitle(BuildContext context) {
    return Row(children: [
      IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
        iconSize: 40,
      ),
      const SizedBox(width: 10),
      const Text(
        "Discussions",
        textAlign: TextAlign.left,
        textScaleFactor: 2.2,
      ),
    ]);
    //TODO: add divider
  }
}
