import 'package:qa_application/core/model/questions/items.dart';
import '../helper/db_helper.dart';
import '../model/questions/answers.dart';
import '../model/questions/owner.dart';

class DbService {
  static final DbService _instance = DbService._private();
  DbService._private();
  static DbService get instance => _instance;
  Future<void> ownerAdd(
      int accountId, String profileImage, displayName, link) async {
    var db = await DbHepler.databaseAccess();
    var info = Map<String, dynamic>();
    info["account_id"] = accountId;
    info["profile_image"] = profileImage;
    info["display_name"] = displayName;
    info["link"] = link;

    await db.insert("Owner", info);
  }

  Future<void> questionAdd(int questionId, accountId, isAnswered, viewCount,
      answerCount, score, creationDate, String link, title, body) async {
    var db = await DbHepler.databaseAccess();
    var info = Map<String, dynamic>();
    info["question_id"] = questionId;
    info["account_id"] = accountId;
    info["is_answered"] = isAnswered;
    info["view_count"] = viewCount;
    info["answer_count"] = answerCount;
    info["score"] = score;
    info["creation_date"] = creationDate;
    info["link"] = link;
    info["title"] = title;
    info["body"] = body;

    await db.insert("Items", info);
  }

  Future<void> tagAdd(int questionId, String tag) async {
    var db = await DbHepler.databaseAccess();
    var info = Map<String, dynamic>();
    info["tag"] = tag;
    info["question_id"] = questionId;
    await db.insert("Tags", info);
  }

  Future<void> answerAdd(int answerId, creationDate, questionId, String body,
      int accountId) async {
    var db = await DbHepler.databaseAccess();
    var info = Map<String, dynamic>();
    info["answer_id"] = answerId;
    info["creation_date"] = creationDate;
    info["question_id"] = questionId;
    info["body"] = body;
    info["account_id"] = accountId;
    await db.insert("Answers", info);
  }

  Future<List<Items>> questions() async {
    var db = await DbHepler.databaseAccess();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM Items, Owner, Tags"
        "Where Items.account_id = Owner.account_id and Items.question_id = Tags.question_id");
    List<String> tag = [];
    return List.generate(maps.length, (i) {
      var line = maps[i];
      var owner = Owner(
          accountId: line["account_id"],
          userId: line["user_id"],
          profileImage: line["profile_image"],
          displayName: line["display_name"],
          link: line["link"]);
      tag.add(line["tag"]);

      return Items(
          owner: owner,
          tags: tag,
          questionId: line["question_id"],
          isAnswered: line["is_answered"],
          viewCount: line["view_count"],
          body: line["body"],
          link: line["link"],
          title: line["title"],
          score: line["score"],
          answerCount: line["answer_count"],
          creationDate: line["creation_date"]);
    });
  }

  Future<List<Answers>> answers() async {
    var db = await DbHepler.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM Items, Owner,Answers"
        "Where Items.question_id = Answers.question_id and Answers.account_id = Owner.account_id");

    // List<Answers> answer = [];
    return List.generate(maps.length, (i) {
      var line = maps[i];
      var owner = Owner(
          accountId: line["account_id"],
          userId: line["user_id"],
          profileImage: line["profile_image"],
          displayName: line["display_name"],
          link: line["link"]);
      return Answers(
          answerId: line["answer_id"],
          isAccepted: line["is_accepted"],
          score: line["score"],
          creationDate: line["creation_date"],
          commentCount: line["commentCount"],
          questionId: line["question_id"],
          body: line["body"],
          owner: owner);
    });
  }
}
