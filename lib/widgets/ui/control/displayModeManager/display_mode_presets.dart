import "package:flutter/material.dart" show Icon;
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/widgets/ui/control/displayModeManager/models.dart" show DisplayModeOption;

final double defaultIconSize = 20;

class DisplayModePresets {

  static List<DisplayModeOption<ViewMode>> fallback<ViewMode>({
    required ViewMode square,
    required ViewMode circle,
    final double? iconSize
  }) {
    return [
      DisplayModeOption<ViewMode>(
        value: square,
        activeIcon: Icon(Symbols.square_rounded, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.square_rounded, size: iconSize ?? defaultIconSize, fill: 0),
        label: "Square",
      ),
      DisplayModeOption<ViewMode>(
        value: circle,
        activeIcon: Icon(Symbols.circle_rounded, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.circle_rounded, size: iconSize ?? defaultIconSize, fill: 0),
        label: "Circle",
      ),
    ];
  }

  static List<DisplayModeOption<ViewMode>> list<ViewMode>({
    required ViewMode compact,
    required ViewMode wide,
    final double? iconSize
  }) {
    return [
      DisplayModeOption<ViewMode>(
        value: compact,
        activeIcon: Icon(Symbols.view_agenda_rounded, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.view_agenda_rounded, size: iconSize ?? defaultIconSize, fill: 0),
        label: "Compact",
      ),
      DisplayModeOption<ViewMode>(
        value: wide,
        activeIcon: Icon(Symbols.table_rows_rounded, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.table_rows_rounded, size: iconSize ?? defaultIconSize, fill: 0),
        label: "Wide",
      ),
    ];
  }

  static List<DisplayModeOption<ViewMode>> grid<ViewMode>({
    required ViewMode compact,
    required ViewMode wide,
    final double? iconSize
  }) {
    return [
      DisplayModeOption<ViewMode>(
        value: compact,
        activeIcon: Icon(Symbols.grid_view_rounded, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.grid_view_rounded, size: iconSize ?? defaultIconSize, fill: 0),
        label: "Compact",
      ),
      DisplayModeOption<ViewMode>(
        value: wide,
        activeIcon: Icon(Symbols.grid_on_rounded, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.grid_on_rounded, size: iconSize ?? defaultIconSize, fill: 0),
        label: "Wide",
      ),
    ];
  }

  static List<DisplayModeOption<ViewMode>> listGrid<ViewMode>({
    required ViewMode list,
    required ViewMode grid,
    final double? iconSize
  }) {
    return [
      DisplayModeOption<ViewMode>(
        value: list,
        activeIcon: Icon(Symbols.view_agenda_rounded, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.view_agenda_rounded, size: iconSize ?? defaultIconSize, fill: 0),
        label: "List",
      ),
      DisplayModeOption<ViewMode>(
        value: grid,
        activeIcon: Icon(Symbols.grid_view, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.grid_view, size: iconSize ?? defaultIconSize, fill: 0),
        label: "Grid",
      ),
    ];
  }

  static List<DisplayModeOption<ViewMode>> allListGrid<ViewMode>({
    required ViewMode listCompact,
    required ViewMode listWide,
    required ViewMode gridCompact,
    required ViewMode gridWide,
    final double? iconSize
  }) {
    return [
      DisplayModeOption<ViewMode>(
        value: listCompact,
        activeIcon: Icon(Symbols.view_agenda_rounded, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.view_agenda_rounded, size: iconSize ?? defaultIconSize, fill: 0),
        label: "List (Compact)",
      ),
      DisplayModeOption<ViewMode>(
        value: listWide,
        activeIcon: Icon(Symbols.table_rows_rounded, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.table_rows_rounded, size: iconSize ?? defaultIconSize, fill: 0),
        label: "List (Wide)",
      ),
      DisplayModeOption<ViewMode>(
        value: gridCompact,
        activeIcon: Icon(Symbols.grid_view_rounded, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.grid_view_rounded, size: iconSize ?? defaultIconSize, fill: 0),
        label: "Grid (Compact)",
      ),
      DisplayModeOption<ViewMode>(
        value: gridWide,
        activeIcon: Icon(Symbols.grid_on_rounded, size: iconSize ?? defaultIconSize, fill: 1),
        inactiveIcon: Icon(Symbols.grid_on_rounded, size: iconSize ?? defaultIconSize, fill: 0),
        label: "Grid (Wide)",
      ),
    ];
  }

}
