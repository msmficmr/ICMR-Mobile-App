import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/enums.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// if app bar don't have leading widget then set [hasLeading] parameter to `false` default value is `true`
  final bool hasLeading;

  /// pass callback to perform action on leading widget
  final Function()? onLeadingClick;

  /// if you want to customize leading widget pass [leading] as a parameter. default is back icon
  final Widget? leading;

  /// if you want to set title to the center default value is true
  final bool centerTitle;

  /// title widget for appbar default will be app icon
  final Widget? titleWidget;

  /// widget type for title . default is set to [CustomAppBarTitleType.APP_ICON]
  /// [CustomAppBarTitleType.APP_ICON] it will display default app icon
  /// [CustomAppBarTitleType.WIDGET] it will display then widget passed to [titleWidget]. [titleWidget] is required parameter
  /// [CustomAppBarTitleType.TEXT] it will display the text passed to [titleText]. [titleText] is required parameter
  final CustomAppBarTitleType appBarTitleType;

  /// [titleText] is used to set title as string
  final String? titleText;

  /// trailing widget for appbar default will be null
  final Widget? trailingWidget;
  final List<Widget>? trailingWidgetList;

  /// [trailingWidgetKey] is assigned to Inkwell of Trailing Widget so that it can used for automation
  final Key? trailingWidgetKey;

  /// widget type for trailing default is set to [CustomAppBarTrailingType.NONE]
  /// if [trailingType] is set to [CustomAppBarTrailingType.SINGLE] then pass [trailingWidget]
  /// if [trailingType] is set to [CustomAppBarTrailingType.MULTIPLE] then pass [trailingWidgetList]. make sure width of widget must be [kToolbarHeight]
  final CustomAppBarTrailingType trailingType;

  final Function()? onTrailingClick;

  static _getTrailingWidgetAssert(Function()? onClick, Key? widgetKey, CustomAppBarTrailingType trailingType, List<Widget>? trailingWidgetList, Widget? trailingWidget) {
    switch (trailingType) {
      case CustomAppBarTrailingType.NONE:
        if (onClick != null || widgetKey != null || trailingWidgetList != null || trailingWidget != null) {
          throw Exception("trailingType is set to NONE no need to pass onTrailingClick || trailingWidgetKey || trailingWidget || trailingWidgetList");
        }
      case CustomAppBarTrailingType.SINGLE:
        if (onClick != null && widgetKey == null) {
          throw Exception("Trailing action is set please add trailingWidgetKey");
        }
        if (trailingWidget == null) {
          throw Exception("trailingType is set to SINGLE please pass trailingWidget");
        }
      case CustomAppBarTrailingType.MULTIPLE:
        if (onClick != null || widgetKey != null || trailingWidget != null) {
          throw Exception("trailingType is set to MULTIPLE no need to pass onTrailingClick || trailingWidgetKey || trailingWidget");
        }
        if (trailingWidgetList == null) {
          throw Exception("trailingType is set to MULTIPLE please pass trailingWidgetList");
        }
    }
    return true;
  }

  static _getTitleWidgetAssert(CustomAppBarTitleType appBarTitleType, String? titleText, Widget? widget) {
    switch (appBarTitleType) {
      case CustomAppBarTitleType.HORIZONTAL_APP_ICON:
      case CustomAppBarTitleType.APP_ICON:
        return true;
      case CustomAppBarTitleType.TEXT:
        if (titleText == null) {
          throw Exception("appBarTitleType is set as TEXT. so titleText is required");
        }
        return true;
      case CustomAppBarTitleType.WIDGET:
        if (widget == null) {
          throw Exception("appBarTitleType is set as WIDGET. so titleWidget is required");
        }
        return true;
    }
  }

  final Color? backgroundColor;

  CustomAppBar({
    super.key,
    this.onTrailingClick,
    this.leading,
    this.titleWidget,
    this.trailingWidget,
    this.trailingWidgetKey,
    this.onLeadingClick,
    this.titleText,
    this.trailingWidgetList,
    this.backgroundColor,
    this.trailingType = CustomAppBarTrailingType.NONE,
    this.centerTitle = true,
    this.hasLeading = true,
    this.appBarTitleType = CustomAppBarTitleType.TEXT,
  })  : assert(_getTrailingWidgetAssert(onTrailingClick, trailingWidgetKey, trailingType, trailingWidgetList, trailingWidget)),
        assert(_getTitleWidgetAssert(appBarTitleType, titleText, titleWidget));

  Widget getTitleWidget() {
    switch (appBarTitleType) {
      case CustomAppBarTitleType.TEXT:
        return Text(
          titleText ?? "",
          style: AppStyles.appBarStyle,
        );
      case CustomAppBarTitleType.WIDGET:
        return titleWidget ?? const SizedBox.shrink();
      case CustomAppBarTitleType.HORIZONTAL_APP_ICON:
        return SvgPicture.asset(
          AppAssetsPath.appHorizontalIcon,
        );
      case CustomAppBarTitleType.APP_ICON:
      default:
        return SvgPicture.asset(
          AppAssetsPath.appIcon,
          height: 30,
        );
    }
  }

  List<Widget>? getTrailingWidget() {
    switch (trailingType) {
      case CustomAppBarTrailingType.NONE:
        return null;
      case CustomAppBarTrailingType.SINGLE:
        return [
          InkWell(
            key: trailingWidgetKey,
            onTap: onTrailingClick,
            child: Center(
              child: SizedBox(
                width: kToolbarHeight,
                height: kToolbarHeight,
                child: Center(
                  child: trailingWidget!,
                ),
              ),
            ),
          ),
        ];
      case CustomAppBarTrailingType.MULTIPLE:
        return trailingWidgetList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      leading: !hasLeading
          ? null
          : InkWell(
              key: const Key("key_appbar_leading"),
              onTap: onLeadingClick,
              child: leading ??
                  Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: SvgPicture.asset(
                        AppAssetsPath.icArrowBack,
                      ),
                    ),
                  ),
            ),
      centerTitle: centerTitle,
      title: Padding(
        padding: (hasLeading || centerTitle) ? EdgeInsets.zero : const EdgeInsets.only(left: 16),
        child: getTitleWidget(),
      ),
      actions: getTrailingWidget(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
