import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qa_application/core/service/service.dart';
import 'package:qa_application/ui/search_view/serach_view.dart';
import '../../core/model/questions/items.dart';
import '../components/bottom_bar.dart';
import '../components/dummy_pages.dart';
import '../helper/ui_hepler.dart';
import 'widgets/home_view_widgets.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _count = 5;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  void _getMoreData() {
    _count += 5;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: questionsFutureBuilder,
      bottomNavigationBar: buttomBar(context, 0),
    );
  }

  Widget get questionsFutureBuilder => FutureBuilder<List<Items>>(
        future: Service.instance.getQuestion(_count),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                var list = snapshot.data;
                List<Items> questionList = [];
                for (var item in list!) {
                  questionList.add(item);
                }
                return questionsListView(questionList);
              } else {
                return notFoundWidget;
              }
            default:
              return waitingWidget;
          }
        },
      );

  ListView questionsListView(List<Items> questionList) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: questionList.length + 1,
      itemBuilder: (context, index) {
        if (index == questionList.length) {
          return CupertinoActivityIndicator();
        }
        String tagList =
            UiHepler.instance.convertTags(questionList[index].tags!).join(",");
        String questionTitle = questionList[index].title ?? "";
        UiHepler.instance.parseHtmlString(questionList[index].body ?? "");
        String displayName = "";
        String profileImage = "";
        int answerCount = questionList[index].answerCount ?? 0;
        int creationDate = questionList[index].creationDate ?? 0;

        if (questionList[index].owner != null) {
          displayName = questionList[index].owner!.displayName ?? "";
          profileImage = questionList[index].owner!.profileImage ??
              "https://dummyimage.com/600x400/000/fff";
          questionList[index].owner!.accountId ?? 0;
        }
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchView(questionList[index])));
          },
          child: questionContainer(displayName, questionTitle, answerCount,
              tagList, profileImage, creationDate),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
