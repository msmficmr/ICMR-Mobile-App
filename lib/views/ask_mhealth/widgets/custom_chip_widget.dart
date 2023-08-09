import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/viewModel/chat_bot/edit_conversation.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:provider/provider.dart';

class CustomChip extends StatelessWidget {
  final int index;
  final String answer;
  final bool userIcon;
  final bool editable;
  final MainAxisAlignment mainAxisAlignment;

  const CustomChip({
    Key? key,
    required this.answer,
    this.userIcon = true,
    this.editable = false,
    this.mainAxisAlignment = MainAxisAlignment.end,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatBotViewModel chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
    final double screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth > 700 ? 320 : screenWidth;
    return Container(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.only(bottom: 30, left: 5, right: 5, top: 5),
            decoration: BoxDecoration(
              color: AppColorScheme.kPrimaryColor,
              border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: width * 0.5),
                  child: Text(
                    answer,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kPrimaryIconColor),
                  ),
                ),
                if (editable)
                  GestureDetector(
                    onTap: () {
                      editConversation(
                        context: context,
                        currentLanguage: chatBotProvider.currentLanguage,
                        index: index,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      //TODO: Replace with SVG image
                      child: Icon(Icons.edit, color: AppColorScheme.kPrimaryIconColor),
                    ),
                  ),
              ],
            ),
          ),
          if (userIcon)
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(left: 10),
              child: CircleAvatar(
                backgroundColor: AppColorScheme.kPrimaryColor,
                child: CircleAvatar(
                  backgroundColor: AppColorScheme.kPrimaryIconColor,
                  //TODO: Need to fetch the name from the shared preference
                  child: Text(
                    "U",
                    style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kPrimaryColor.shade500),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
