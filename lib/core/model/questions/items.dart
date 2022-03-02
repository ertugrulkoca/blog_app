import 'answers.dart';
import 'owner.dart';

class Items {
  List<String>? tags;
  List<Answers>? answers;
  Owner? owner;
  bool? isAnswered;
  int? viewCount;
  int? answerCount;
  int? score;
  int? creationDate;
  int? questionId;
  String? link;
  String? title;
  String? body;

  Items(
      {this.tags,
      this.answers,
      this.owner,
      this.isAnswered,
      this.viewCount,
      this.answerCount,
      this.score,
      this.creationDate,
      this.questionId,
      this.link,
      this.title,
      this.body});

  factory Items.fromJson(Map<String, dynamic> json) {
    List<String>? tagsArray = [];
    if (json["tags"] != null) {
      tagsArray = json["tags"].cast<String>();
    }

    List<Answers> answersList = [];
    if (json["answers"] != null) {
      var answersArray = json["answers"] as List;
      answersList = answersArray.map((e) => Answers.fromJson(e)).toList();
    }

    return Items(
        tags: tagsArray,
        answers: json['answers'] != null ? answersList : null,
        owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
        isAnswered:
            json["is_answered"] != null ? json["is_answered"] as bool : null,
        viewCount:
            json["view_count"] != null ? json["view_count"] as int : null,
        answerCount:
            json['answer_count'] != null ? json['answer_count'] as int : null,
        score: json['score'] != null ? json['score'] as int : null,
        creationDate:
            json['creation_date'] != null ? json['creation_date'] as int : null,
        questionId:
            json['question_id'] != null ? json['question_id'] as int : null,
        link: json['link'] != null ? json['link'] as String : null,
        title: json['title'] != null ? json['title'] as String : null,
        body: json['body'] != null ? json['body'] as String : null);
  }
  // Items.fromJson(Map<String, dynamic> json) {
  //   tags = json['tags'].cast<String>();
  //   if (json['answers'] != null) {
  //     answers = <Answers>[];
  //     json['answers'].forEach((v) {
  //       answers!.add(Answers.fromJson(v));
  //     });
  //   }
  //   owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  //   isAnswered = json['is_answered'];
  //   viewCount = json['view_count'];
  //   answerCount = json['answer_count'];
  //   score = json['score'];
  //   creationDate = json['creation_date'];
  //   questionId = json['question_id'];
  //   link = json['link'];
  //   title = json['title'];
  //   body = json['body'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tags'] = tags;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['is_answered'] = isAnswered;
    data['view_count'] = viewCount;
    data['answer_count'] = answerCount;
    data['score'] = score;
    data['creation_date'] = creationDate;
    data['question_id'] = questionId;
    data['link'] = link;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
