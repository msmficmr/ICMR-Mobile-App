// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mhealth/model/conversation_model.dart';
// import 'package:mhealth/repo/questionnaires.dart';
// import 'package:mhealth/viewModel/chat_bot_view_model.dart';
// import 'package:mhealth/views/ask_mhealth/widgets/custom_chip_widget.dart';
// import 'package:mhealth/views/ask_mhealth/widgets/question.dart';
// import 'package:provider/provider.dart';
//
// class BMITextField extends StatefulWidget {
//   const BMITextField({
//     Key? key,
//     required this.conversationModel,
//     required this.screenWidth,
//     required this.index,
//   }) : super(key: key);
//
//   final ConversationModel conversationModel;
//   final double screenWidth;
//   final int index;
//
//   @override
//   _BMITextFieldState createState() => _BMITextFieldState();
// }
//
// class _BMITextFieldState extends State<BMITextField> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late TextEditingController _textEditingControllerForHeight;
//   late TextEditingController _textEditingControllerForWeight;
//   double? height;
//   double? weight;
//
//   @override
//   void initState() {
//     super.initState();
//     _textEditingControllerForHeight = TextEditingController();
//     _textEditingControllerForWeight = TextEditingController();
//     height = widget.conversationModel.followupQuestions[""][0]["answer"] ?? 0.0;
//     weight = widget.conversationModel.followupQuestions[""][1]["answer"] ?? 0.0;
//   }
//
//   @override
//   void dispose() {
//     _textEditingControllerForHeight.dispose();
//     _textEditingControllerForWeight.dispose();
//     super.dispose();
//   }
//
//   /// calculates BMI
//   /// assumption:
//   /// height in cms
//   /// weight in kgs
//   String calculateBMI({required double height, required double weight}) {
//     return ((weight * 10000) / (height * height)).toStringAsFixed(2);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ChatBotViewModel chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: true);
//
//     return Container(
//       margin: EdgeInsets.only(
//         top: 40,
//         bottom: widget.conversationModel.followUpSubmitted ? 10 : 90,
//       ),
//       width: widget.screenWidth,
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 20),
//             child: Question(
//               screenWidth: widget.screenWidth,
//               questionText: widget.conversationModel.question,
//               questionTime: DateTime.now(),
//             ),
//           ),
//           widget.conversationModel.followUpSubmitted
//               ? Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         subQuestion(question: widget.conversationModel.followupQuestions[""][0]["question"]),
//                         CustomChip(
//                           index: widget.index,
//                           answer: height.toString(),
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           showUserIcon: false,
//                           editable: false,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(width: 30),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         subQuestion(question: widget.conversationModel.followupQuestions[""][1]["question"]),
//                         CustomChip(
//                           index: widget.index,
//                           answer: weight.toString(),
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           showUserIcon: true,
//                           editable: widget.conversationModel.isEditable,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(width: 10),
//                   ],
//                 )
//               : Form(
//                   key: _formKey,
//                   child: Container(
//                     constraints: const BoxConstraints(minWidth: 150, maxWidth: 600),
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         subQuestion(question: widget.conversationModel.followupQuestions[""][0]["question"]),
//                         const SizedBox(height: 5),
//                         bmiTextField(
//                           hintText: "Height",
//                           screenWidth: widget.screenWidth,
//                           languageCode: chatBotProvider.currentLanguage,
//                           textEditingControllerForHeight: _textEditingControllerForHeight,
//                         ),
//                         const SizedBox(height: 30),
//                         subQuestion(question: widget.conversationModel.followupQuestions[""][1]["question"]),
//                         const SizedBox(height: 5),
//                         bmiTextField(
//                           hintText: "Weight",
//                           screenWidth: widget.screenWidth,
//                           languageCode: chatBotProvider.currentLanguage,
//                           textEditingControllerForHeight: _textEditingControllerForWeight,
//                         ),
//                         const SizedBox(height: 20),
//                         ProceedButton(
//                           callingAPI: () {
//                             if (_formKey.currentState!.validate()) {
//                               onSubmit(chatBotProvider: chatBotProvider);
//                             }
//                           },
//                           topPadding: 10,
//                           bottomPAdding: 10,
//                           text: getText(
//                             language: chatBotProvider.currentLanguage,
//                             engText: SUBMIT_TEXT,
//                             teluguText: SUBMIT_TEXT_IN_TELUGU,
//                             malayalamText: SUBMIT_TEXT_IN_MALAYALLAM,
//                             kannadaText: SUBMIT_TEXT_IN_KANNADA,
//                             hindiText: SUBMIT_TEXT_IN_HINDI,
//                             marathiText: SUBMIT_TEXT_IN_MARATHI,
//                             bengaliText: SUBMIT_TEXT_IN_BENGALI,
//                             tamilText: SUBMIT_TEXT_IN_TAMIL,
//                             odiaText: SUBMIT_TEXT_IN_ODIA,
//                             manipuriText: SUBMIT_TEXT_IN_MANIPURI,
//                           ),
//                           buttonWidth: 200,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
//
//   Widget subQuestion({required String question}) {
//     return Container(
//       alignment: Alignment.topLeft,
//       child: Text(
//         question,
//         softWrap: true,
//         style: regular_black6_14,
//       ),
//     );
//   }
//
//   Widget bmiTextField({
//     required double screenWidth,
//     required String hintText,
//     required TextEditingController textEditingControllerForHeight,
//     required String languageCode,
//   }) {
//     return Container(
//       width: screenWidth,
//       child: TextFormFieldWidget(
//         hintText: hintText,
//         textInputType: TextInputType.number,
//         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//         actionKeyboard: TextInputAction.done,
//         controller: textEditingControllerForHeight,
//         parametersValidate: getText(
//           language: languageCode,
//           engText: THIS_FIELD_IS_REQUIRED,
//           teluguText: THIS_FIELD_IS_REQUIRED_IN_TELUGU,
//           malayalamText: THIS_FIELD_IS_REQUIRED_IN_MALAYALLAM,
//           kannadaText: THIS_FIELD_IS_REQUIRED_IN_KANNADA,
//           hindiText: THIS_FIELD_IS_REQUIRED_IN_HINDI,
//           marathiText: THIS_FIELD_IS_REQUIRED_IN_MARATHI,
//           bengaliText: THIS_FIELD_IS_REQUIRED_IN_BENGALI,
//           tamilText: THIS_FIELD_IS_REQUIRED_IN_TAMIL,
//           odiaText: SUBMIT_TEXT_IN_ODIA,
//           manipuriText: SUBMIT_TEXT_IN_MANIPURI,
//         ),
//       ),
//     );
//   }
//
//   // callback function that decides what happens when user submit follow-up
//   // question
//   void onSubmit({required ChatBotViewModel chatBotProvider}) {
//     final Questionnaires questionariesRepository = Questionnaires();
//     try {
//       height = double.parse(_textEditingControllerForHeight.text);
//     } catch (error) {
//       height = 0.0;
//     }
//     try {
//       weight = double.parse(_textEditingControllerForWeight.text);
//     } catch (error) {
//       weight = 0.0;
//     }
//
//     if (chatBotProvider.isNextSuggestionClickable) {
//       chatBotProvider.setIsNextSuggestionClickable(isNextSuggestionClickable: false);
//       if (height! > 0.0 && weight! > 0.0) {
//         questionariesRepository.conversation.first.followUpSubmitted = true;
//         questionariesRepository.conversation.first.followupQuestions[""][0]["answer"] = height;
//         questionariesRepository.conversation.first.followupQuestions[""][1]["answer"] = weight;
//         questionariesRepository.conversation.first.followupQuestions[""].add({
//           "questionId": "bmi",
//           "question": "bmi",
//           "answer": calculateBMI(height: height!, weight: weight!),
//         });
//         chatBotProvider.notify();
//         chatBotProvider.onUserSelectsOption(conversationModel: widget.conversationModel, context: context);
//       }
//     }
//     chatBotProvider.setIndex(widgetIndex: widget.index);
//   }
// }
