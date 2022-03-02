import 'package:flutter/material.dart';

AppBar appbar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: userInfoAppbar(),
    ),
    actions: [
      circleAvatar("assets/pp.jpg"),
    ],
  );
}

Column userInfoAppbar() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Ertuğrul",
        style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      const Text(
        "Mobil Developer",
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    ],
  );
}

SizedBox circleAvatar(String img) {
  return SizedBox(
    height: 65,
    child: CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage(
        img,
      ),
    ),
  );
}

SizedBox circleNetWorkAvatar(String img) {
  return SizedBox(
    height: 65,
    child: CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(img),
    ),
  );
}

Padding questionContainer(String name, String title, int answer, String tags,
    String imgUrl, int date) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            circleNetWorkAvatar(imgUrl),
            userInfoContainer(name, date),
            const Expanded(
              child: SizedBox(),
            ),
            iconBookmark(),
          ],
        ),
        question(title),
        questionInfo(answer, tags),
        underLine()
      ],
    ),
  );
}

Padding userInfoContainer(String name, int date) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "$date",
          style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
        ),
      ],
    ),
  );
}

Icon iconBookmark() {
  return const Icon(
    Icons.bookmark_border,
    color: Colors.black,
    size: 20,
  );
}

Padding question(String title) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text(
      title,
      style: TextStyle(fontSize: 18, height: 1.5),
    ),
  );
}

Padding questionInfo(int answer, String tags) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$answer answer"),
        SizedBox(width: 30),
        Flexible(child: Text(tags, overflow: TextOverflow.ellipsis)),
      ],
    ),
  );
}

Container underLine() {
  return Container(
    width: double.infinity,
    color: Colors.grey,
    height: 1,
  );
}
