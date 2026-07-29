
/// All Directions & Positions
enum AppAxis { top, bottom, left, right, up, down, start, end }

/// Directions
enum AppAxisDirection { up, down, start, end }
/// Vertical Directions
enum AppAxisDirectionVertical { up, down }
/// Horizontal Directions
enum AppAxisDirectionHorizontal { start, end }

/// Positions
enum AppAxisPosition { top, bottom, left, right }
/// Vertical Positions
enum AppAxisPositionVertical { top, bottom }
/// Horizontal Positions
enum AppAxisPositionHorizontal { left, right }

/// N - E - S - W
enum AppCardinalDirections {
  north,
  east,
  south,
  west
}

/// N - NE - E - SE - S - SW - W - NW
enum AppIntercardinalDirections {
  north,
  northeast,
  east,
  southeast,
  south,
  southwest,
  west,
  northwest,
}

/// N - NNE - NE - ENE - E - ESE - SE - SSE - S - SSW - SW - WSW - W - WNW - NW - NNW
enum AppSecondaryIntercardinalDirections {
  north,
  northNortheast,
  northeast,
  eastNortheast,
  east,
  eastSoutheast,
  southeast,
  southSoutheast,
  south,
  southSouthwest,
  southwest,
  westSouthwest,
  west,
  westNorthwest,
  northwest,
  northNorthwest,
}
