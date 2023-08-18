import 'package:flutter/material.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class PersonalHistoryScreen extends StatefulWidget {
  static const routerPath = "/personalHistoryScreen";
  const PersonalHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PersonalHistoryScreen> createState() => _PersonalHistoryScreenState();
}

class _PersonalHistoryScreenState extends State<PersonalHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: ChangeNotifierProvider(
            create: (context) => ChatBotViewModel()..fetchQuestionnaire(sectionName: AppAssetsPath.personalHistoryQuestionnaire),
            child: Consumer<ChatBotViewModel>(
              builder: (context, state, child) {
                return Text("State is ${state.currentVersionNumber}");
              },
            ),
          ),
        ),
      ),
    );
  }
}
