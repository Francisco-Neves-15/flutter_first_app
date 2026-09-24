import "package:flutter_first_app/docs/models.dart" show BadUsageMessage;

class BadUsagesAppButton {
  static const _prefix = "badUsage-widgets-ui-button";
  static const _owner = "Button";

  static const e001 = BadUsageMessage(
    id: "e001",
    prefix: _prefix,
    owner: _owner,
    message: '<! "{required Widget child}" when using "type: AppButtonType.text" !>',
  );

}