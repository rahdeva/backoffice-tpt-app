/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $LibGen {
  const $LibGen();

  $LibResourcesGen get resources => const $LibResourcesGen();
}

class $LibResourcesGen {
  const $LibResourcesGen();

  $LibResourcesImagesGen get images => const $LibResourcesImagesGen();
}

class $LibResourcesImagesGen {
  const $LibResourcesImagesGen();

  /// File path: lib/resources/images/empty_state_code.png
  AssetGenImage get emptyStateCode =>
      const AssetGenImage('lib/resources/images/empty_state_code.png');

  /// File path: lib/resources/images/ic_activity_active.png
  AssetGenImage get icActivityActive =>
      const AssetGenImage('lib/resources/images/ic_activity_active.png');

  /// File path: lib/resources/images/ic_activity_unactive.png
  AssetGenImage get icActivityUnactive =>
      const AssetGenImage('lib/resources/images/ic_activity_unactive.png');

  /// File path: lib/resources/images/ic_home_active.png
  AssetGenImage get icHomeActive =>
      const AssetGenImage('lib/resources/images/ic_home_active.png');

  /// File path: lib/resources/images/ic_home_unactive.png
  AssetGenImage get icHomeUnactive =>
      const AssetGenImage('lib/resources/images/ic_home_unactive.png');

  /// File path: lib/resources/images/ic_logo_suitcore_main.png
  AssetGenImage get icLogoSuitcoreMain =>
      const AssetGenImage('lib/resources/images/ic_logo_suitcore_main.png');

  /// File path: lib/resources/images/ic_notif_active.png
  AssetGenImage get icNotifActive =>
      const AssetGenImage('lib/resources/images/ic_notif_active.png');

  /// File path: lib/resources/images/ic_notif_unactive.png
  AssetGenImage get icNotifUnactive =>
      const AssetGenImage('lib/resources/images/ic_notif_unactive.png');

  /// File path: lib/resources/images/ic_profile_active.png
  AssetGenImage get icProfileActive =>
      const AssetGenImage('lib/resources/images/ic_profile_active.png');

  /// File path: lib/resources/images/ic_profile_unactive.png
  AssetGenImage get icProfileUnactive =>
      const AssetGenImage('lib/resources/images/ic_profile_unactive.png');

  /// File path: lib/resources/images/img_empty.png
  AssetGenImage get imgEmpty =>
      const AssetGenImage('lib/resources/images/img_empty.png');

  /// File path: lib/resources/images/img_error.png
  AssetGenImage get imgError =>
      const AssetGenImage('lib/resources/images/img_error.png');

  /// File path: lib/resources/images/user_placeholder.png
  AssetGenImage get userPlaceholder =>
      const AssetGenImage('lib/resources/images/user_placeholder.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        emptyStateCode,
        icActivityActive,
        icActivityUnactive,
        icHomeActive,
        icHomeUnactive,
        icLogoSuitcoreMain,
        icNotifActive,
        icNotifUnactive,
        icProfileActive,
        icProfileUnactive,
        imgEmpty,
        imgError,
        userPlaceholder
      ];
}

class Assets {
  Assets._();

  static const $LibGen lib = $LibGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
