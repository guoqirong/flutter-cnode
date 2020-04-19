import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:common_utils/common_utils.dart';

class ImageUtil {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getImgSvgPath(String name, {String format: 'svg'}) {
    return 'assets/icons/svg/icon-$name.$format';
  }

  static ImageProvider getImageProvider(
    String image, {
    String format: 'png',
    String holderImg: "none",
  }) {
    if (TextUtil.isEmpty(image) || image == "null") {
      return AssetImage(getImgPath(holderImg));
    } else {
      if (image.startsWith("http")) {
        return CachedNetworkImageProvider(image);
      } else {
        return AssetImage(getImgPath(image, format: format));
      }
    }
  }
}
