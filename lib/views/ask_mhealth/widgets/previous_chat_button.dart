import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/viewModel/chat_bot/intents/intents.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:provider/provider.dart';

class PreviousRiskAssessmentButton extends StatefulWidget {
  const PreviousRiskAssessmentButton({Key? key}) : super(key: key);

  @override
  State<PreviousRiskAssessmentButton> createState() => _PreviousRiskAssessmentButtonState();
}

class _PreviousRiskAssessmentButtonState extends State<PreviousRiskAssessmentButton> {
  Map<String, String> languageMap = {};
  bool _asCaseId = false;

  @override
  void initState() {
    super.initState();
    final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      languageMap = chatBotProvider.languageMapObject;
      _asCaseId = chatBotProvider.hasCaseId;
      chatBotProvider.notify();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatBotViewModel>(
      builder: (context, chatBotProvider, child) {
        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  if (chatBotProvider.isPreviousChatButtonClickable) {
                    Intents().getLanguageIntent(context: context, languageMap: languageMap);
                    chatBotProvider.setIsPreviousChatButtonClickable(isPreviousChatButtonClickable: false);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 220,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColorScheme.kPrimaryIconColor,
                    border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Take Another Assessment",
                    textAlign: TextAlign.center,
                    style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kPrimaryColor),
                  ),
                ),
              ),
            ),
            _asCaseId
                ? Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        if (chatBotProvider.isPreviousChatButtonClickable) {
                          chatBotProvider.setIsPreviousChatButtonClickable(isPreviousChatButtonClickable: false);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 220,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColorScheme.kPrimaryIconColor,
                          border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Text(
                          AppConstant.PREVIOUS_RISK_ASSESSMENT,
                          textAlign: TextAlign.center,
                          style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kPrimaryColor),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
