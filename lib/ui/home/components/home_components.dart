import 'package:blog_app_assignment/core/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/model/blog_category_model.dart';
import '../../../core/model/blog_model.dart';
import '../../../core/provider/favorities_provider.dart';
import '../../../core/service/blog_service.dart';
import '../../components/dummy_pages.dart';
import '../article_detail_view.dart';

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
              });
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

Padding blogText() {
  return const Padding(
    padding: EdgeInsets.only(left: 10),
    child: Text(
      "Blog",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  );
}

Padding articleGridView(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Consumer<CategoryModelProvider>(builder: (context, value, child) {
      return FutureBuilder<List<BlogData>>(
          future: BlogService.instance.getBlogs(value.getCategoryID()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  var list = snapshot.data;
                  List<BlogData> blogList = [];
                  for (var item in list!) {
                    blogList.add(item);
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
                    itemCount: blogList.length,
                    itemBuilder: (context, index) {
                      //model variables
                      String img = blogList[index].image ??
                          "https://dummyimage.com/600x400/000/fff";
                      String title = blogList[index].title ?? "";
                      String id = blogList[index].id ?? "0";
                      return articleContainer(
                          context, img, title, id, blogList[index]);
                    },
                  );
                } else {
                  return notFoundWidget;
                }

              default:
                return waitingWidget;
            }
          });
    }),
  );
}

GestureDetector articleContainer(
    BuildContext context, String img, title, id, BlogData article) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ArtivleView(article)));
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
      child: Stack(
        children: [articleName(title), favoriteIcon(id)],
      ),
    ),
  );
}

Align favoriteIcon(String id) {
  return Align(
    alignment: Alignment.topRight,
    child: Consumer<FavoritiesModelProvider>(builder: (context, value, child) {
      return GestureDetector(
        onTap: () {
          BlogService.instance.toggleFavorite(id);
          value.changefavState(!value.getfavState());
        },
        child: const Padding(
          padding: EdgeInsets.only(top: 5, right: 10),
          child: Icon(Icons.favorite, color: Colors.white),
        ),
      );
    }),
  );
}

Align articleName(String title) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      width: double.infinity,
      height: 50,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    ),
  );
}
