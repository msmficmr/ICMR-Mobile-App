import 'package:mhealth/model/questionnaire_form_model.dart';

class CRAModel {
  String? ehrCategoryMap;
  List<Questionnaire>? questionnaireList;

  CRAModel(this.ehrCategoryMap, this.questionnaireList);

  Map<String, dynamic> toJson() => {'ehrCategoryMapId': ehrCategoryMap, 'ehrNotes': (questionnaireList ?? []).map((Questionnaire e) => e.toJson())};
}