import "package:flutter_first_app/docs/models.dart" show BadUsageMessage;

class BadUsagesLayoutWidgets {
  static const _prefix = "badUsage-widgets-ui-layoutWidgets";
  static const _owner = "LayoutWidgets";

  static const e001 = BadUsageMessage(
    id: "e001",
    prefix: _prefix,
    owner: _owner,
    message:
      "AppScaffold: The menuButton is enabled and configured to appear in the interface, "
      "but since the sideMenu is disabled, it will not open upon interaction with the button."
    ,
  );

}