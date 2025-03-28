import 'package:flutter/material.dart';
import 'package:plateau/bootstrap/extensions.dart';
import '/resources/themes/styles/color_styles.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* Helpers
|--------------------------------------------------------------------------
| Add your helper methods here
|-------------------------------------------------------------------------- */

/// helper to find correct color from the [context].
class ThemeColor {
  static ColorStyles get(BuildContext context, {String? themeId}) =>
      nyColorStyle<ColorStyles>(context, themeId: themeId);

  static Color fromHex(String hexColor) => nyHexColor(hexColor);
}

class ImagePlaceholder {
  static String get(String? image, int width, int height,
      {String? text,
      Color? backgroundColor = Colors.pinkAccent,
      Color? textColor = Colors.blueAccent}) {
    if (image == null || image.isEmpty) {
      var url =
          "https://placehold.co/${width}x${height}/${backgroundColor?.toHex()}/${textColor?.toHex()}/png?text=${text}";
      return url;
    }
    return image;
  }
}
