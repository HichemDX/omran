class Faq {
  int? id;
  String? questionAr;
  String? questionFr;
  String? reponseAr;
  String? reponseFr;

  Faq(
      {this.id,
      this.questionAr,
      this.questionFr,
      this.reponseAr,
      this.reponseFr});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionAr = json['question_ar'];
    questionFr = json['question_fr'];
    reponseAr = json['reponse_ar'];
    reponseFr = json['reponse_fr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_ar'] = this.questionAr;
    data['question_fr'] = this.questionFr;
    data['reponse_ar'] = this.reponseAr;
    data['reponse_fr'] = this.reponseFr;
    return data;
  }
}
