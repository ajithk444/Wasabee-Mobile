import 'package:wasabee/classutils/target.dart';
import 'package:wasabee/network/responses/operationFullResponse.dart';

class MarkerUtilities {
  static const SEGMENT_MARKER = "wasabee_markers_";
  static const SEGMENT_ICON = "wasabee_icons_";
  static const SEGMENT_FILE_EXT = ".bmp";

  static String getImagePath(
      Target target, String googleId, String baseSegment) {
    var typePathSegment = "other_";
    switch (target.type) {
      case TargetUtils.LetDecayPortalAlert:
        typePathSegment = "decay_";
        break;
      case TargetUtils.DestroyPortalAlert:
        typePathSegment = "destroy_";
        break;
      case TargetUtils.UseVirusPortalAlert:
        typePathSegment = "virus_";
        break;
    }
    var statusPathSegment = getTargetStatusSegment(target, googleId);
    return "$baseSegment$typePathSegment$statusPathSegment$SEGMENT_FILE_EXT";
  }

  static String getTargetStatusSegment(Target target, String googleId) {
    var targetStatus = "pending";
    switch (target.state) {
      case "pending":
        break;
      case "assigned":
        if (googleId != null && target.assignedTo == googleId) {
          targetStatus = "${target.state}_yours";
        } else
          targetStatus = target.state;
        break;
      case "acknowledged":
        targetStatus = "acknowledge";
        break;
      case "completed":
        targetStatus = "done";
        break;
    }
    return targetStatus;
  }
}
