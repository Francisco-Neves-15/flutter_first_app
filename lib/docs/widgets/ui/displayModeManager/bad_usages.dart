import "package:flutter_first_app/docs/models.dart" show BadUsageMessage;

class BadUsagesDisplayModeManager {
  static const _prefix = "badUsage-widgets-ui-displayModeManager";
  static const _owner = "DisplayModeManager";

  static const e001 = BadUsageMessage(
    id: "e001",
    prefix: _prefix,
    owner: _owner,
    message: "DisplayModeManager needs to display an icon or label.",
  );

  static const e002 = BadUsageMessage(
    id: "e002",
    prefix: _prefix,
    owner: _owner,
    message:
      "The selected icon (showSelectedIcon) cannot replace the main icon when no label is displayed. "
      "WHY > This is a limitation of Flutter's Material SegmentedButton: the selected icon is "
      "implemented as a selection indicator, not as a replacement for the segment icon. "
      "Without a label, this configuration cannot produce the intended result. "
      "Consider enabling showLabel or disabling selectedIconReplaceMainIcon. "
      "TIP > Keeping both the main icon and the selected indicator visible is also the "
      "recommended Material Design behavior, as it provides a clearer selection state."
    ,
  );

  static const e003 = BadUsageMessage(
    id: "e003",
    prefix: _prefix,
    owner: _owner,
    message: "There is no selected icon (showSelectedIcon) to replace the main icon (showIcon).",
  );

  static const e004 = BadUsageMessage(
    id: "e004",
    prefix: _prefix,
    owner: _owner,
    message: "There is no main icon (showIcon) to be replaced by the selected icon (selectedIconReplaceMainIcon).",
  );

}