import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/model/blog_model.dart';
import '../../core/provider/favorities_provider.dart';
import '../../core/service/account_service.dart';
import '../components/dummy_pages.dart';
import '../components/ui_components.dart';
import '../home/components/home_components.dart';

class MyFavorites extends StatelessWidget {
  const MyFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, "My Favorites"),
      body: SingleChildScrollView(
          child: SizedBox(
              height: size.height,
              width: size.width,
              child: favArticleGridView(context))),
      bottomNavigationBar: buttomBar(context, 0),
    );
  }
}

Padding favArticleGridView(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Consumer<FavoritiesModelProvider>(builder: (context, value, child) {
      return FutureBuilder<List<BlogData>>(
          future: AccountService.instance.getFavoriBlogs(value.getfavState()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  var list = snapshot.data;
                  List<BlogData> favBlogList = [];
                  for (var item in list!) {
                    favBlogList.add(item);
                  }
                  return GridView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      childAspectRatio: (7 / 10),
                    ),
                    itemCount: favBlogList.length,
                    itemBuilder: (context, index) {
                      //model variables
                      String img = favBlogList[index].image ??
                          "https://dummyimage.com/600x400/000/fff";
                      String title = favBlogList[index].title ?? "";
                      String id = favBlogList[index].id ?? "0";
                      return GestureDetector(
                        onTap: () {},
                        child: articleContainer(
                            context, img, title, id, favBlogList[index]),
                      );
                    },
                  );
                } else {
                  return notFoundWidget;
                }

              default:
                return waitingWidget;
            }
          });
    }
        // child: FutureBuilder<List<BlogData>>(
        //     future: AccountService.instance.getFavoriBlogs(),
        //     builder: (context, snapshot) {
        //       switch (snapshot.connectionState) {
        //         case ConnectionState.done:
        //           if (snapshot.hasData) {
        //             var list = snapshot.data;
        //             List<BlogData> favBlogList = [];
        //             for (var item in list!) {
        //               favBlogList.add(item);
        //             }
        //             return GridView.builder(
        //               // physics: const NeverScrollableScrollPhysics(),
        //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //                 crossAxisCount: 2,
        //                 mainAxisSpacing: 20,
        //                 crossAxisSpacing: 10,
        //                 childAspectRatio: (7 / 10),
        //               ),
        //               itemCount: favBlogList.length,
        //               itemBuilder: (context, index) {
        //                 //model variables
        //                 String img = favBlogList[index].image ??
        //                     "https://dummyimage.com/600x400/000/fff";
        //                 String title = favBlogList[index].title ?? "";
        //                 String id = favBlogList[index].id ?? "0";
        //                 return GestureDetector(
        //                   onTap: () {},
        //                   child: articleContainer(
        //                       context, img, title, id, favBlogList[index]),
        //                 );
        //               },
        //             );
        //           } else {
        //             return notFoundWidget;
        //           }

        //         default:
        //           return waitingWidget;
        //       }
        //     }),
        ),
  );
}
