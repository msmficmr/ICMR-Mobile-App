import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/chat_bot/intents/intents.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/container_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewChat extends StatefulWidget {
  final bool previousChatAvailable;
  final String sectionName;
  final bool fromPreviousChat;

  static const routerPath = "/newChat";

  const NewChat({
    Key? key,
    this.previousChatAvailable = false,
    this.sectionName = "riskAssessment",
    this.fromPreviousChat = false,
  }) : super(key: key);

  @override
  State<NewChat> createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  final Questionnaires _questionnairesRepo = Questionnaires();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> ehrCategoryIdNameMapping = {};
  double cardWidth = 0;
  late ChatBotViewModel chatBotProvider;

  fetchQuestion() async {
    chatBotProvider.setServiceFlow(newFlow: ServiceFlow.none);
    Intents().getRASections(context: context);
    // await _questionnairesRepo.fetchAllQuestionnaires();
    // _questionnairesRepo.fetchNextQuestion(
    //   context: context,
    //   questionId: "are_you_diabetic",
    //   encounterId: "PERSONAL_HISTORY",
    //   ehrCategoryId: "RISK_ASSESSMENT_RISK_ASSESSMENT_PERSONAL_HISTORY",
    // );
  }

  @override
  void initState() {
    super.initState();
    chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
    _questionnairesRepo.setChatBotProvider = context;
    fetchQuestion();

    /// setting up initial question
    WidgetsBinding.instance.addPostFrameCallback((_) {
      clearSharedPreferences();
    });

    chatBotProvider.setServiceFlow(newFlow: ServiceFlow.riskAssessment);

    initiateData(context: context);

    if (mounted) {
      _questionnairesRepo.clearQuestionnaires();
      chatBotProvider.getWelcomeIntent(context: context);
    }
  }

  void clearSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  void initiateData({required BuildContext context}) {
    chatBotProvider.setNewChatScreenMount(true);
    chatBotProvider.setBuildContext(context);
    chatBotProvider.setIsLastQuestion(false);
  }

  @override
  void dispose() {
    chatBotProvider.setNewChatScreenMount(false);
    super.dispose();
  }

  void onBackPressed(BuildContext context) async {
    chatBotProvider.setNewChatScreenMount(false);
    chatBotProvider.clearScreeningData(clearSharedPreferences: true);
  }

  @override
  Widget build(BuildContext context) {
    ChatBotViewModel chatBotViewModel = Provider.of<ChatBotViewModel>(context, listen: true);
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        chatBotProvider.clearScreeningData(clearSharedPreferences: true);
        onBackPressed(context);
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: screenWidth > 800 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
            children: [
              if (screenWidth > 800)
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(left: 70, bottom: 70),
                  child: SvgPicture.asset(
                    AppAssetsPath.appIcon,
                    height: (screenWidth / 8) - 20,
                  ),
                ),
              Container(
                margin: screenWidth > 700 ? const EdgeInsets.all(20) : null,
                width: CommonFunctions.getCardWidth(screenWidth: screenWidth),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return screenWidth > 700
                        ? Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: NewContainerWidget(maxWidth: constraints.maxWidth, showCenterHeading: false),
                          )
                        : NewContainerWidget(maxWidth: constraints.maxWidth, showCenterHeading: false);
                  },
                ),
              ),
              if (screenWidth > 800)
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(top: 70, right: 70),
                  child: SvgPicture.asset(
                    AppAssetsPath.appIcon,
                    height: (screenWidth / 8) - 20,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
