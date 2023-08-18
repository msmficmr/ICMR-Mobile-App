import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/viewModel/chat_bot/edit_conversation.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:provider/provider.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    required this.ans,
    this.showUserIcon = true,
    this.editable = false,
    this.mainAxisAlignment = MainAxisAlignment.end,
    required this.index,
  }) : super(key: key);

  final String ans;
  final bool showUserIcon;
  final MainAxisAlignment mainAxisAlignment;
  final bool editable;
  final int index;

  @override
  Widget build(BuildContext context) {
    ChatBotViewModel chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
    final double screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth > 700 ? 320 : screenWidth;
    return Container(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30, left: 5, right: 5, top: 5),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColorScheme.kPrimaryColor,
                border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: width * 0.5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Scrollbar(
                              thickness: 0,
                              showTrackOnHover: false,
                              hoverThickness: 0,
                              isAlwaysShown: false,
                              trackVisibility: false,
                              child: Text(
                                ans.trim(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 6,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  textBaseline: TextBaseline.ideographic,
                                  height: AppConstant.TEXT_HEIGHT,
                                  color: AppColorScheme.kPrimaryIconColor,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                          child: Image.asset(
                            AppAssetsPath.editIcon,
                            width: 20,
                            height: 20,
                            color: AppColorScheme.kPrimaryIconColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (showUserIcon)
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(bottom: 20),
              child: CircleAvatar(
                radius: 27,
                backgroundColor: AppColorScheme.kPrimaryColor,
                child: CircleAvatar(
                  backgroundColor: AppColorScheme.kPrimaryIconColor,
                  radius: 25,
                  child: Text(
                    "U",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColorScheme.kPrimaryColor.shade50,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
