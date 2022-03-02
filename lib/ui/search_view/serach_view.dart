import 'package:flutter/material.dart';
import 'package:qa_application/core/model/questions/answers.dart';
import '../../core/model/questions/items.dart';
import '../../core/model/users/user_items.dart';
import '../../core/service/service.dart';
import '../components/bottom_bar.dart';
import '../components/dummy_pages.dart';
import '../helper/ui_hepler.dart';
import 'widgets/search_view_widgets.dart';

class SearchView extends StatefulWidget {
  Items question;
  SearchView(
    this.question,
  ) : super();
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchBar(),
                  sizedBox(30),
                  const Text("Profile"),
                  sizedBox(20),
                  profileContainerListView(),
                  sizedBox(30),
                  const Text("Post"),
                  sizedBox(10),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: questionContainer(
                        widget.question.owner!.displayName!,
                        widget.question.creationDate!,
                        widget.question.title!,
                        UiHepler.instance
                            .parseHtmlString(widget.question.body!),
                        widget.question.owner!.profileImage!),
                  ),
                  questionListView(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: buttomBar(context, 1));
  }

  SizedBox profileContainerListView() {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<UserItems>>(
        future: Service.instance.getUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                var list = snapshot.data;
                List<UserItems> userList = [];
                for (var item in list!) {
                  userList.add(item);
                }
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return profileContainer(
                        userList[index].displayName!,
                        UiHepler.instance
                            .parseHtmlString(userList[index].aboutMe!),
                        userList[index].profileImage);
                  },
                );
              } else {
                return notFoundWidget;
              }
            default:
              return waitingWidget;
          }
        },
      ),
    );
  }

  Padding questionListView() {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: SizedBox(
        width: double.infinity,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: widget.question.answers!.length,
          itemBuilder: (context, index) {
            List<Answers> answerList = [];
            if (widget.question.answers != null) {
              for (var item in widget.question.answers!) {
                answerList.add(item);
              }
            }

            String answerBody =
                UiHepler.instance.parseHtmlString(answerList[index].body ?? "");
            String displayName = "";
            String profileImage = "";
            int creationDate = answerList[index].creationDate ?? 0;

            if (widget.question.owner != null) {
              displayName = answerList[index].owner!.displayName ?? "";
              profileImage = answerList[index].owner!.profileImage ??
                  "https://dummyimage.com/600x400/000/fff";
            }
            return questionContainer(
                displayName, creationDate, "", answerBody, profileImage);
          },
        ),
      ),
    );
  }
}
