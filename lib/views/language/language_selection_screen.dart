import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_styles.dart';

import '../../config/theme/filled_button_theme_style.dart';
import '../../utils/app_color_scheme.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_values.dart';
import '../../utils/enums.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/primary_filled_button.dart';
import '../../widgets/space_widget.dart';
import 'widget/custom_language_card_widget.dart';

class LanguageSelectionScreen extends StatefulWidget {
  static const String routerPath = "/languageSelectionScreen";
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  List<Map<String, String>> languages = [
    {"locale": "en_US", "name": "English", "englishText": "English"},
    {"locale": "hi", "name": "हिन्दी", "englishText": "Hindi"},
    {"locale": "mr", "name": "मराठी", "englishText": "Marathi"},
    {"locale": "te", "name": "తెలుగు", "englishText": "Telegu"},
    {"locale": "ru", "name": "മലയാളം", "englishText": "Malayalam"},
    {"locale": "kn", "name": "ಕನ್ನಡ", "englishText": "Kannada"},
    {"locale": "bn", "name": "বাংলা", "englishText": "Bengali"},
    {"locale": "ta", "name": "தமிழ்", "englishText": "Tamil"},
    {"locale": "or", "name": "ଓଡ଼ିଆ", "englishText": "Odia"},
  ];

  //TITLE
  static const String TITLE_PREFERRED_LANGUAGE = "Choose Your Preferred Language";
  static const String TITLE_SELECT_LANGUAGE = "Please select your language";

  //KEY
  final String KEY_PREFERRED_LANGUAGE = "key_preferred_language";
  final String KEY_SELECT_LANGUAGE = "key_select_language";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitleType: CustomAppBarTitleType.HORIZONTAL_APP_ICON,
        hasLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.kAppPadding),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SpaceWidget(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  TITLE_PREFERRED_LANGUAGE,
                  key: Key(KEY_PREFERRED_LANGUAGE),
                  style: AppStyles.headlineMedium.copyWith(color: AppColorScheme.kGrayColor, fontWeight: FontWeight.w700, fontFamily: AppConstant.FONT_FAMILY),
                ),
              ),
            ],
          ),
          const SpaceWidget(
            height: 10,
          ),
          Text(
            TITLE_SELECT_LANGUAGE,
            key: Key(KEY_SELECT_LANGUAGE),
            style: AppStyles.titleSmall.copyWith(color: AppColorScheme.kGrayColor.shade700, fontFamily: AppConstant.FONT_FAMILY),
          ),
          const SpaceWidget(
            height: 30,
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20, childAspectRatio: 1 / 0.4),
                itemCount: languages.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = languages[index];

                  return GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: CustomLanguageCardWidget(
                        cardTile: item['name']!,
                        cardTitleKey: "key_language_${item['name']}",
                        widgetKey: "Key_${item['name']}card_widget",
                      ),
                    ),
                  );
                }),
          ),
          const SpaceWidget(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryFilledButton(
              buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
              buttonTitle: AppConstant.CONTINUE_BUTTON_TITLE,
              widgetKey: AppConstant.KEY_BUTTON_CONTINUE,
              isLoading: false,
              onPressed: () {},
            ),
          ),
        ]),
      ),
    );
  }
}
