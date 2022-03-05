import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/model/blog_model.dart';
import '../../../core/provider/favorities_provider.dart';
import '../../../core/service/account_service.dart';
import '../../components/dummy_pages.dart';
import '../../home/components/home_components.dart';

Padding favArticleGrid(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Consumer<FavoritiesModelProvider>(
      builder: (context, value, child) {
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
                  return favArticleGridBuilder(favBlogList);
                } else {
                  return notFoundWidget;
                }

              default:
                return waitingWidget;
            }
          },
        );
      },
    ),
  );
}

GridView favArticleGridBuilder(List<BlogData> favBlogList) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      childAspectRatio: (7 / 10),
    ),
    itemCount: favBlogList.length,
    itemBuilder: (context, index) {
      //model variables
      String img =
          favBlogList[index].image ?? "https://dummyimage.com/600x400/000/fff";
      String title = favBlogList[index].title ?? "";
      String id = favBlogList[index].id ?? "0";
      return GestureDetector(
        onTap: () {},
        child: articleContainer(context, img, title, id, favBlogList[index]),
      );
    },
  );
}
