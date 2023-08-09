import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/chat.dart';
import 'package:mhealth/views/ask_mhealth/widgets/new_chat_header.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class NewContainerWidget extends StatefulWidget {
  final double maxWidth;
  final bool showCenterHeading;

  const NewContainerWidget({Key? key, required this.maxWidth, required this.showCenterHeading}) : super(key: key);

  @override
  State<NewContainerWidget> createState() => _NewContainerWidgetState();
}

class _NewContainerWidgetState extends State<NewContainerWidget> {
  final Questionnaires _questionnairesRepository = Questionnaires();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatBotViewModel>(
      builder: (context, chatBotProvider, child) {
        final _conversationLength = _questionnairesRepository.getLength;
        final screenWidth = MediaQuery.of(context).size.width;
        return Container(
          width: widget.maxWidth,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: screenWidth > 700 ? const BorderRadius.all(Radius.circular(20)) : null,
          ),
          child: Column(
            children: [
              if (screenWidth < 700) const NewChatHeader(hasBorder: false),
              if (screenWidth >= 700) const NewChatHeader(),
              Visibility(
                visible: widget.showCenterHeading,
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: AppColorScheme.kPrimaryColor.shade50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 25),
                          child: Text(
                            AppConstant.PREVIOUS_RISK_ASSESSMENT,
                            textAlign: TextAlign.center,
                            style: AppStyles.titleMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SpaceWidget(height: 10),
              Expanded(
                child: _questionnairesRepository.conversation.isNotEmpty
                    ? AnimatedList(
                      controller: chatBotProvider.scrollController,
                      key: chatBotProvider.animationKey,
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      reverse: true,
                      initialItemCount: _conversationLength,
                      itemBuilder: (context, index, animation) {
                        // if the messages is new and untapped, then only the loader
                        // should show for it
                        // To show loading Animation only for the last received question, that's why we keep
                        // condition "index == 0", the last received question always comes at index 0.
                        if (index <= _conversationLength - 1) {
                          return Column(
                            children: [
                              AnimatedChatWidget(
                                index: index,
                                animation: animation,
                                maxWidth: widget.maxWidth,
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
