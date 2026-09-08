// import "package:flutter/material.dart";
import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";

// ===== Icon List =====

enum AppIconType {
  // Common
  check,
  close,
  back,
  plus,
  minus,
  confirm,
  deny,
  // Arrow's
  arrowUp,
  arrowDown,
  arrowLeft,
  arrowRight,
  chevronUp,
  chevronDown,
  chevronLeft,
  chevronRight,
  // UI
  add,
  remove,
  discard,
}

// ===== Icon Source =====

extension AppIconExtension on AppIconType { 
  IconData get iconData {
    return switch (this) {

      // Common

      AppIconType.check => Symbols.check_rounded,
      AppIconType.close => Symbols.close_rounded,

      AppIconType.back => Symbols.arrow_back_rounded,

      AppIconType.plus => Symbols.add_rounded,
      AppIconType.minus => Symbols.remove_rounded,

      AppIconType.confirm => Symbols.check_rounded,
      AppIconType.deny => Symbols.close_rounded,

      // Arrow's

      AppIconType.arrowUp => Symbols.arrow_upward_rounded,
      AppIconType.arrowDown => Symbols.arrow_downward_rounded,
      AppIconType.arrowLeft => Symbols.arrow_back_rounded,
      AppIconType.arrowRight => Symbols.arrow_forward_rounded,

      AppIconType.chevronUp => Symbols.keyboard_arrow_up_rounded,
      AppIconType.chevronDown => Symbols.keyboard_arrow_down_rounded,
      AppIconType.chevronLeft => Symbols.chevron_left_rounded,
      AppIconType.chevronRight => Symbols.chevron_right_rounded,

      // UI

      AppIconType.add => Symbols.add_rounded,
      AppIconType.remove => Symbols.remove_rounded,
      AppIconType.discard => Symbols.delete_outline_rounded,

    };
  }
}

// ===== Icon Class =====

class AppIcons {
  const AppIcons._();

  // Common

  static IconData get check => AppIconType.check.iconData;
  static IconData get close => AppIconType.close.iconData;
  static IconData get back => AppIconType.back.iconData;

  static IconData get plus => AppIconType.plus.iconData;
  static IconData get minus => AppIconType.minus.iconData;

  static IconData get confirm => AppIconType.confirm.iconData;
  static IconData get deny => AppIconType.deny.iconData;

  // Arrow's

  static IconData get arrowUp => AppIconType.arrowUp.iconData;
  static IconData get arrowDown => AppIconType.arrowDown.iconData;
  static IconData get arrowLeft => AppIconType.arrowLeft.iconData;
  static IconData get arrowRight => AppIconType.arrowRight.iconData;

  static IconData get chevronUp => AppIconType.chevronUp.iconData;
  static IconData get chevronDown => AppIconType.chevronDown.iconData;
  static IconData get chevronLeft => AppIconType.chevronLeft.iconData;
  static IconData get chevronRight => AppIconType.chevronRight.iconData;

  // UI

  static IconData get add => AppIconType.add.iconData;
  static IconData get remove => AppIconType.remove.iconData;
  static IconData get discard => AppIconType.discard.iconData;

}
