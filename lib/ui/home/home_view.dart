import 'package:blog_app_assignment/core/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/model/blog_category_model.dart';
import '../../core/service/blog_service.dart';
import '../components/dummy_pages.dart';
import '../components/ui_components.dart';
import 'components/home_components.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, "Home"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            categoriListView(),
            blogText(),
            SizedBox(
              height: size.height,
              width: double.infinity,
              child: articleGridView(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buttomBar(context, 1),
    );
  }

  SizedBox categoriListView() {
    return SizedBox(
      height: 170,
      child: FutureBuilder<List<BlogCategoryData>>(
        future: BlogService.instance.getCategories(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                var list = snapshot.data;
                List<BlogCategoryData> categoryList = [];
                for (var item in list!) {
                  categoryList.add(item);
                }
                return Consumer<CategoryModelProvider>(
                    builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: categoryList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      //model variables
                      String img = categoryList[index].image ??
                          "https://dummyimage.com/600x400/000/fff";
                      String title = categoryList[index].title ?? "";
                      //provider
                      String? categoryID = categoryList[index].id;
                      return GestureDetector(
                        onTap: () {
                          value.changeCategory(categoryID);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  img,
                                  fit: BoxFit.fill,
                                  height: 100,
                                  width: 170,
                                ),
                                const SizedBox(height: 10),
                                Text(title),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                    // child: ListView.builder(
                    //   itemCount: categoryList.length,
                    //   shrinkWrap: true,
                    //   scrollDirection: Axis.horizontal,
                    //   itemBuilder: (context, index) {
                    //     //model variables
                    //     String img = categoryList[index].image ??
                    //         "https://dummyimage.com/600x400/000/fff";
                    //     String title = categoryList[index].title ?? "";
                    //     //provider
                    //     String? categoryID = categoryList[index].id;

                    //     return Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Container(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Image.network(
                    //               img,
                    //               fit: BoxFit.fill,
                    //               height: 100,
                    //               width: 170,
                    //             ),
                    //             const SizedBox(height: 10),
                    //             Text(title),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    );
              } else {
                return notFoundWidget;
              }
            default:
              return waitingWidget;
          }
        },
        // child: ListView.builder(
        //   itemCount: 5,
        //   shrinkWrap: true,
        //   scrollDirection: Axis.horizontal,
        //   itemBuilder: (context, index) {
        //     return Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Image.asset(
        //               "assets/background.png",
        //               fit: BoxFit.fill,
        //               height: 100,
        //               width: 170,
        //             ),
        //             const SizedBox(height: 10),
        //             const Text("Category Tag1")
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }

  Padding blogText() {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        "Blog",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
