import "package:flutter_first_app/docs/models.dart" show BadUsageMessage;

class BadUsagesBottomsheets {
  static const _prefix = "badUsage-widgets-ui-bottomsheets";
  static const _owner = "Bottomsheets";

  static const e001 = BadUsageMessage(
    id: "e001",
    prefix: _prefix,
    owner: _owner,
    message:
      'To display the divider on the dismiss button, the "dismissLocation" property must be set to "bottom". '
      'WHY > There is no divider if the location is in the BottomsheetContainer header.'
      'TIP > When "dismissLocation = .bottom", you can use "showDismissButton = true" or "false"; However, when "dismissLocation = .header", "showDismissButton" can never be "true" — only "false";'
    ,
  );

}