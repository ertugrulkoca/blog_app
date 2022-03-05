import 'package:blog_app_assignment/core/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/model/blog_category_model.dart';
import '../../../core/model/blog_model.dart';
import '../../../core/provider/favorities_provider.dart';
import '../../../core/service/blog_service.dart';
import '../../components/dummy_pages.dart';
import '../article_detail_view.dart';

// home view kategori listesi ve PROVIDER kullanımı.
SizedBox categoriListView() {
  return SizedBox(
    height: 170,
    child: FutureBuilder<List<BlogCategoryData>>(
      future: BlogService.instance.getCategories(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              // snapshot'dan gelen datalar listeye atılıyor
              var list = snapshot.data;
              List<BlogCategoryData> categoryList = [];
              for (var item in list!) {
                categoryList.add(item);
              }

              // kategoriye göre filtrelemek için PROVIDER kullanımı.
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
                        // kategori değişikliğini anlama.
                        value.changeCategory(categoryID);

                        // seçilen kategori için uyarı mesajı
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('category ${index + 1} selected'),
                        ));
                      },
                      // kategori değişkenleri.
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                    );
                  },
                );
              });
            } else {
              // datada sorun olursa gösterilecek sayfa.
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

// kategori id ye göre sıralamak için PROVIDER kullanımı.
// eğer seçilen kategori yok ise value.getCategoryID() null döner.
Padding articleGridView(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Consumer<CategoryModelProvider>(builder: (context, value, child) {
      return FutureBuilder<List<BlogData>>(
          //kategori kontrol
          future: BlogService.instance.getBlogs(value.getCategoryID()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  // snapshot'dan gelen datalar listeye atılıyor
                  var list = snapshot.data;
                  List<BlogData> blogList = [];
                  for (var item in list!) {
                    blogList.add(item);
                  }

                  return GridView.builder(
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
                  // datada sorun olursa gösterilecek sayfa.
                  return notFoundWidget;
                }
              default:
                return waitingWidget;
            }
          });
    }),
  );
}

//apiden dönen değerlerin yerleştirilmesi için articleContainer().
GestureDetector articleContainer(
    BuildContext context, String img, title, id, BlogData article) {
  return GestureDetector(
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
      child: Stack(
        children: [articleName(title), favoriteIcon(id)],
      ),
    ),
    onTap: () {
      //tıklanılan makalenin sayfasına geçiş.
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ArtivleView(article)));
    },
  );
}

//  makalenin favoriye alınıp çıkartılması için PROVIDER kullanımı.
Align favoriteIcon(String id) {
  return Align(
    alignment: Alignment.topRight,
    child: Consumer<FavoritiesModelProvider>(builder: (context, value, child) {
      return GestureDetector(
        onTap: () async {
          //id ye göre favorilere ekleme yada çıkartma işlemi.
          String message = await BlogService.instance.toggleFavorite(id);

          //ekleme yada çıkarma işlemi için göre snackBar uyarı mesajı
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
          ));

          // değişikliği dinlemek için provider.
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
