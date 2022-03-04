import 'package:flutter/material.dart';

import '../../../core/model/blog_model.dart';
import '../../../core/service/blog_service.dart';
import '../../components/dummy_pages.dart';
import '../article_detail_view.dart';

Padding articleGridView(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: FutureBuilder<List<BlogData>>(
        future: BlogService.instance.getBlogs(null),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
        }
        // child: GridView.builder(
        //   physics: const NeverScrollableScrollPhysics(),
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 20,
        //     crossAxisSpacing: 10,
        //     childAspectRatio: (7 / 10),
        //   ),
        //   itemCount: 8,
        //   itemBuilder: (context, index) {
        //     return articleContainer(index);
        //   },
        // ),
        ),
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
        children: [
          articleName(title),
          favoriteIcon(() {
            BlogService.instance.toggleFavorite(id);
          })
        ],
      ),
    ),
  );
}

Align favoriteIcon(void Function() fun) {
  return Align(
    alignment: Alignment.topRight,
    child: GestureDetector(
      onTap: fun,
      child: Padding(
        padding: EdgeInsets.only(top: 5, right: 10),
        child: Icon(Icons.favorite, color: Colors.white),
      ),
    ),
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
