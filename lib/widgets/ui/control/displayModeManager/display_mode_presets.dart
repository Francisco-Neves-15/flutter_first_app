import 'package:flutter/material.dart' show Icon;
import 'package:material_symbols_icons/symbols.dart' show Symbols;
import 'package:flutter_first_app/widgets/ui/control/displayModeManager/display_mode_manage_option.dart' show DisplayModeOption;

enum DisplayModes { fallback, list, grid, listGrid }

List<DisplayModeOption<ViewMode>> fallback<ViewMode>({
  required ViewMode square,
  required ViewMode circle,
}) {
  return [
    DisplayModeOption<ViewMode>(
      value: square,
      activeIcon: Icon(Symbols.square_rounded, size: 20, fill: 1),
      inactiveIcon: Icon(Symbols.square_rounded, size: 20, fill: 0),
      label: "Square",
    ),
    DisplayModeOption<ViewMode>(
      value: circle,
      activeIcon: Icon(Symbols.circle_rounded, size: 20, fill: 1),
      inactiveIcon: Icon(Symbols.circle_rounded, size: 20, fill: 0),
      label: "Circle",
    ),
  ];
}

List<DisplayModeOption<ViewMode>> list<ViewMode>({
  required ViewMode compact,
  required ViewMode wide,
}) {
  return [
    DisplayModeOption<ViewMode>(
      value: compact,
      activeIcon: Icon(Symbols.view_agenda_rounded, size: 20, fill: 1),
      inactiveIcon: Icon(Symbols.view_agenda_rounded, size: 20, fill: 0),
      label: "Compact",
    ),
    DisplayModeOption<ViewMode>(
      value: wide,
      activeIcon: Icon(Symbols.table_rows_rounded, size: 20, fill: 1),
      inactiveIcon: Icon(Symbols.table_rows_rounded, size: 20, fill: 0),
      label: "Wide",
    ),
  ];
}

List<DisplayModeOption<ViewMode>> grid<ViewMode>({
  required ViewMode compact,
  required ViewMode wide,
}) {
  return [
    DisplayModeOption<ViewMode>(
      value: compact,
      activeIcon: Icon(Symbols.grid_view_rounded, size: 20, fill: 1),
      inactiveIcon: Icon(Symbols.grid_view_rounded, size: 20, fill: 0),
      label: "Compact",
    ),
    DisplayModeOption<ViewMode>(
      value: wide,
      activeIcon: Icon(Symbols.grid_on_rounded, size: 20, fill: 1),
      inactiveIcon: Icon(Symbols.grid_on_rounded, size: 20, fill: 0),
      label: "Wide",
    ),
  ];
}

List<DisplayModeOption<ViewMode>> listGrid<ViewMode>({
  required ViewMode list,
  required ViewMode grid,
}) {
  return [
    DisplayModeOption<ViewMode>(
      value: list,
      activeIcon: Icon(Symbols.view_agenda_rounded, size: 20, fill: 1),
      inactiveIcon: Icon(Symbols.view_agenda_rounded, size: 20, fill: 0),
      label: "List",
    ),
    DisplayModeOption<ViewMode>(
      value: grid,
      activeIcon: Icon(Symbols.grid_view, size: 20, fill: 1),
      inactiveIcon: Icon(Symbols.grid_view, size: 20, fill: 0),
      label: "Grid",
    ),
  ];
}
