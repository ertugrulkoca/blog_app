import 'owner.dart';

class Answers {
  Owner? owner;
  int? commentCount;
  bool? isAccepted;
  int? score;
  int? creationDate;
  int? answerId;
  int? questionId;
  String? body;

  Answers(
      {this.owner,
      this.commentCount,
      this.isAccepted,
      this.score,
      this.creationDate,
      this.answerId,
      this.questionId,
      this.body});

  factory Answers.fromJson(Map<String, dynamic> json) {
    return Answers(
        owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
        commentCount: json['comment_count'] as int,
        isAccepted: json['is_accepted'] as bool,
        score: json['score'] as int,
        creationDate: json['creation_date'] as int,
        answerId: json['answer_id'] as int,
        questionId: json['question_id'] as int,
        body: json['body'] as String);
  }
  // Answers.fromJson(Map<String, dynamic> json) {
  //   owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  //   commentCount = json['comment_count'];
  //   isAccepted = json['is_accepted'];
  //   score = json['score'];
  //   creationDate = json['creation_date'];
  //   answerId = json['answer_id'];
  //   questionId = json['question_id'];
  //   body = json['body'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['comment_count'] = commentCount;
    data['is_accepted'] = isAccepted;
    data['score'] = score;
    data['creation_date'] = creationDate;
    data['answer_id'] = answerId;
    data['question_id'] = questionId;
    data['body'] = body;
    return data;
  }
}
