import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static Widget verticalSpacer(double multiplier) {
    return SizedBox(
      height: blockSizeVertical * multiplier,
    );
  }

  static Widget horizontalSpacer(double multiplier) {
    return SizedBox(
      width: blockSizeHorizontal * multiplier,
    );
  }

  static double relativeHeight(double multiplier) {
    return blockSizeVertical * multiplier;
  }

  static double relativeWidth(double multiplier) {
    return blockSizeHorizontal * multiplier;
  }

  static double relativeSize(double multiplier) {
    return (blockSizeVertical / blockSizeHorizontal) * multiplier;
  }

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    //screenHeight = safeAreaBox.maxHeight;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
/*
    print('V block size : $blockSizeVertical');
    print('H block size : $blockSizeHorizontal');
    print('Full Height : $screenHeight');
    print('safeAreaBox Height : ${safeAreaBox.maxHeight}');*/

    _textScaleFactor = _mediaQueryData.textScaleFactor;
  }

  static double _textScaleFactor;
  static num uiWidthPx = 375;
  static num uiHeightPx = 812;
  static bool allowFontScaling = true;

  static double get scaleWidth => screenWidth / uiWidthPx;

  static double get scaleHeight => screenHeight / uiHeightPx;

  static double get scaleText => scaleWidth;

  static num setSp(num fontSize, {bool allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? (allowFontScaling
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor))
          : (allowFontScalingSelf
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor));
}
