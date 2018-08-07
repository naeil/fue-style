

import 'dart:collection';

import 'package:collection/collection.dart';

_camelCase(String str){
  return str.replaceAllMapped(new RegExp(r"-([a-z])"), (Match m)=>m[1].toUpperCase());
}

_dashCase(String str){
  return str.replaceAllMapped(new RegExp(r"[A-Z]"), (Match m)=>"-" + m[0].toLowerCase());
}


String _numAs2DigitHex(num v) {
  // TODO(terry): v.toInt().toRadixString instead of v.toRadixString
  //              Bug <http://code.google.com/p/dart/issues/detail?id=2671>.
  String hex = v.toInt().toRadixString(16);
  if (hex.length == 1) {
    hex = "0${hex}";
  }
  return hex;
}


String _colorToHex(r,g,b,a){
  return "#" +_numAs2DigitHex(a * 255) 
  + _numAs2DigitHex(r)
  + _numAs2DigitHex(g)
  + _numAs2DigitHex(b)
  ; 
}


class CSSValue{ 
  final value;
  const CSSValue(this.value); 

  clone() => new CSSValue(this.value);

  @override
  toString(){
    return value.toString();
  }

}



class CSSUnit{
  static const CSSUnit px = const CSSUnit("px");
  static const CSSUnit pt = const CSSUnit("pt");
  static const CSSUnit percent = const CSSUnit("%");

  static get(String v){
    switch(v){
      case "px" : return px;
      case "pt" : return pt;
      case "%" : return percent;
    }
    return pt;
  }


  final String type;
  const CSSUnit([this.type = "px"]);

  @override
  toString()=>type;
}



class CSSList extends CSSValue with ListMixin<CSSValue>{

  CSSList() : super(<CSSValue>[]);
  
  @override
  int get length { return value.length; }

  @override
  set length(int newLength) {
    value.length = newLength;
  }
  
  @override
  CSSValue operator [](int index) {
    return value[index];
  }

  @override
  void operator []=(int index, CSSValue value) {
    this.value[index] = value;
  }

  @override
  toString(){
    return value.join(', ');
  }
}

class CSSSize extends CSSValue{

  final CSSUnit unit;

  CSSSize([value = 0, this.unit = CSSUnit.px]):super(value);

  @override clone() => new CSSSize(value, unit);

  @override operator == (rhs)=>this.value == rhs.value;
  @override get hashCode=>this.value.hashCode;

  @override toString(){
    return '$value$unit';
  }
}

class CSSString extends CSSValue{
  CSSString([value = ""]):super(value);

  @override clone() => new CSSString(value);
}

class CSSUrl extends CSSValue{
  CSSUrl([value = ""]):super(value);

  @override clone() => new CSSUrl(value);

  @override toString(){
    return 'url("$value")';
  }
}


class CSSColor extends CSSValue{
  CSSColor([value = 0]) : super(value);

  @override clone() => new CSSColor(value);

  @override operator == (rhs)=>this.value == rhs.value;
  @override get hashCode=>this.value.hashCode;

  @override toString(){

    return _colorToHex(
      ((value & 0xff0000) >> 0x10), // r
      ((value & 0xff00) >> 8), // g
      ((value & 0xff)), // b
      ((value & 0xff000000) >> 0x18) / 255, // a
    );
  }
}


class CSSIdentify extends CSSValue{
  const CSSIdentify(value):super(value);

  static get(String text){
    switch(_camelCase(text.toLowerCase())){
      case "inherit" : return CSSInheritIdentify.get();
      case "initial" : return CSSInitialIdentify.get();
      case "none" : return CSSNoneIdentify.get();
      case "hidden" : return CSSHiddenIdentify.get();
      case "inset" : return CSSInsetIdentify.get();
      case "groove" : return CSSGrooveIdentify.get();
      case "outset" : return CSSOutsetIdentify.get();
      case "ridge" : return CSSRidgeIdentify.get();
      case "dotted" : return CSSDottedIdentify.get();
      case "dashed" : return CSSDashedIdentify.get();
      case "solid" : return CSSSolidIdentify.get();
      case "double" : return CSSDoubleIdentify.get();
      case "caption" : return CSSCaptionIdentify.get();
      case "icon" : return CSSIconIdentify.get();
      case "menu" : return CSSMenuIdentify.get();
      case "messageBox" : return CSSMessageBoxIdentify.get();
      case "smallCaption" : return CSSSmallCaptionIdentify.get();
      case "WebkitMiniControl" : return CSSWebkitMiniControlIdentify.get();
      case "WebkitSmallControl" : return CSSWebkitSmallControlIdentify.get();
      case "WebkitControl" : return CSSWebkitControlIdentify.get();
      case "statusBar" : return CSSStatusBarIdentify.get();
      case "italic" : return CSSItalicIdentify.get();
      case "oblique" : return CSSObliqueIdentify.get();
      case "all" : return CSSAllIdentify.get();
      case "commonLigatures" : return CSSCommonLigaturesIdentify.get();
      case "noCommonLigatures" : return CSSNoCommonLigaturesIdentify.get();
      case "discretionaryLigatures" : return CSSDiscretionaryLigaturesIdentify.get();
      case "noDiscretionaryLigatures" : return CSSNoDiscretionaryLigaturesIdentify.get();
      case "historicalLigatures" : return CSSHistoricalLigaturesIdentify.get();
      case "noHistoricalLigatures" : return CSSNoHistoricalLigaturesIdentify.get();
      case "contextual" : return CSSContextualIdentify.get();
      case "noContextual" : return CSSNoContextualIdentify.get();
      case "smallCaps" : return CSSSmallCapsIdentify.get();
      case "allSmallCaps" : return CSSAllSmallCapsIdentify.get();
      case "petiteCaps" : return CSSPetiteCapsIdentify.get();
      case "allPetiteCaps" : return CSSAllPetiteCapsIdentify.get();
      case "unicase" : return CSSUnicaseIdentify.get();
      case "titlingCaps" : return CSSTitlingCapsIdentify.get();
      case "jis78" : return CSSJis78Identify.get();
      case "jis83" : return CSSJis83Identify.get();
      case "jis90" : return CSSJis90Identify.get();
      case "jis04" : return CSSJis04Identify.get();
      case "simplified" : return CSSSimplifiedIdentify.get();
      case "traditional" : return CSSTraditionalIdentify.get();
      case "fullWidth" : return CSSFullWidthIdentify.get();
      case "proportionalWidth" : return CSSProportionalWidthIdentify.get();
      case "ruby" : return CSSRubyIdentify.get();
      case "liningNums" : return CSSLiningNumsIdentify.get();
      case "oldstyleNums" : return CSSOldstyleNumsIdentify.get();
      case "proportionalNums" : return CSSProportionalNumsIdentify.get();
      case "tabularNums" : return CSSTabularNumsIdentify.get();
      case "diagonalFractions" : return CSSDiagonalFractionsIdentify.get();
      case "stackedFractions" : return CSSStackedFractionsIdentify.get();
      case "ordinal" : return CSSOrdinalIdentify.get();
      case "slashedZero" : return CSSSlashedZeroIdentify.get();
      case "normal" : return CSSNormalIdentify.get();
      case "bold" : return CSSBoldIdentify.get();
      case "bolder" : return CSSBolderIdentify.get();
      case "lighter" : return CSSLighterIdentify.get();
      case "ultraCondensed" : return CSSUltraCondensedIdentify.get();
      case "extraCondensed" : return CSSExtraCondensedIdentify.get();
      case "condensed" : return CSSCondensedIdentify.get();
      case "semiCondensed" : return CSSSemiCondensedIdentify.get();
      case "semiExpanded" : return CSSSemiExpandedIdentify.get();
      case "expanded" : return CSSExpandedIdentify.get();
      case "extraExpanded" : return CSSExtraExpandedIdentify.get();
      case "ultraExpanded" : return CSSUltraExpandedIdentify.get();
      case "xxSmall" : return CSSXxSmallIdentify.get();
      case "xSmall" : return CSSXSmallIdentify.get();
      case "small" : return CSSSmallIdentify.get();
      case "medium" : return CSSMediumIdentify.get();
      case "large" : return CSSLargeIdentify.get();
      case "xLarge" : return CSSXLargeIdentify.get();
      case "xxLarge" : return CSSXxLargeIdentify.get();
      case "WebkitXxxLarge" : return CSSWebkitXxxLargeIdentify.get();
      case "smaller" : return CSSSmallerIdentify.get();
      case "larger" : return CSSLargerIdentify.get();
      case "serif" : return CSSSerifIdentify.get();
      case "sansSerif" : return CSSSansSerifIdentify.get();
      case "cursive" : return CSSCursiveIdentify.get();
      case "fantasy" : return CSSFantasyIdentify.get();
      case "monospace" : return CSSMonospaceIdentify.get();
      case "WebkitBody" : return CSSWebkitBodyIdentify.get();
      case "WebkitPictograph" : return CSSWebkitPictographIdentify.get();
      case "swap" : return CSSSwapIdentify.get();
      case "fallback" : return CSSFallbackIdentify.get();
      case "optional" : return CSSOptionalIdentify.get();
      case "aqua" : return CSSAquaIdentify.get();
      case "black" : return CSSBlackIdentify.get();
      case "blue" : return CSSBlueIdentify.get();
      case "fuchsia" : return CSSFuchsiaIdentify.get();
      case "gray" : return CSSGrayIdentify.get();
      case "green" : return CSSGreenIdentify.get();
      case "lime" : return CSSLimeIdentify.get();
      case "maroon" : return CSSMaroonIdentify.get();
      case "navy" : return CSSNavyIdentify.get();
      case "olive" : return CSSOliveIdentify.get();
      case "orange" : return CSSOrangeIdentify.get();
      case "purple" : return CSSPurpleIdentify.get();
      case "red" : return CSSRedIdentify.get();
      case "silver" : return CSSSilverIdentify.get();
      case "teal" : return CSSTealIdentify.get();
      case "white" : return CSSWhiteIdentify.get();
      case "yellow" : return CSSYellowIdentify.get();
      case "transparent" : return CSSTransparentIdentify.get();
      case "WebkitLink" : return CSSWebkitLinkIdentify.get();
      case "WebkitActivelink" : return CSSWebkitActivelinkIdentify.get();
      case "activeborder" : return CSSActiveborderIdentify.get();
      case "activecaption" : return CSSActivecaptionIdentify.get();
      case "appworkspace" : return CSSAppworkspaceIdentify.get();
      case "background" : return CSSBackgroundIdentify.get();
      case "buttonface" : return CSSButtonfaceIdentify.get();
      case "buttonhighlight" : return CSSButtonhighlightIdentify.get();
      case "buttonshadow" : return CSSButtonshadowIdentify.get();
      case "buttontext" : return CSSButtontextIdentify.get();
      case "captiontext" : return CSSCaptiontextIdentify.get();
      case "graytext" : return CSSGraytextIdentify.get();
      case "highlight" : return CSSHighlightIdentify.get();
      case "highlighttext" : return CSSHighlighttextIdentify.get();
      case "inactiveborder" : return CSSInactiveborderIdentify.get();
      case "inactivecaption" : return CSSInactivecaptionIdentify.get();
      case "inactivecaptiontext" : return CSSInactivecaptiontextIdentify.get();
      case "infobackground" : return CSSInfobackgroundIdentify.get();
      case "infotext" : return CSSInfotextIdentify.get();
      case "menutext" : return CSSMenutextIdentify.get();
      case "scrollbar" : return CSSScrollbarIdentify.get();
      case "threeddarkshadow" : return CSSThreeddarkshadowIdentify.get();
      case "threedface" : return CSSThreedfaceIdentify.get();
      case "threedhighlight" : return CSSThreedhighlightIdentify.get();
      case "threedlightshadow" : return CSSThreedlightshadowIdentify.get();
      case "threedshadow" : return CSSThreedshadowIdentify.get();
      case "window" : return CSSWindowIdentify.get();
      case "windowframe" : return CSSWindowframeIdentify.get();
      case "windowtext" : return CSSWindowtextIdentify.get();
      case "InternalActiveListBoxSelection" : return CSSInternalActiveListBoxSelectionIdentify.get();
      case "InternalActiveListBoxSelectionText" : return CSSInternalActiveListBoxSelectionTextIdentify.get();
      case "InternalInactiveListBoxSelection" : return CSSInternalInactiveListBoxSelectionIdentify.get();
      case "InternalInactiveListBoxSelectionText" : return CSSInternalInactiveListBoxSelectionTextIdentify.get();
      case "currentcolor" : return CSSCurrentcolorIdentify.get();
      case "grey" : return CSSGreyIdentify.get();
      case "InternalQuirkInherit" : return CSSInternalQuirkInheritIdentify.get();
      case "repeat" : return CSSRepeatIdentify.get();
      case "repeatX" : return CSSRepeatXIdentify.get();
      case "repeatY" : return CSSRepeatYIdentify.get();
      case "noRepeat" : return CSSNoRepeatIdentify.get();
      case "clear" : return CSSClearIdentify.get();
      case "copy" : return CSSCopyIdentify.get();
      case "sourceOver" : return CSSSourceOverIdentify.get();
      case "sourceIn" : return CSSSourceInIdentify.get();
      case "sourceOut" : return CSSSourceOutIdentify.get();
      case "sourceAtop" : return CSSSourceAtopIdentify.get();
      case "destinationOver" : return CSSDestinationOverIdentify.get();
      case "destinationIn" : return CSSDestinationInIdentify.get();
      case "destinationOut" : return CSSDestinationOutIdentify.get();
      case "destinationAtop" : return CSSDestinationAtopIdentify.get();
      case "xor" : return CSSXorIdentify.get();
      case "plusLighter" : return CSSPlusLighterIdentify.get();
      case "baseline" : return CSSBaselineIdentify.get();
      case "middle" : return CSSMiddleIdentify.get();
      case "sub" : return CSSSubIdentify.get();
      case "super" : return CSSSuperIdentify.get();
      case "textTop" : return CSSTextTopIdentify.get();
      case "textBottom" : return CSSTextBottomIdentify.get();
      case "top" : return CSSTopIdentify.get();
      case "bottom" : return CSSBottomIdentify.get();
      case "WebkitBaselineMiddle" : return CSSWebkitBaselineMiddleIdentify.get();
      case "WebkitAuto" : return CSSWebkitAutoIdentify.get();
      case "left" : return CSSLeftIdentify.get();
      case "right" : return CSSRightIdentify.get();
      case "center" : return CSSCenterIdentify.get();
      case "justify" : return CSSJustifyIdentify.get();
      case "WebkitLeft" : return CSSWebkitLeftIdentify.get();
      case "WebkitRight" : return CSSWebkitRightIdentify.get();
      case "WebkitCenter" : return CSSWebkitCenterIdentify.get();
      case "WebkitMatchParent" : return CSSWebkitMatchParentIdentify.get();
      case "InternalCenter" : return CSSInternalCenterIdentify.get();
      case "interWord" : return CSSInterWordIdentify.get();
      case "distribute" : return CSSDistributeIdentify.get();
      case "outside" : return CSSOutsideIdentify.get();
      case "inside" : return CSSInsideIdentify.get();
      case "disc" : return CSSDiscIdentify.get();
      case "circle" : return CSSCircleIdentify.get();
      case "square" : return CSSSquareIdentify.get();
      case "decimal" : return CSSDecimalIdentify.get();
      case "decimalLeadingZero" : return CSSDecimalLeadingZeroIdentify.get();
      case "arabicIndic" : return CSSArabicIndicIdentify.get();
      case "bengali" : return CSSBengaliIdentify.get();
      case "cambodian" : return CSSCambodianIdentify.get();
      case "khmer" : return CSSKhmerIdentify.get();
      case "devanagari" : return CSSDevanagariIdentify.get();
      case "gujarati" : return CSSGujaratiIdentify.get();
      case "gurmukhi" : return CSSGurmukhiIdentify.get();
      case "kannada" : return CSSKannadaIdentify.get();
      case "lao" : return CSSLaoIdentify.get();
      case "malayalam" : return CSSMalayalamIdentify.get();
      case "mongolian" : return CSSMongolianIdentify.get();
      case "myanmar" : return CSSMyanmarIdentify.get();
      case "oriya" : return CSSOriyaIdentify.get();
      case "persian" : return CSSPersianIdentify.get();
      case "urdu" : return CSSUrduIdentify.get();
      case "telugu" : return CSSTeluguIdentify.get();
      case "tibetan" : return CSSTibetanIdentify.get();
      case "thai" : return CSSThaiIdentify.get();
      case "lowerRoman" : return CSSLowerRomanIdentify.get();
      case "upperRoman" : return CSSUpperRomanIdentify.get();
      case "lowerGreek" : return CSSLowerGreekIdentify.get();
      case "lowerAlpha" : return CSSLowerAlphaIdentify.get();
      case "lowerLatin" : return CSSLowerLatinIdentify.get();
      case "upperAlpha" : return CSSUpperAlphaIdentify.get();
      case "upperLatin" : return CSSUpperLatinIdentify.get();
      case "cjkEarthlyBranch" : return CSSCjkEarthlyBranchIdentify.get();
      case "cjkHeavenlyStem" : return CSSCjkHeavenlyStemIdentify.get();
      case "ethiopicHalehame" : return CSSEthiopicHalehameIdentify.get();
      case "ethiopicHalehameAm" : return CSSEthiopicHalehameAmIdentify.get();
      case "ethiopicHalehameTiEr" : return CSSEthiopicHalehameTiErIdentify.get();
      case "ethiopicHalehameTiEt" : return CSSEthiopicHalehameTiEtIdentify.get();
      case "hangul" : return CSSHangulIdentify.get();
      case "hangulConsonant" : return CSSHangulConsonantIdentify.get();
      case "koreanHangulFormal" : return CSSKoreanHangulFormalIdentify.get();
      case "koreanHanjaFormal" : return CSSKoreanHanjaFormalIdentify.get();
      case "koreanHanjaInformal" : return CSSKoreanHanjaInformalIdentify.get();
      case "hebrew" : return CSSHebrewIdentify.get();
      case "armenian" : return CSSArmenianIdentify.get();
      case "lowerArmenian" : return CSSLowerArmenianIdentify.get();
      case "upperArmenian" : return CSSUpperArmenianIdentify.get();
      case "georgian" : return CSSGeorgianIdentify.get();
      case "cjkIdeographic" : return CSSCjkIdeographicIdentify.get();
      case "simpChineseFormal" : return CSSSimpChineseFormalIdentify.get();
      case "simpChineseInformal" : return CSSSimpChineseInformalIdentify.get();
      case "tradChineseFormal" : return CSSTradChineseFormalIdentify.get();
      case "tradChineseInformal" : return CSSTradChineseInformalIdentify.get();
      case "hiragana" : return CSSHiraganaIdentify.get();
      case "katakana" : return CSSKatakanaIdentify.get();
      case "hiraganaIroha" : return CSSHiraganaIrohaIdentify.get();
      case "katakanaIroha" : return CSSKatakanaIrohaIdentify.get();
      case "inline" : return CSSInlineIdentify.get();
      case "block" : return CSSBlockIdentify.get();
      case "flowRoot" : return CSSFlowRootIdentify.get();
      case "listItem" : return CSSListItemIdentify.get();
      case "inlineBlock" : return CSSInlineBlockIdentify.get();
      case "table" : return CSSTableIdentify.get();
      case "inlineTable" : return CSSInlineTableIdentify.get();
      case "tableRowGroup" : return CSSTableRowGroupIdentify.get();
      case "tableHeaderGroup" : return CSSTableHeaderGroupIdentify.get();
      case "tableFooterGroup" : return CSSTableFooterGroupIdentify.get();
      case "tableRow" : return CSSTableRowIdentify.get();
      case "tableColumnGroup" : return CSSTableColumnGroupIdentify.get();
      case "tableColumn" : return CSSTableColumnIdentify.get();
      case "tableCell" : return CSSTableCellIdentify.get();
      case "tableCaption" : return CSSTableCaptionIdentify.get();
      case "WebkitBox" : return CSSWebkitBoxIdentify.get();
      case "WebkitInlineBox" : return CSSWebkitInlineBoxIdentify.get();
      case "flex" : return CSSFlexIdentify.get();
      case "inlineFlex" : return CSSInlineFlexIdentify.get();
      case "grid" : return CSSGridIdentify.get();
      case "inlineGrid" : return CSSInlineGridIdentify.get();
      case "contents" : return CSSContentsIdentify.get();
      case "WebkitFlex" : return CSSWebkitFlexIdentify.get();
      case "WebkitInlineFlex" : return CSSWebkitInlineFlexIdentify.get();
      case "auto" : return CSSAutoIdentify.get();
      case "crosshair" : return CSSCrosshairIdentify.get();
      case "default" : return CSSDefaultIdentify.get();
      case "pointer" : return CSSPointerIdentify.get();
      case "move" : return CSSMoveIdentify.get();
      case "verticalText" : return CSSVerticalTextIdentify.get();
      case "cell" : return CSSCellIdentify.get();
      case "contextMenu" : return CSSContextMenuIdentify.get();
      case "alias" : return CSSAliasIdentify.get();
      case "progress" : return CSSProgressIdentify.get();
      case "noDrop" : return CSSNoDropIdentify.get();
      case "notAllowed" : return CSSNotAllowedIdentify.get();
      case "zoomIn" : return CSSZoomInIdentify.get();
      case "zoomOut" : return CSSZoomOutIdentify.get();
      case "eResize" : return CSSEResizeIdentify.get();
      case "neResize" : return CSSNeResizeIdentify.get();
      case "nwResize" : return CSSNwResizeIdentify.get();
      case "nResize" : return CSSNResizeIdentify.get();
      case "seResize" : return CSSSeResizeIdentify.get();
      case "swResize" : return CSSSwResizeIdentify.get();
      case "sResize" : return CSSSResizeIdentify.get();
      case "wResize" : return CSSWResizeIdentify.get();
      case "ewResize" : return CSSEwResizeIdentify.get();
      case "nsResize" : return CSSNsResizeIdentify.get();
      case "neswResize" : return CSSNeswResizeIdentify.get();
      case "nwseResize" : return CSSNwseResizeIdentify.get();
      case "colResize" : return CSSColResizeIdentify.get();
      case "rowResize" : return CSSRowResizeIdentify.get();
      case "text" : return CSSTextIdentify.get();
      case "wait" : return CSSWaitIdentify.get();
      case "help" : return CSSHelpIdentify.get();
      case "allScroll" : return CSSAllScrollIdentify.get();
      case "WebkitGrab" : return CSSWebkitGrabIdentify.get();
      case "WebkitGrabbing" : return CSSWebkitGrabbingIdentify.get();
      case "WebkitZoomIn" : return CSSWebkitZoomInIdentify.get();
      case "WebkitZoomOut" : return CSSWebkitZoomOutIdentify.get();
      case "ltr" : return CSSLtrIdentify.get();
      case "rtl" : return CSSRtlIdentify.get();
      case "capitalize" : return CSSCapitalizeIdentify.get();
      case "uppercase" : return CSSUppercaseIdentify.get();
      case "lowercase" : return CSSLowercaseIdentify.get();
      case "visible" : return CSSVisibleIdentify.get();
      case "collapse" : return CSSCollapseIdentify.get();
      case "a3" : return CSSA3Identify.get();
      case "a4" : return CSSA4Identify.get();
      case "a5" : return CSSA5Identify.get();
      case "above" : return CSSAboveIdentify.get();
      case "absolute" : return CSSAbsoluteIdentify.get();
      case "always" : return CSSAlwaysIdentify.get();
      case "avoid" : return CSSAvoidIdentify.get();
      case "b4" : return CSSB4Identify.get();
      case "b5" : return CSSB5Identify.get();
      case "below" : return CSSBelowIdentify.get();
      case "bidiOverride" : return CSSBidiOverrideIdentify.get();
      case "blink" : return CSSBlinkIdentify.get();
      case "both" : return CSSBothIdentify.get();
      case "closeQuote" : return CSSCloseQuoteIdentify.get();
      case "embed" : return CSSEmbedIdentify.get();
      case "fixed" : return CSSFixedIdentify.get();
      case "hand" : return CSSHandIdentify.get();
      case "hide" : return CSSHideIdentify.get();
      case "isolate" : return CSSIsolateIdentify.get();
      case "isolateOverride" : return CSSIsolateOverrideIdentify.get();
      case "plaintext" : return CSSPlaintextIdentify.get();
      case "WebkitIsolate" : return CSSWebkitIsolateIdentify.get();
      case "WebkitIsolateOverride" : return CSSWebkitIsolateOverrideIdentify.get();
      case "WebkitPlaintext" : return CSSWebkitPlaintextIdentify.get();
      case "landscape" : return CSSLandscapeIdentify.get();
      case "ledger" : return CSSLedgerIdentify.get();
      case "legal" : return CSSLegalIdentify.get();
      case "letter" : return CSSLetterIdentify.get();
      case "lineThrough" : return CSSLineThroughIdentify.get();
      case "local" : return CSSLocalIdentify.get();
      case "noCloseQuote" : return CSSNoCloseQuoteIdentify.get();
      case "noOpenQuote" : return CSSNoOpenQuoteIdentify.get();
      case "nowrap" : return CSSNowrapIdentify.get();
      case "openQuote" : return CSSOpenQuoteIdentify.get();
      case "overlay" : return CSSOverlayIdentify.get();
      case "overline" : return CSSOverlineIdentify.get();
      case "portrait" : return CSSPortraitIdentify.get();
      case "pre" : return CSSPreIdentify.get();
      case "preLine" : return CSSPreLineIdentify.get();
      case "preWrap" : return CSSPreWrapIdentify.get();
      case "relative" : return CSSRelativeIdentify.get();
      case "scroll" : return CSSScrollIdentify.get();
      case "separate" : return CSSSeparateIdentify.get();
      case "show" : return CSSShowIdentify.get();
      case "static" : return CSSStaticIdentify.get();
      case "thick" : return CSSThickIdentify.get();
      case "thin" : return CSSThinIdentify.get();
      case "underline" : return CSSUnderlineIdentify.get();
      case "wavy" : return CSSWavyIdentify.get();
      case "WebkitNowrap" : return CSSWebkitNowrapIdentify.get();
      case "stretch" : return CSSStretchIdentify.get();
      case "start" : return CSSStartIdentify.get();
      case "end" : return CSSEndIdentify.get();
      case "clone" : return CSSCloneIdentify.get();
      case "slice" : return CSSSliceIdentify.get();
      case "reverse" : return CSSReverseIdentify.get();
      case "horizontal" : return CSSHorizontalIdentify.get();
      case "vertical" : return CSSVerticalIdentify.get();
      case "inlineAxis" : return CSSInlineAxisIdentify.get();
      case "blockAxis" : return CSSBlockAxisIdentify.get();
      case "single" : return CSSSingleIdentify.get();
      case "multiple" : return CSSMultipleIdentify.get();
      case "flexStart" : return CSSFlexStartIdentify.get();
      case "flexEnd" : return CSSFlexEndIdentify.get();
      case "spaceBetween" : return CSSSpaceBetweenIdentify.get();
      case "spaceAround" : return CSSSpaceAroundIdentify.get();
      case "spaceEvenly" : return CSSSpaceEvenlyIdentify.get();
      case "unsafe" : return CSSUnsafeIdentify.get();
      case "safe" : return CSSSafeIdentify.get();
      case "row" : return CSSRowIdentify.get();
      case "rowReverse" : return CSSRowReverseIdentify.get();
      case "column" : return CSSColumnIdentify.get();
      case "columnReverse" : return CSSColumnReverseIdentify.get();
      case "wrap" : return CSSWrapIdentify.get();
      case "wrapReverse" : return CSSWrapReverseIdentify.get();
      case "autoFlow" : return CSSAutoFlowIdentify.get();
      case "dense" : return CSSDenseIdentify.get();
      case "readOnly" : return CSSReadOnlyIdentify.get();
      case "readWrite" : return CSSReadWriteIdentify.get();
      case "readWritePlaintextOnly" : return CSSReadWritePlaintextOnlyIdentify.get();
      case "element" : return CSSElementIdentify.get();
      case "WebkitMinContent" : return CSSWebkitMinContentIdentify.get();
      case "WebkitMaxContent" : return CSSWebkitMaxContentIdentify.get();
      case "WebkitFillAvailable" : return CSSWebkitFillAvailableIdentify.get();
      case "WebkitFitContent" : return CSSWebkitFitContentIdentify.get();
      case "minContent" : return CSSMinContentIdentify.get();
      case "maxContent" : return CSSMaxContentIdentify.get();
      case "fitContent" : return CSSFitContentIdentify.get();
      case "clip" : return CSSClipIdentify.get();
      case "ellipsis" : return CSSEllipsisIdentify.get();
      case "discard" : return CSSDiscardIdentify.get();
      case "breakAll" : return CSSBreakAllIdentify.get();
      case "keepAll" : return CSSKeepAllIdentify.get();
      case "breakWord" : return CSSBreakWordIdentify.get();
      case "space" : return CSSSpaceIdentify.get();
      case "loose" : return CSSLooseIdentify.get();
      case "strict" : return CSSStrictIdentify.get();
      case "afterWhiteSpace" : return CSSAfterWhiteSpaceIdentify.get();
      case "manual" : return CSSManualIdentify.get();
      case "checkbox" : return CSSCheckboxIdentify.get();
      case "radio" : return CSSRadioIdentify.get();
      case "pushButton" : return CSSPushButtonIdentify.get();
      case "squareButton" : return CSSSquareButtonIdentify.get();
      case "button" : return CSSButtonIdentify.get();
      case "buttonBevel" : return CSSButtonBevelIdentify.get();
      case "innerSpinButton" : return CSSInnerSpinButtonIdentify.get();
      case "listbox" : return CSSListboxIdentify.get();
      case "listitem" : return CSSListitemIdentify.get();
      case "mediaEnterFullscreenButton" : return CSSMediaEnterFullscreenButtonIdentify.get();
      case "mediaExitFullscreenButton" : return CSSMediaExitFullscreenButtonIdentify.get();
      case "mediaMuteButton" : return CSSMediaMuteButtonIdentify.get();
      case "mediaPlayButton" : return CSSMediaPlayButtonIdentify.get();
      case "mediaOverlayPlayButton" : return CSSMediaOverlayPlayButtonIdentify.get();
      case "mediaToggleClosedCaptionsButton" : return CSSMediaToggleClosedCaptionsButtonIdentify.get();
      case "mediaSlider" : return CSSMediaSliderIdentify.get();
      case "mediaSliderthumb" : return CSSMediaSliderthumbIdentify.get();
      case "mediaVolumeSliderContainer" : return CSSMediaVolumeSliderContainerIdentify.get();
      case "mediaVolumeSlider" : return CSSMediaVolumeSliderIdentify.get();
      case "mediaVolumeSliderthumb" : return CSSMediaVolumeSliderthumbIdentify.get();
      case "mediaControlsBackground" : return CSSMediaControlsBackgroundIdentify.get();
      case "mediaControlsFullscreenBackground" : return CSSMediaControlsFullscreenBackgroundIdentify.get();
      case "mediaCurrentTimeDisplay" : return CSSMediaCurrentTimeDisplayIdentify.get();
      case "mediaTimeRemainingDisplay" : return CSSMediaTimeRemainingDisplayIdentify.get();
      case "InternalMediaCastOffButton" : return CSSInternalMediaCastOffButtonIdentify.get();
      case "InternalMediaOverlayCastOffButton" : return CSSInternalMediaOverlayCastOffButtonIdentify.get();
      case "InternalMediaTrackSelectionCheckmark" : return CSSInternalMediaTrackSelectionCheckmarkIdentify.get();
      case "InternalMediaClosedCaptionsIcon" : return CSSInternalMediaClosedCaptionsIconIdentify.get();
      case "InternalMediaSubtitlesIcon" : return CSSInternalMediaSubtitlesIconIdentify.get();
      case "InternalMediaOverflowButton" : return CSSInternalMediaOverflowButtonIdentify.get();
      case "InternalMediaDownloadButton" : return CSSInternalMediaDownloadButtonIdentify.get();
      case "InternalMediaRemotingCastIcon" : return CSSInternalMediaRemotingCastIconIdentify.get();
      case "InternalMediaControl" : return CSSInternalMediaControlIdentify.get();
      case "menulist" : return CSSMenulistIdentify.get();
      case "menulistButton" : return CSSMenulistButtonIdentify.get();
      case "menulistText" : return CSSMenulistTextIdentify.get();
      case "menulistTextfield" : return CSSMenulistTextfieldIdentify.get();
      case "meter" : return CSSMeterIdentify.get();
      case "progressBar" : return CSSProgressBarIdentify.get();
      case "progressBarValue" : return CSSProgressBarValueIdentify.get();
      case "sliderHorizontal" : return CSSSliderHorizontalIdentify.get();
      case "sliderVertical" : return CSSSliderVerticalIdentify.get();
      case "sliderthumbHorizontal" : return CSSSliderthumbHorizontalIdentify.get();
      case "sliderthumbVertical" : return CSSSliderthumbVerticalIdentify.get();
      case "caret" : return CSSCaretIdentify.get();
      case "searchfield" : return CSSSearchfieldIdentify.get();
      case "searchfieldCancelButton" : return CSSSearchfieldCancelButtonIdentify.get();
      case "textfield" : return CSSTextfieldIdentify.get();
      case "textarea" : return CSSTextareaIdentify.get();
      case "capsLockIndicator" : return CSSCapsLockIndicatorIdentify.get();
      case "round" : return CSSRoundIdentify.get();
      case "border" : return CSSBorderIdentify.get();
      case "borderBox" : return CSSBorderBoxIdentify.get();
      case "content" : return CSSContentIdentify.get();
      case "contentBox" : return CSSContentBoxIdentify.get();
      case "padding" : return CSSPaddingIdentify.get();
      case "paddingBox" : return CSSPaddingBoxIdentify.get();
      case "marginBox" : return CSSMarginBoxIdentify.get();
      case "contain" : return CSSContainIdentify.get();
      case "cover" : return CSSCoverIdentify.get();
      case "logical" : return CSSLogicalIdentify.get();
      case "visual" : return CSSVisualIdentify.get();
      case "alternate" : return CSSAlternateIdentify.get();
      case "alternateReverse" : return CSSAlternateReverseIdentify.get();
      case "forwards" : return CSSForwardsIdentify.get();
      case "backwards" : return CSSBackwardsIdentify.get();
      case "infinite" : return CSSInfiniteIdentify.get();
      case "running" : return CSSRunningIdentify.get();
      case "paused" : return CSSPausedIdentify.get();
      case "flat" : return CSSFlatIdentify.get();
      case "preserve3d" : return CSSPreserve3dIdentify.get();
      case "fillBox" : return CSSFillBoxIdentify.get();
      case "viewBox" : return CSSViewBoxIdentify.get();
      case "ease" : return CSSEaseIdentify.get();
      case "linear" : return CSSLinearIdentify.get();
      case "easeIn" : return CSSEaseInIdentify.get();
      case "easeOut" : return CSSEaseOutIdentify.get();
      case "easeInOut" : return CSSEaseInOutIdentify.get();
      case "stepStart" : return CSSStepStartIdentify.get();
      case "stepMiddle" : return CSSStepMiddleIdentify.get();
      case "stepEnd" : return CSSStepEndIdentify.get();
      case "steps" : return CSSStepsIdentify.get();
      case "frames" : return CSSFramesIdentify.get();
      case "cubicBezier" : return CSSCubicBezierIdentify.get();
      case "document" : return CSSDocumentIdentify.get();
      case "reset" : return CSSResetIdentify.get();
      case "zoom" : return CSSZoomIdentify.get();
      case "visiblePainted" : return CSSVisiblePaintedIdentify.get();
      case "visibleFill" : return CSSVisibleFillIdentify.get();
      case "visibleStroke" : return CSSVisibleStrokeIdentify.get();
      case "painted" : return CSSPaintedIdentify.get();
      case "fill" : return CSSFillIdentify.get();
      case "stroke" : return CSSStrokeIdentify.get();
      case "boundingBox" : return CSSBoundingBoxIdentify.get();
      case "spellOut" : return CSSSpellOutIdentify.get();
      case "digits" : return CSSDigitsIdentify.get();
      case "literalPunctuation" : return CSSLiteralPunctuationIdentify.get();
      case "noPunctuation" : return CSSNoPunctuationIdentify.get();
      case "antialiased" : return CSSAntialiasedIdentify.get();
      case "subpixelAntialiased" : return CSSSubpixelAntialiasedIdentify.get();
      case "optimizeSpeed" : return CSSOptimizeSpeedIdentify.get();
      case "optimizeLegibility" : return CSSOptimizeLegibilityIdentify.get();
      case "geometricPrecision" : return CSSGeometricPrecisionIdentify.get();
      case "economy" : return CSSEconomyIdentify.get();
      case "exact" : return CSSExactIdentify.get();
      case "lr" : return CSSLrIdentify.get();
      case "rl" : return CSSRlIdentify.get();
      case "tb" : return CSSTbIdentify.get();
      case "lrTb" : return CSSLrTbIdentify.get();
      case "rlTb" : return CSSRlTbIdentify.get();
      case "tbRl" : return CSSTbRlIdentify.get();
      case "horizontalTb" : return CSSHorizontalTbIdentify.get();
      case "verticalRl" : return CSSVerticalRlIdentify.get();
      case "verticalLr" : return CSSVerticalLrIdentify.get();
      case "after" : return CSSAfterIdentify.get();
      case "before" : return CSSBeforeIdentify.get();
      case "over" : return CSSOverIdentify.get();
      case "under" : return CSSUnderIdentify.get();
      case "filled" : return CSSFilledIdentify.get();
      case "open" : return CSSOpenIdentify.get();
      case "dot" : return CSSDotIdentify.get();
      case "doubleCircle" : return CSSDoubleCircleIdentify.get();
      case "triangle" : return CSSTriangleIdentify.get();
      case "sesame" : return CSSSesameIdentify.get();
      case "ellipse" : return CSSEllipseIdentify.get();
      case "closestSide" : return CSSClosestSideIdentify.get();
      case "closestCorner" : return CSSClosestCornerIdentify.get();
      case "farthestSide" : return CSSFarthestSideIdentify.get();
      case "farthestCorner" : return CSSFarthestCornerIdentify.get();
      case "mixed" : return CSSMixedIdentify.get();
      case "sideways" : return CSSSidewaysIdentify.get();
      case "sidewaysRight" : return CSSSidewaysRightIdentify.get();
      case "upright" : return CSSUprightIdentify.get();
      case "verticalRight" : return CSSVerticalRightIdentify.get();
      case "on" : return CSSOnIdentify.get();
      case "off" : return CSSOffIdentify.get();
      case "optimizeQuality" : return CSSOptimizeQualityIdentify.get();
      case "pixelated" : return CSSPixelatedIdentify.get();
      case "WebkitOptimizeContrast" : return CSSWebkitOptimizeContrastIdentify.get();
      case "fromImage" : return CSSFromImageIdentify.get();
      case "nonzero" : return CSSNonzeroIdentify.get();
      case "evenodd" : return CSSEvenoddIdentify.get();
      case "at" : return CSSAtIdentify.get();
      case "alphabetic" : return CSSAlphabeticIdentify.get();
      case "fullscreen" : return CSSFullscreenIdentify.get();
      case "standalone" : return CSSStandaloneIdentify.get();
      case "minimalUi" : return CSSMinimalUiIdentify.get();
      case "browser" : return CSSBrowserIdentify.get();
      case "sticky" : return CSSStickyIdentify.get();
      case "coarse" : return CSSCoarseIdentify.get();
      case "fine" : return CSSFineIdentify.get();
      case "onDemand" : return CSSOnDemandIdentify.get();
      case "hover" : return CSSHoverIdentify.get();
      case "multiply" : return CSSMultiplyIdentify.get();
      case "screen" : return CSSScreenIdentify.get();
      case "darken" : return CSSDarkenIdentify.get();
      case "lighten" : return CSSLightenIdentify.get();
      case "colorDodge" : return CSSColorDodgeIdentify.get();
      case "colorBurn" : return CSSColorBurnIdentify.get();
      case "hardLight" : return CSSHardLightIdentify.get();
      case "softLight" : return CSSSoftLightIdentify.get();
      case "difference" : return CSSDifferenceIdentify.get();
      case "exclusion" : return CSSExclusionIdentify.get();
      case "hue" : return CSSHueIdentify.get();
      case "saturation" : return CSSSaturationIdentify.get();
      case "color" : return CSSColorIdentify.get();
      case "luminosity" : return CSSLuminosityIdentify.get();
      case "scaleDown" : return CSSScaleDownIdentify.get();
      case "balance" : return CSSBalanceIdentify.get();
      case "WebkitPagedX" : return CSSWebkitPagedXIdentify.get();
      case "WebkitPagedY" : return CSSWebkitPagedYIdentify.get();
      case "drag" : return CSSDragIdentify.get();
      case "noDrag" : return CSSNoDragIdentify.get();
      case "span" : return CSSSpanIdentify.get();
      case "minmax" : return CSSMinmaxIdentify.get();
      case "eachLine" : return CSSEachLineIdentify.get();
      case "progressive" : return CSSProgressiveIdentify.get();
      case "interlace" : return CSSInterlaceIdentify.get();
      case "markers" : return CSSMarkersIdentify.get();
      case "InternalExtendToZoom" : return CSSInternalExtendToZoomIdentify.get();
      case "panX" : return CSSPanXIdentify.get();
      case "panY" : return CSSPanYIdentify.get();
      case "panLeft" : return CSSPanLeftIdentify.get();
      case "panRight" : return CSSPanRightIdentify.get();
      case "panUp" : return CSSPanUpIdentify.get();
      case "panDown" : return CSSPanDownIdentify.get();
      case "manipulation" : return CSSManipulationIdentify.get();
      case "pinchZoom" : return CSSPinchZoomIdentify.get();
      case "lastBaseline" : return CSSLastBaselineIdentify.get();
      case "firstBaseline" : return CSSFirstBaselineIdentify.get();
      case "first" : return CSSFirstIdentify.get();
      case "last" : return CSSLastIdentify.get();
      case "selfStart" : return CSSSelfStartIdentify.get();
      case "selfEnd" : return CSSSelfEndIdentify.get();
      case "legacy" : return CSSLegacyIdentify.get();
      case "smooth" : return CSSSmoothIdentify.get();
      case "scrollPosition" : return CSSScrollPositionIdentify.get();
      case "revert" : return CSSRevertIdentify.get();
      case "unset" : return CSSUnsetIdentify.get();
      case "linearGradient" : return CSSLinearGradientIdentify.get();
      case "radialGradient" : return CSSRadialGradientIdentify.get();
      case "conicGradient" : return CSSConicGradientIdentify.get();
      case "repeatingLinearGradient" : return CSSRepeatingLinearGradientIdentify.get();
      case "repeatingRadialGradient" : return CSSRepeatingRadialGradientIdentify.get();
      case "repeatingConicGradient" : return CSSRepeatingConicGradientIdentify.get();
      case "paint" : return CSSPaintIdentify.get();
      case "WebkitCrossFade" : return CSSWebkitCrossFadeIdentify.get();
      case "WebkitGradient" : return CSSWebkitGradientIdentify.get();
      case "WebkitLinearGradient" : return CSSWebkitLinearGradientIdentify.get();
      case "WebkitRadialGradient" : return CSSWebkitRadialGradientIdentify.get();
      case "WebkitRepeatingLinearGradient" : return CSSWebkitRepeatingLinearGradientIdentify.get();
      case "WebkitRepeatingRadialGradient" : return CSSWebkitRepeatingRadialGradientIdentify.get();
      case "WebkitImageSet" : return CSSWebkitImageSetIdentify.get();
      case "from" : return CSSFromIdentify.get();
      case "to" : return CSSToIdentify.get();
      case "colorStop" : return CSSColorStopIdentify.get();
      case "radial" : return CSSRadialIdentify.get();
      case "attr" : return CSSAttrIdentify.get();
      case "counter" : return CSSCounterIdentify.get();
      case "counters" : return CSSCountersIdentify.get();
      case "rect" : return CSSRectIdentify.get();
      case "polygon" : return CSSPolygonIdentify.get();
      case "format" : return CSSFormatIdentify.get();
      case "invert" : return CSSInvertIdentify.get();
      case "grayscale" : return CSSGrayscaleIdentify.get();
      case "sepia" : return CSSSepiaIdentify.get();
      case "saturate" : return CSSSaturateIdentify.get();
      case "hueRotate" : return CSSHueRotateIdentify.get();
      case "opacity" : return CSSOpacityIdentify.get();
      case "brightness" : return CSSBrightnessIdentify.get();
      case "contrast" : return CSSContrastIdentify.get();
      case "blur" : return CSSBlurIdentify.get();
      case "dropShadow" : return CSSDropShadowIdentify.get();
      case "url" : return CSSUrlIdentify.get();
      case "rgb" : return CSSRgbIdentify.get();
      case "rgba" : return CSSRgbaIdentify.get();
      case "hsl" : return CSSHslIdentify.get();
      case "hsla" : return CSSHslaIdentify.get();
      case "matrix" : return CSSMatrixIdentify.get();
      case "matrix3d" : return CSSMatrix3dIdentify.get();
      case "perspective" : return CSSPerspectiveIdentify.get();
      case "rotate" : return CSSRotateIdentify.get();
      case "rotateX" : return CSSRotateXIdentify.get();
      case "rotateY" : return CSSRotateYIdentify.get();
      case "rotateZ" : return CSSRotateZIdentify.get();
      case "rotate3d" : return CSSRotate3dIdentify.get();
      case "scale" : return CSSScaleIdentify.get();
      case "scaleX" : return CSSScaleXIdentify.get();
      case "scaleY" : return CSSScaleYIdentify.get();
      case "scaleZ" : return CSSScaleZIdentify.get();
      case "scale3d" : return CSSScale3dIdentify.get();
      case "skew" : return CSSSkewIdentify.get();
      case "skewX" : return CSSSkewXIdentify.get();
      case "skewY" : return CSSSkewYIdentify.get();
      case "translate" : return CSSTranslateIdentify.get();
      case "translateX" : return CSSTranslateXIdentify.get();
      case "translateY" : return CSSTranslateYIdentify.get();
      case "translateZ" : return CSSTranslateZIdentify.get();
      case "translate3d" : return CSSTranslate3dIdentify.get();
      case "path" : return CSSPathIdentify.get();
      case "ray" : return CSSRayIdentify.get();
      case "sides" : return CSSSidesIdentify.get();
      case "calc" : return CSSCalcIdentify.get();
      case "WebkitCalc" : return CSSWebkitCalcIdentify.get();
      case "x" : return CSSXIdentify.get();
      case "y" : return CSSYIdentify.get();
      case "mandatory" : return CSSMandatoryIdentify.get();
      case "proximity" : return CSSProximityIdentify.get();
      case "style" : return CSSStyleIdentify.get();
      case "layout" : return CSSLayoutIdentify.get();
      case "size" : return CSSSizeIdentify.get();
      case "autoFill" : return CSSAutoFillIdentify.get();
      case "autoFit" : return CSSAutoFitIdentify.get();
      case "var" : return CSSVarIdentify.get();
      case "InternalVariableValue" : return CSSInternalVariableValueIdentify.get();
      case "avoidPage" : return CSSAvoidPageIdentify.get();
      case "page" : return CSSPageIdentify.get();
      case "recto" : return CSSRectoIdentify.get();
      case "verso" : return CSSVersoIdentify.get();
      case "avoidColumn" : return CSSAvoidColumnIdentify.get();
      case "p3" : return CSSP3Identify.get();
      case "rec2020" : return CSSRec2020Identify.get();
      case "100" : return CSS100Identify.get();
      case "200" : return CSS200Identify.get();
      case "300" : return CSS300Identify.get();
      case "400" : return CSS400Identify.get();
      case "500" : return CSS500Identify.get();
      case "600" : return CSS600Identify.get();
      case "700" : return CSS700Identify.get();
      case "800" : return CSS800Identify.get();
      case "900" : return CSS900Identify.get();

      }

      return null;
    }


  @override
  toString(){
    return value;
  }

}

class CSSKnownIdentify extends CSSIdentify{
  const CSSKnownIdentify(value) : super(value);
  @override
  toString(){
    return _dashCase(value);
  }
}


class CSSInheritIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInheritIdentify(); const CSSInheritIdentify():super("inherit"); }
class CSSInitialIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInitialIdentify(); const CSSInitialIdentify():super("initial"); }
class CSSNoneIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNoneIdentify(); const CSSNoneIdentify():super("none"); }
class CSSHiddenIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHiddenIdentify(); const CSSHiddenIdentify():super("hidden"); }
class CSSInsetIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInsetIdentify(); const CSSInsetIdentify():super("inset"); }
class CSSGrooveIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSGrooveIdentify(); const CSSGrooveIdentify():super("groove"); }
class CSSOutsetIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOutsetIdentify(); const CSSOutsetIdentify():super("outset"); }
class CSSRidgeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRidgeIdentify(); const CSSRidgeIdentify():super("ridge"); }
class CSSDottedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDottedIdentify(); const CSSDottedIdentify():super("dotted"); }
class CSSDashedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDashedIdentify(); const CSSDashedIdentify():super("dashed"); }
class CSSSolidIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSolidIdentify(); const CSSSolidIdentify():super("solid"); }
class CSSDoubleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDoubleIdentify(); const CSSDoubleIdentify():super("double"); }
class CSSCaptionIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCaptionIdentify(); const CSSCaptionIdentify():super("caption"); }
class CSSIconIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSIconIdentify(); const CSSIconIdentify():super("icon"); }
class CSSMenuIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMenuIdentify(); const CSSMenuIdentify():super("menu"); }
class CSSMessageBoxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMessageBoxIdentify(); const CSSMessageBoxIdentify():super("messageBox"); }
class CSSSmallCaptionIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSmallCaptionIdentify(); const CSSSmallCaptionIdentify():super("smallCaption"); }
class CSSWebkitMiniControlIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitMiniControlIdentify(); const CSSWebkitMiniControlIdentify():super("WebkitMiniControl"); }
class CSSWebkitSmallControlIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitSmallControlIdentify(); const CSSWebkitSmallControlIdentify():super("WebkitSmallControl"); }
class CSSWebkitControlIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitControlIdentify(); const CSSWebkitControlIdentify():super("WebkitControl"); }
class CSSStatusBarIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStatusBarIdentify(); const CSSStatusBarIdentify():super("statusBar"); }
class CSSItalicIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSItalicIdentify(); const CSSItalicIdentify():super("italic"); }
class CSSObliqueIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSObliqueIdentify(); const CSSObliqueIdentify():super("oblique"); }
class CSSAllIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAllIdentify(); const CSSAllIdentify():super("all"); }
class CSSCommonLigaturesIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCommonLigaturesIdentify(); const CSSCommonLigaturesIdentify():super("commonLigatures"); }
class CSSNoCommonLigaturesIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNoCommonLigaturesIdentify(); const CSSNoCommonLigaturesIdentify():super("noCommonLigatures"); }
class CSSDiscretionaryLigaturesIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDiscretionaryLigaturesIdentify(); const CSSDiscretionaryLigaturesIdentify():super("discretionaryLigatures"); }
class CSSNoDiscretionaryLigaturesIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNoDiscretionaryLigaturesIdentify(); const CSSNoDiscretionaryLigaturesIdentify():super("noDiscretionaryLigatures"); }
class CSSHistoricalLigaturesIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHistoricalLigaturesIdentify(); const CSSHistoricalLigaturesIdentify():super("historicalLigatures"); }
class CSSNoHistoricalLigaturesIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNoHistoricalLigaturesIdentify(); const CSSNoHistoricalLigaturesIdentify():super("noHistoricalLigatures"); }
class CSSContextualIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSContextualIdentify(); const CSSContextualIdentify():super("contextual"); }
class CSSNoContextualIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNoContextualIdentify(); const CSSNoContextualIdentify():super("noContextual"); }
class CSSSmallCapsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSmallCapsIdentify(); const CSSSmallCapsIdentify():super("smallCaps"); }
class CSSAllSmallCapsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAllSmallCapsIdentify(); const CSSAllSmallCapsIdentify():super("allSmallCaps"); }
class CSSPetiteCapsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPetiteCapsIdentify(); const CSSPetiteCapsIdentify():super("petiteCaps"); }
class CSSAllPetiteCapsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAllPetiteCapsIdentify(); const CSSAllPetiteCapsIdentify():super("allPetiteCaps"); }
class CSSUnicaseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUnicaseIdentify(); const CSSUnicaseIdentify():super("unicase"); }
class CSSTitlingCapsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTitlingCapsIdentify(); const CSSTitlingCapsIdentify():super("titlingCaps"); }
class CSSJis78Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSJis78Identify(); const CSSJis78Identify():super("jis78"); }
class CSSJis83Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSJis83Identify(); const CSSJis83Identify():super("jis83"); }
class CSSJis90Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSJis90Identify(); const CSSJis90Identify():super("jis90"); }
class CSSJis04Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSJis04Identify(); const CSSJis04Identify():super("jis04"); }
class CSSSimplifiedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSimplifiedIdentify(); const CSSSimplifiedIdentify():super("simplified"); }
class CSSTraditionalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTraditionalIdentify(); const CSSTraditionalIdentify():super("traditional"); }
class CSSFullWidthIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFullWidthIdentify(); const CSSFullWidthIdentify():super("fullWidth"); }
class CSSProportionalWidthIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSProportionalWidthIdentify(); const CSSProportionalWidthIdentify():super("proportionalWidth"); }
class CSSRubyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRubyIdentify(); const CSSRubyIdentify():super("ruby"); }
class CSSLiningNumsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLiningNumsIdentify(); const CSSLiningNumsIdentify():super("liningNums"); }
class CSSOldstyleNumsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOldstyleNumsIdentify(); const CSSOldstyleNumsIdentify():super("oldstyleNums"); }
class CSSProportionalNumsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSProportionalNumsIdentify(); const CSSProportionalNumsIdentify():super("proportionalNums"); }
class CSSTabularNumsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTabularNumsIdentify(); const CSSTabularNumsIdentify():super("tabularNums"); }
class CSSDiagonalFractionsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDiagonalFractionsIdentify(); const CSSDiagonalFractionsIdentify():super("diagonalFractions"); }
class CSSStackedFractionsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStackedFractionsIdentify(); const CSSStackedFractionsIdentify():super("stackedFractions"); }
class CSSOrdinalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOrdinalIdentify(); const CSSOrdinalIdentify():super("ordinal"); }
class CSSSlashedZeroIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSlashedZeroIdentify(); const CSSSlashedZeroIdentify():super("slashedZero"); }
class CSSNormalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNormalIdentify(); const CSSNormalIdentify():super("normal"); }
class CSSBoldIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBoldIdentify(); const CSSBoldIdentify():super("bold"); }
class CSSBolderIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBolderIdentify(); const CSSBolderIdentify():super("bolder"); }
class CSSLighterIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLighterIdentify(); const CSSLighterIdentify():super("lighter"); }
class CSSUltraCondensedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUltraCondensedIdentify(); const CSSUltraCondensedIdentify():super("ultraCondensed"); }
class CSSExtraCondensedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSExtraCondensedIdentify(); const CSSExtraCondensedIdentify():super("extraCondensed"); }
class CSSCondensedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCondensedIdentify(); const CSSCondensedIdentify():super("condensed"); }
class CSSSemiCondensedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSemiCondensedIdentify(); const CSSSemiCondensedIdentify():super("semiCondensed"); }
class CSSSemiExpandedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSemiExpandedIdentify(); const CSSSemiExpandedIdentify():super("semiExpanded"); }
class CSSExpandedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSExpandedIdentify(); const CSSExpandedIdentify():super("expanded"); }
class CSSExtraExpandedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSExtraExpandedIdentify(); const CSSExtraExpandedIdentify():super("extraExpanded"); }
class CSSUltraExpandedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUltraExpandedIdentify(); const CSSUltraExpandedIdentify():super("ultraExpanded"); }
class CSSXxSmallIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSXxSmallIdentify(); const CSSXxSmallIdentify():super("xxSmall"); }
class CSSXSmallIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSXSmallIdentify(); const CSSXSmallIdentify():super("xSmall"); }
class CSSSmallIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSmallIdentify(); const CSSSmallIdentify():super("small"); }
class CSSMediumIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediumIdentify(); const CSSMediumIdentify():super("medium"); }
class CSSLargeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLargeIdentify(); const CSSLargeIdentify():super("large"); }
class CSSXLargeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSXLargeIdentify(); const CSSXLargeIdentify():super("xLarge"); }
class CSSXxLargeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSXxLargeIdentify(); const CSSXxLargeIdentify():super("xxLarge"); }
class CSSWebkitXxxLargeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitXxxLargeIdentify(); const CSSWebkitXxxLargeIdentify():super("WebkitXxxLarge"); }
class CSSSmallerIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSmallerIdentify(); const CSSSmallerIdentify():super("smaller"); }
class CSSLargerIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLargerIdentify(); const CSSLargerIdentify():super("larger"); }
class CSSSerifIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSerifIdentify(); const CSSSerifIdentify():super("serif"); }
class CSSSansSerifIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSansSerifIdentify(); const CSSSansSerifIdentify():super("sansSerif"); }
class CSSCursiveIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCursiveIdentify(); const CSSCursiveIdentify():super("cursive"); }
class CSSFantasyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFantasyIdentify(); const CSSFantasyIdentify():super("fantasy"); }
class CSSMonospaceIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMonospaceIdentify(); const CSSMonospaceIdentify():super("monospace"); }
class CSSWebkitBodyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitBodyIdentify(); const CSSWebkitBodyIdentify():super("WebkitBody"); }
class CSSWebkitPictographIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitPictographIdentify(); const CSSWebkitPictographIdentify():super("WebkitPictograph"); }
class CSSSwapIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSwapIdentify(); const CSSSwapIdentify():super("swap"); }
class CSSFallbackIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFallbackIdentify(); const CSSFallbackIdentify():super("fallback"); }
class CSSOptionalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOptionalIdentify(); const CSSOptionalIdentify():super("optional"); }
class CSSAquaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAquaIdentify(); const CSSAquaIdentify():super("aqua"); }
class CSSBlackIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBlackIdentify(); const CSSBlackIdentify():super("black"); }
class CSSBlueIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBlueIdentify(); const CSSBlueIdentify():super("blue"); }
class CSSFuchsiaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFuchsiaIdentify(); const CSSFuchsiaIdentify():super("fuchsia"); }
class CSSGrayIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSGrayIdentify(); const CSSGrayIdentify():super("gray"); }
class CSSGreenIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSGreenIdentify(); const CSSGreenIdentify():super("green"); }
class CSSLimeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLimeIdentify(); const CSSLimeIdentify():super("lime"); }
class CSSMaroonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMaroonIdentify(); const CSSMaroonIdentify():super("maroon"); }
class CSSNavyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNavyIdentify(); const CSSNavyIdentify():super("navy"); }
class CSSOliveIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOliveIdentify(); const CSSOliveIdentify():super("olive"); }
class CSSOrangeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOrangeIdentify(); const CSSOrangeIdentify():super("orange"); }
class CSSPurpleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPurpleIdentify(); const CSSPurpleIdentify():super("purple"); }
class CSSRedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRedIdentify(); const CSSRedIdentify():super("red"); }
class CSSSilverIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSilverIdentify(); const CSSSilverIdentify():super("silver"); }
class CSSTealIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTealIdentify(); const CSSTealIdentify():super("teal"); }
class CSSWhiteIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWhiteIdentify(); const CSSWhiteIdentify():super("white"); }
class CSSYellowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSYellowIdentify(); const CSSYellowIdentify():super("yellow"); }
class CSSTransparentIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTransparentIdentify(); const CSSTransparentIdentify():super("transparent"); }
class CSSWebkitLinkIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitLinkIdentify(); const CSSWebkitLinkIdentify():super("WebkitLink"); }
class CSSWebkitActivelinkIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitActivelinkIdentify(); const CSSWebkitActivelinkIdentify():super("WebkitActivelink"); }
class CSSActiveborderIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSActiveborderIdentify(); const CSSActiveborderIdentify():super("activeborder"); }
class CSSActivecaptionIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSActivecaptionIdentify(); const CSSActivecaptionIdentify():super("activecaption"); }
class CSSAppworkspaceIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAppworkspaceIdentify(); const CSSAppworkspaceIdentify():super("appworkspace"); }
class CSSBackgroundIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBackgroundIdentify(); const CSSBackgroundIdentify():super("background"); }
class CSSButtonfaceIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSButtonfaceIdentify(); const CSSButtonfaceIdentify():super("buttonface"); }
class CSSButtonhighlightIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSButtonhighlightIdentify(); const CSSButtonhighlightIdentify():super("buttonhighlight"); }
class CSSButtonshadowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSButtonshadowIdentify(); const CSSButtonshadowIdentify():super("buttonshadow"); }
class CSSButtontextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSButtontextIdentify(); const CSSButtontextIdentify():super("buttontext"); }
class CSSCaptiontextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCaptiontextIdentify(); const CSSCaptiontextIdentify():super("captiontext"); }
class CSSGraytextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSGraytextIdentify(); const CSSGraytextIdentify():super("graytext"); }
class CSSHighlightIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHighlightIdentify(); const CSSHighlightIdentify():super("highlight"); }
class CSSHighlighttextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHighlighttextIdentify(); const CSSHighlighttextIdentify():super("highlighttext"); }
class CSSInactiveborderIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInactiveborderIdentify(); const CSSInactiveborderIdentify():super("inactiveborder"); }
class CSSInactivecaptionIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInactivecaptionIdentify(); const CSSInactivecaptionIdentify():super("inactivecaption"); }
class CSSInactivecaptiontextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInactivecaptiontextIdentify(); const CSSInactivecaptiontextIdentify():super("inactivecaptiontext"); }
class CSSInfobackgroundIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInfobackgroundIdentify(); const CSSInfobackgroundIdentify():super("infobackground"); }
class CSSInfotextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInfotextIdentify(); const CSSInfotextIdentify():super("infotext"); }
class CSSMenutextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMenutextIdentify(); const CSSMenutextIdentify():super("menutext"); }
class CSSScrollbarIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSScrollbarIdentify(); const CSSScrollbarIdentify():super("scrollbar"); }
class CSSThreeddarkshadowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSThreeddarkshadowIdentify(); const CSSThreeddarkshadowIdentify():super("threeddarkshadow"); }
class CSSThreedfaceIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSThreedfaceIdentify(); const CSSThreedfaceIdentify():super("threedface"); }
class CSSThreedhighlightIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSThreedhighlightIdentify(); const CSSThreedhighlightIdentify():super("threedhighlight"); }
class CSSThreedlightshadowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSThreedlightshadowIdentify(); const CSSThreedlightshadowIdentify():super("threedlightshadow"); }
class CSSThreedshadowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSThreedshadowIdentify(); const CSSThreedshadowIdentify():super("threedshadow"); }
class CSSWindowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWindowIdentify(); const CSSWindowIdentify():super("window"); }
class CSSWindowframeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWindowframeIdentify(); const CSSWindowframeIdentify():super("windowframe"); }
class CSSWindowtextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWindowtextIdentify(); const CSSWindowtextIdentify():super("windowtext"); }
class CSSInternalActiveListBoxSelectionIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalActiveListBoxSelectionIdentify(); const CSSInternalActiveListBoxSelectionIdentify():super("InternalActiveListBoxSelection"); }
class CSSInternalActiveListBoxSelectionTextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalActiveListBoxSelectionTextIdentify(); const CSSInternalActiveListBoxSelectionTextIdentify():super("InternalActiveListBoxSelectionText"); }
class CSSInternalInactiveListBoxSelectionIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalInactiveListBoxSelectionIdentify(); const CSSInternalInactiveListBoxSelectionIdentify():super("InternalInactiveListBoxSelection"); }
class CSSInternalInactiveListBoxSelectionTextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalInactiveListBoxSelectionTextIdentify(); const CSSInternalInactiveListBoxSelectionTextIdentify():super("InternalInactiveListBoxSelectionText"); }
class CSSCurrentcolorIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCurrentcolorIdentify(); const CSSCurrentcolorIdentify():super("currentcolor"); }
class CSSGreyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSGreyIdentify(); const CSSGreyIdentify():super("grey"); }
class CSSInternalQuirkInheritIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalQuirkInheritIdentify(); const CSSInternalQuirkInheritIdentify():super("InternalQuirkInherit"); }
class CSSRepeatIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRepeatIdentify(); const CSSRepeatIdentify():super("repeat"); }
class CSSRepeatXIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRepeatXIdentify(); const CSSRepeatXIdentify():super("repeatX"); }
class CSSRepeatYIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRepeatYIdentify(); const CSSRepeatYIdentify():super("repeatY"); }
class CSSNoRepeatIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNoRepeatIdentify(); const CSSNoRepeatIdentify():super("noRepeat"); }
class CSSClearIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSClearIdentify(); const CSSClearIdentify():super("clear"); }
class CSSCopyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCopyIdentify(); const CSSCopyIdentify():super("copy"); }
class CSSSourceOverIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSourceOverIdentify(); const CSSSourceOverIdentify():super("sourceOver"); }
class CSSSourceInIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSourceInIdentify(); const CSSSourceInIdentify():super("sourceIn"); }
class CSSSourceOutIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSourceOutIdentify(); const CSSSourceOutIdentify():super("sourceOut"); }
class CSSSourceAtopIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSourceAtopIdentify(); const CSSSourceAtopIdentify():super("sourceAtop"); }
class CSSDestinationOverIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDestinationOverIdentify(); const CSSDestinationOverIdentify():super("destinationOver"); }
class CSSDestinationInIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDestinationInIdentify(); const CSSDestinationInIdentify():super("destinationIn"); }
class CSSDestinationOutIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDestinationOutIdentify(); const CSSDestinationOutIdentify():super("destinationOut"); }
class CSSDestinationAtopIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDestinationAtopIdentify(); const CSSDestinationAtopIdentify():super("destinationAtop"); }
class CSSXorIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSXorIdentify(); const CSSXorIdentify():super("xor"); }
class CSSPlusLighterIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPlusLighterIdentify(); const CSSPlusLighterIdentify():super("plusLighter"); }
class CSSBaselineIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBaselineIdentify(); const CSSBaselineIdentify():super("baseline"); }
class CSSMiddleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMiddleIdentify(); const CSSMiddleIdentify():super("middle"); }
class CSSSubIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSubIdentify(); const CSSSubIdentify():super("sub"); }
class CSSSuperIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSuperIdentify(); const CSSSuperIdentify():super("super"); }
class CSSTextTopIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTextTopIdentify(); const CSSTextTopIdentify():super("textTop"); }
class CSSTextBottomIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTextBottomIdentify(); const CSSTextBottomIdentify():super("textBottom"); }
class CSSTopIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTopIdentify(); const CSSTopIdentify():super("top"); }
class CSSBottomIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBottomIdentify(); const CSSBottomIdentify():super("bottom"); }
class CSSWebkitBaselineMiddleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitBaselineMiddleIdentify(); const CSSWebkitBaselineMiddleIdentify():super("WebkitBaselineMiddle"); }
class CSSWebkitAutoIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitAutoIdentify(); const CSSWebkitAutoIdentify():super("WebkitAuto"); }
class CSSLeftIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLeftIdentify(); const CSSLeftIdentify():super("left"); }
class CSSRightIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRightIdentify(); const CSSRightIdentify():super("right"); }
class CSSCenterIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCenterIdentify(); const CSSCenterIdentify():super("center"); }
class CSSJustifyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSJustifyIdentify(); const CSSJustifyIdentify():super("justify"); }
class CSSWebkitLeftIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitLeftIdentify(); const CSSWebkitLeftIdentify():super("WebkitLeft"); }
class CSSWebkitRightIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitRightIdentify(); const CSSWebkitRightIdentify():super("WebkitRight"); }
class CSSWebkitCenterIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitCenterIdentify(); const CSSWebkitCenterIdentify():super("WebkitCenter"); }
class CSSWebkitMatchParentIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitMatchParentIdentify(); const CSSWebkitMatchParentIdentify():super("WebkitMatchParent"); }
class CSSInternalCenterIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalCenterIdentify(); const CSSInternalCenterIdentify():super("InternalCenter"); }
class CSSInterWordIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInterWordIdentify(); const CSSInterWordIdentify():super("interWord"); }
class CSSDistributeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDistributeIdentify(); const CSSDistributeIdentify():super("distribute"); }
class CSSOutsideIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOutsideIdentify(); const CSSOutsideIdentify():super("outside"); }
class CSSInsideIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInsideIdentify(); const CSSInsideIdentify():super("inside"); }
class CSSDiscIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDiscIdentify(); const CSSDiscIdentify():super("disc"); }
class CSSCircleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCircleIdentify(); const CSSCircleIdentify():super("circle"); }
class CSSSquareIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSquareIdentify(); const CSSSquareIdentify():super("square"); }
class CSSDecimalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDecimalIdentify(); const CSSDecimalIdentify():super("decimal"); }
class CSSDecimalLeadingZeroIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDecimalLeadingZeroIdentify(); const CSSDecimalLeadingZeroIdentify():super("decimalLeadingZero"); }
class CSSArabicIndicIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSArabicIndicIdentify(); const CSSArabicIndicIdentify():super("arabicIndic"); }
class CSSBengaliIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBengaliIdentify(); const CSSBengaliIdentify():super("bengali"); }
class CSSCambodianIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCambodianIdentify(); const CSSCambodianIdentify():super("cambodian"); }
class CSSKhmerIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSKhmerIdentify(); const CSSKhmerIdentify():super("khmer"); }
class CSSDevanagariIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDevanagariIdentify(); const CSSDevanagariIdentify():super("devanagari"); }
class CSSGujaratiIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSGujaratiIdentify(); const CSSGujaratiIdentify():super("gujarati"); }
class CSSGurmukhiIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSGurmukhiIdentify(); const CSSGurmukhiIdentify():super("gurmukhi"); }
class CSSKannadaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSKannadaIdentify(); const CSSKannadaIdentify():super("kannada"); }
class CSSLaoIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLaoIdentify(); const CSSLaoIdentify():super("lao"); }
class CSSMalayalamIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMalayalamIdentify(); const CSSMalayalamIdentify():super("malayalam"); }
class CSSMongolianIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMongolianIdentify(); const CSSMongolianIdentify():super("mongolian"); }
class CSSMyanmarIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMyanmarIdentify(); const CSSMyanmarIdentify():super("myanmar"); }
class CSSOriyaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOriyaIdentify(); const CSSOriyaIdentify():super("oriya"); }
class CSSPersianIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPersianIdentify(); const CSSPersianIdentify():super("persian"); }
class CSSUrduIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUrduIdentify(); const CSSUrduIdentify():super("urdu"); }
class CSSTeluguIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTeluguIdentify(); const CSSTeluguIdentify():super("telugu"); }
class CSSTibetanIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTibetanIdentify(); const CSSTibetanIdentify():super("tibetan"); }
class CSSThaiIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSThaiIdentify(); const CSSThaiIdentify():super("thai"); }
class CSSLowerRomanIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLowerRomanIdentify(); const CSSLowerRomanIdentify():super("lowerRoman"); }
class CSSUpperRomanIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUpperRomanIdentify(); const CSSUpperRomanIdentify():super("upperRoman"); }
class CSSLowerGreekIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLowerGreekIdentify(); const CSSLowerGreekIdentify():super("lowerGreek"); }
class CSSLowerAlphaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLowerAlphaIdentify(); const CSSLowerAlphaIdentify():super("lowerAlpha"); }
class CSSLowerLatinIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLowerLatinIdentify(); const CSSLowerLatinIdentify():super("lowerLatin"); }
class CSSUpperAlphaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUpperAlphaIdentify(); const CSSUpperAlphaIdentify():super("upperAlpha"); }
class CSSUpperLatinIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUpperLatinIdentify(); const CSSUpperLatinIdentify():super("upperLatin"); }
class CSSCjkEarthlyBranchIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCjkEarthlyBranchIdentify(); const CSSCjkEarthlyBranchIdentify():super("cjkEarthlyBranch"); }
class CSSCjkHeavenlyStemIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCjkHeavenlyStemIdentify(); const CSSCjkHeavenlyStemIdentify():super("cjkHeavenlyStem"); }
class CSSEthiopicHalehameIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEthiopicHalehameIdentify(); const CSSEthiopicHalehameIdentify():super("ethiopicHalehame"); }
class CSSEthiopicHalehameAmIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEthiopicHalehameAmIdentify(); const CSSEthiopicHalehameAmIdentify():super("ethiopicHalehameAm"); }
class CSSEthiopicHalehameTiErIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEthiopicHalehameTiErIdentify(); const CSSEthiopicHalehameTiErIdentify():super("ethiopicHalehameTiEr"); }
class CSSEthiopicHalehameTiEtIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEthiopicHalehameTiEtIdentify(); const CSSEthiopicHalehameTiEtIdentify():super("ethiopicHalehameTiEt"); }
class CSSHangulIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHangulIdentify(); const CSSHangulIdentify():super("hangul"); }
class CSSHangulConsonantIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHangulConsonantIdentify(); const CSSHangulConsonantIdentify():super("hangulConsonant"); }
class CSSKoreanHangulFormalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSKoreanHangulFormalIdentify(); const CSSKoreanHangulFormalIdentify():super("koreanHangulFormal"); }
class CSSKoreanHanjaFormalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSKoreanHanjaFormalIdentify(); const CSSKoreanHanjaFormalIdentify():super("koreanHanjaFormal"); }
class CSSKoreanHanjaInformalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSKoreanHanjaInformalIdentify(); const CSSKoreanHanjaInformalIdentify():super("koreanHanjaInformal"); }
class CSSHebrewIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHebrewIdentify(); const CSSHebrewIdentify():super("hebrew"); }
class CSSArmenianIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSArmenianIdentify(); const CSSArmenianIdentify():super("armenian"); }
class CSSLowerArmenianIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLowerArmenianIdentify(); const CSSLowerArmenianIdentify():super("lowerArmenian"); }
class CSSUpperArmenianIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUpperArmenianIdentify(); const CSSUpperArmenianIdentify():super("upperArmenian"); }
class CSSGeorgianIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSGeorgianIdentify(); const CSSGeorgianIdentify():super("georgian"); }
class CSSCjkIdeographicIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCjkIdeographicIdentify(); const CSSCjkIdeographicIdentify():super("cjkIdeographic"); }
class CSSSimpChineseFormalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSimpChineseFormalIdentify(); const CSSSimpChineseFormalIdentify():super("simpChineseFormal"); }
class CSSSimpChineseInformalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSimpChineseInformalIdentify(); const CSSSimpChineseInformalIdentify():super("simpChineseInformal"); }
class CSSTradChineseFormalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTradChineseFormalIdentify(); const CSSTradChineseFormalIdentify():super("tradChineseFormal"); }
class CSSTradChineseInformalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTradChineseInformalIdentify(); const CSSTradChineseInformalIdentify():super("tradChineseInformal"); }
class CSSHiraganaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHiraganaIdentify(); const CSSHiraganaIdentify():super("hiragana"); }
class CSSKatakanaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSKatakanaIdentify(); const CSSKatakanaIdentify():super("katakana"); }
class CSSHiraganaIrohaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHiraganaIrohaIdentify(); const CSSHiraganaIrohaIdentify():super("hiraganaIroha"); }
class CSSKatakanaIrohaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSKatakanaIrohaIdentify(); const CSSKatakanaIrohaIdentify():super("katakanaIroha"); }
class CSSInlineIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInlineIdentify(); const CSSInlineIdentify():super("inline"); }
class CSSBlockIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBlockIdentify(); const CSSBlockIdentify():super("block"); }
class CSSFlowRootIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFlowRootIdentify(); const CSSFlowRootIdentify():super("flowRoot"); }
class CSSListItemIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSListItemIdentify(); const CSSListItemIdentify():super("listItem"); }
class CSSInlineBlockIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInlineBlockIdentify(); const CSSInlineBlockIdentify():super("inlineBlock"); }
class CSSTableIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTableIdentify(); const CSSTableIdentify():super("table"); }
class CSSInlineTableIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInlineTableIdentify(); const CSSInlineTableIdentify():super("inlineTable"); }
class CSSTableRowGroupIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTableRowGroupIdentify(); const CSSTableRowGroupIdentify():super("tableRowGroup"); }
class CSSTableHeaderGroupIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTableHeaderGroupIdentify(); const CSSTableHeaderGroupIdentify():super("tableHeaderGroup"); }
class CSSTableFooterGroupIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTableFooterGroupIdentify(); const CSSTableFooterGroupIdentify():super("tableFooterGroup"); }
class CSSTableRowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTableRowIdentify(); const CSSTableRowIdentify():super("tableRow"); }
class CSSTableColumnGroupIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTableColumnGroupIdentify(); const CSSTableColumnGroupIdentify():super("tableColumnGroup"); }
class CSSTableColumnIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTableColumnIdentify(); const CSSTableColumnIdentify():super("tableColumn"); }
class CSSTableCellIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTableCellIdentify(); const CSSTableCellIdentify():super("tableCell"); }
class CSSTableCaptionIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTableCaptionIdentify(); const CSSTableCaptionIdentify():super("tableCaption"); }
class CSSWebkitBoxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitBoxIdentify(); const CSSWebkitBoxIdentify():super("WebkitBox"); }
class CSSWebkitInlineBoxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitInlineBoxIdentify(); const CSSWebkitInlineBoxIdentify():super("WebkitInlineBox"); }
class CSSFlexIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFlexIdentify(); const CSSFlexIdentify():super("flex"); }
class CSSInlineFlexIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInlineFlexIdentify(); const CSSInlineFlexIdentify():super("inlineFlex"); }
class CSSGridIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSGridIdentify(); const CSSGridIdentify():super("grid"); }
class CSSInlineGridIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInlineGridIdentify(); const CSSInlineGridIdentify():super("inlineGrid"); }
class CSSContentsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSContentsIdentify(); const CSSContentsIdentify():super("contents"); }
class CSSWebkitFlexIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitFlexIdentify(); const CSSWebkitFlexIdentify():super("WebkitFlex"); }
class CSSWebkitInlineFlexIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitInlineFlexIdentify(); const CSSWebkitInlineFlexIdentify():super("WebkitInlineFlex"); }
class CSSAutoIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAutoIdentify(); const CSSAutoIdentify():super("auto"); }
class CSSCrosshairIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCrosshairIdentify(); const CSSCrosshairIdentify():super("crosshair"); }
class CSSDefaultIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDefaultIdentify(); const CSSDefaultIdentify():super("default"); }
class CSSPointerIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPointerIdentify(); const CSSPointerIdentify():super("pointer"); }
class CSSMoveIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMoveIdentify(); const CSSMoveIdentify():super("move"); }
class CSSVerticalTextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVerticalTextIdentify(); const CSSVerticalTextIdentify():super("verticalText"); }
class CSSCellIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCellIdentify(); const CSSCellIdentify():super("cell"); }
class CSSContextMenuIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSContextMenuIdentify(); const CSSContextMenuIdentify():super("contextMenu"); }
class CSSAliasIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAliasIdentify(); const CSSAliasIdentify():super("alias"); }
class CSSProgressIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSProgressIdentify(); const CSSProgressIdentify():super("progress"); }
class CSSNoDropIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNoDropIdentify(); const CSSNoDropIdentify():super("noDrop"); }
class CSSNotAllowedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNotAllowedIdentify(); const CSSNotAllowedIdentify():super("notAllowed"); }
class CSSZoomInIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSZoomInIdentify(); const CSSZoomInIdentify():super("zoomIn"); }
class CSSZoomOutIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSZoomOutIdentify(); const CSSZoomOutIdentify():super("zoomOut"); }
class CSSEResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEResizeIdentify(); const CSSEResizeIdentify():super("eResize"); }
class CSSNeResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNeResizeIdentify(); const CSSNeResizeIdentify():super("neResize"); }
class CSSNwResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNwResizeIdentify(); const CSSNwResizeIdentify():super("nwResize"); }
class CSSNResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNResizeIdentify(); const CSSNResizeIdentify():super("nResize"); }
class CSSSeResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSeResizeIdentify(); const CSSSeResizeIdentify():super("seResize"); }
class CSSSwResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSwResizeIdentify(); const CSSSwResizeIdentify():super("swResize"); }
class CSSSResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSResizeIdentify(); const CSSSResizeIdentify():super("sResize"); }
class CSSWResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWResizeIdentify(); const CSSWResizeIdentify():super("wResize"); }
class CSSEwResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEwResizeIdentify(); const CSSEwResizeIdentify():super("ewResize"); }
class CSSNsResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNsResizeIdentify(); const CSSNsResizeIdentify():super("nsResize"); }
class CSSNeswResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNeswResizeIdentify(); const CSSNeswResizeIdentify():super("neswResize"); }
class CSSNwseResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNwseResizeIdentify(); const CSSNwseResizeIdentify():super("nwseResize"); }
class CSSColResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSColResizeIdentify(); const CSSColResizeIdentify():super("colResize"); }
class CSSRowResizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRowResizeIdentify(); const CSSRowResizeIdentify():super("rowResize"); }
class CSSTextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTextIdentify(); const CSSTextIdentify():super("text"); }
class CSSWaitIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWaitIdentify(); const CSSWaitIdentify():super("wait"); }
class CSSHelpIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHelpIdentify(); const CSSHelpIdentify():super("help"); }
class CSSAllScrollIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAllScrollIdentify(); const CSSAllScrollIdentify():super("allScroll"); }
class CSSWebkitGrabIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitGrabIdentify(); const CSSWebkitGrabIdentify():super("WebkitGrab"); }
class CSSWebkitGrabbingIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitGrabbingIdentify(); const CSSWebkitGrabbingIdentify():super("WebkitGrabbing"); }
class CSSWebkitZoomInIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitZoomInIdentify(); const CSSWebkitZoomInIdentify():super("WebkitZoomIn"); }
class CSSWebkitZoomOutIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitZoomOutIdentify(); const CSSWebkitZoomOutIdentify():super("WebkitZoomOut"); }
class CSSLtrIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLtrIdentify(); const CSSLtrIdentify():super("ltr"); }
class CSSRtlIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRtlIdentify(); const CSSRtlIdentify():super("rtl"); }
class CSSCapitalizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCapitalizeIdentify(); const CSSCapitalizeIdentify():super("capitalize"); }
class CSSUppercaseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUppercaseIdentify(); const CSSUppercaseIdentify():super("uppercase"); }
class CSSLowercaseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLowercaseIdentify(); const CSSLowercaseIdentify():super("lowercase"); }
class CSSVisibleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVisibleIdentify(); const CSSVisibleIdentify():super("visible"); }
class CSSCollapseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCollapseIdentify(); const CSSCollapseIdentify():super("collapse"); }
class CSSA3Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSA3Identify(); const CSSA3Identify():super("a3"); }
class CSSA4Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSA4Identify(); const CSSA4Identify():super("a4"); }
class CSSA5Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSA5Identify(); const CSSA5Identify():super("a5"); }
class CSSAboveIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAboveIdentify(); const CSSAboveIdentify():super("above"); }
class CSSAbsoluteIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAbsoluteIdentify(); const CSSAbsoluteIdentify():super("absolute"); }
class CSSAlwaysIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAlwaysIdentify(); const CSSAlwaysIdentify():super("always"); }
class CSSAvoidIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAvoidIdentify(); const CSSAvoidIdentify():super("avoid"); }
class CSSB4Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSB4Identify(); const CSSB4Identify():super("b4"); }
class CSSB5Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSB5Identify(); const CSSB5Identify():super("b5"); }
class CSSBelowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBelowIdentify(); const CSSBelowIdentify():super("below"); }
class CSSBidiOverrideIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBidiOverrideIdentify(); const CSSBidiOverrideIdentify():super("bidiOverride"); }
class CSSBlinkIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBlinkIdentify(); const CSSBlinkIdentify():super("blink"); }
class CSSBothIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBothIdentify(); const CSSBothIdentify():super("both"); }
class CSSCloseQuoteIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCloseQuoteIdentify(); const CSSCloseQuoteIdentify():super("closeQuote"); }
class CSSEmbedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEmbedIdentify(); const CSSEmbedIdentify():super("embed"); }
class CSSFixedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFixedIdentify(); const CSSFixedIdentify():super("fixed"); }
class CSSHandIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHandIdentify(); const CSSHandIdentify():super("hand"); }
class CSSHideIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHideIdentify(); const CSSHideIdentify():super("hide"); }
class CSSIsolateIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSIsolateIdentify(); const CSSIsolateIdentify():super("isolate"); }
class CSSIsolateOverrideIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSIsolateOverrideIdentify(); const CSSIsolateOverrideIdentify():super("isolateOverride"); }
class CSSPlaintextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPlaintextIdentify(); const CSSPlaintextIdentify():super("plaintext"); }
class CSSWebkitIsolateIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitIsolateIdentify(); const CSSWebkitIsolateIdentify():super("WebkitIsolate"); }
class CSSWebkitIsolateOverrideIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitIsolateOverrideIdentify(); const CSSWebkitIsolateOverrideIdentify():super("WebkitIsolateOverride"); }
class CSSWebkitPlaintextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitPlaintextIdentify(); const CSSWebkitPlaintextIdentify():super("WebkitPlaintext"); }
class CSSLandscapeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLandscapeIdentify(); const CSSLandscapeIdentify():super("landscape"); }
class CSSLedgerIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLedgerIdentify(); const CSSLedgerIdentify():super("ledger"); }
class CSSLegalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLegalIdentify(); const CSSLegalIdentify():super("legal"); }
class CSSLetterIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLetterIdentify(); const CSSLetterIdentify():super("letter"); }
class CSSLineThroughIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLineThroughIdentify(); const CSSLineThroughIdentify():super("lineThrough"); }
class CSSLocalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLocalIdentify(); const CSSLocalIdentify():super("local"); }
class CSSNoCloseQuoteIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNoCloseQuoteIdentify(); const CSSNoCloseQuoteIdentify():super("noCloseQuote"); }
class CSSNoOpenQuoteIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNoOpenQuoteIdentify(); const CSSNoOpenQuoteIdentify():super("noOpenQuote"); }
class CSSNowrapIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNowrapIdentify(); const CSSNowrapIdentify():super("nowrap"); }
class CSSOpenQuoteIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOpenQuoteIdentify(); const CSSOpenQuoteIdentify():super("openQuote"); }
class CSSOverlayIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOverlayIdentify(); const CSSOverlayIdentify():super("overlay"); }
class CSSOverlineIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOverlineIdentify(); const CSSOverlineIdentify():super("overline"); }
class CSSPortraitIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPortraitIdentify(); const CSSPortraitIdentify():super("portrait"); }
class CSSPreIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPreIdentify(); const CSSPreIdentify():super("pre"); }
class CSSPreLineIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPreLineIdentify(); const CSSPreLineIdentify():super("preLine"); }
class CSSPreWrapIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPreWrapIdentify(); const CSSPreWrapIdentify():super("preWrap"); }
class CSSRelativeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRelativeIdentify(); const CSSRelativeIdentify():super("relative"); }
class CSSScrollIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSScrollIdentify(); const CSSScrollIdentify():super("scroll"); }
class CSSSeparateIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSeparateIdentify(); const CSSSeparateIdentify():super("separate"); }
class CSSShowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSShowIdentify(); const CSSShowIdentify():super("show"); }
class CSSStaticIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStaticIdentify(); const CSSStaticIdentify():super("static"); }
class CSSThickIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSThickIdentify(); const CSSThickIdentify():super("thick"); }
class CSSThinIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSThinIdentify(); const CSSThinIdentify():super("thin"); }
class CSSUnderlineIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUnderlineIdentify(); const CSSUnderlineIdentify():super("underline"); }
class CSSWavyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWavyIdentify(); const CSSWavyIdentify():super("wavy"); }
class CSSWebkitNowrapIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitNowrapIdentify(); const CSSWebkitNowrapIdentify():super("WebkitNowrap"); }
class CSSStretchIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStretchIdentify(); const CSSStretchIdentify():super("stretch"); }
class CSSStartIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStartIdentify(); const CSSStartIdentify():super("start"); }
class CSSEndIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEndIdentify(); const CSSEndIdentify():super("end"); }
class CSSCloneIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCloneIdentify(); const CSSCloneIdentify():super("clone"); }
class CSSSliceIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSliceIdentify(); const CSSSliceIdentify():super("slice"); }
class CSSReverseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSReverseIdentify(); const CSSReverseIdentify():super("reverse"); }
class CSSHorizontalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHorizontalIdentify(); const CSSHorizontalIdentify():super("horizontal"); }
class CSSVerticalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVerticalIdentify(); const CSSVerticalIdentify():super("vertical"); }
class CSSInlineAxisIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInlineAxisIdentify(); const CSSInlineAxisIdentify():super("inlineAxis"); }
class CSSBlockAxisIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBlockAxisIdentify(); const CSSBlockAxisIdentify():super("blockAxis"); }
class CSSSingleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSingleIdentify(); const CSSSingleIdentify():super("single"); }
class CSSMultipleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMultipleIdentify(); const CSSMultipleIdentify():super("multiple"); }
class CSSFlexStartIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFlexStartIdentify(); const CSSFlexStartIdentify():super("flexStart"); }
class CSSFlexEndIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFlexEndIdentify(); const CSSFlexEndIdentify():super("flexEnd"); }
class CSSSpaceBetweenIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSpaceBetweenIdentify(); const CSSSpaceBetweenIdentify():super("spaceBetween"); }
class CSSSpaceAroundIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSpaceAroundIdentify(); const CSSSpaceAroundIdentify():super("spaceAround"); }
class CSSSpaceEvenlyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSpaceEvenlyIdentify(); const CSSSpaceEvenlyIdentify():super("spaceEvenly"); }
class CSSUnsafeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUnsafeIdentify(); const CSSUnsafeIdentify():super("unsafe"); }
class CSSSafeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSafeIdentify(); const CSSSafeIdentify():super("safe"); }
class CSSRowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRowIdentify(); const CSSRowIdentify():super("row"); }
class CSSRowReverseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRowReverseIdentify(); const CSSRowReverseIdentify():super("rowReverse"); }
class CSSColumnIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSColumnIdentify(); const CSSColumnIdentify():super("column"); }
class CSSColumnReverseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSColumnReverseIdentify(); const CSSColumnReverseIdentify():super("columnReverse"); }
class CSSWrapIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWrapIdentify(); const CSSWrapIdentify():super("wrap"); }
class CSSWrapReverseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWrapReverseIdentify(); const CSSWrapReverseIdentify():super("wrapReverse"); }
class CSSAutoFlowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAutoFlowIdentify(); const CSSAutoFlowIdentify():super("autoFlow"); }
class CSSDenseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDenseIdentify(); const CSSDenseIdentify():super("dense"); }
class CSSReadOnlyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSReadOnlyIdentify(); const CSSReadOnlyIdentify():super("readOnly"); }
class CSSReadWriteIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSReadWriteIdentify(); const CSSReadWriteIdentify():super("readWrite"); }
class CSSReadWritePlaintextOnlyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSReadWritePlaintextOnlyIdentify(); const CSSReadWritePlaintextOnlyIdentify():super("readWritePlaintextOnly"); }
class CSSElementIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSElementIdentify(); const CSSElementIdentify():super("element"); }
class CSSWebkitMinContentIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitMinContentIdentify(); const CSSWebkitMinContentIdentify():super("WebkitMinContent"); }
class CSSWebkitMaxContentIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitMaxContentIdentify(); const CSSWebkitMaxContentIdentify():super("WebkitMaxContent"); }
class CSSWebkitFillAvailableIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitFillAvailableIdentify(); const CSSWebkitFillAvailableIdentify():super("WebkitFillAvailable"); }
class CSSWebkitFitContentIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitFitContentIdentify(); const CSSWebkitFitContentIdentify():super("WebkitFitContent"); }
class CSSMinContentIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMinContentIdentify(); const CSSMinContentIdentify():super("minContent"); }
class CSSMaxContentIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMaxContentIdentify(); const CSSMaxContentIdentify():super("maxContent"); }
class CSSFitContentIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFitContentIdentify(); const CSSFitContentIdentify():super("fitContent"); }
class CSSClipIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSClipIdentify(); const CSSClipIdentify():super("clip"); }
class CSSEllipsisIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEllipsisIdentify(); const CSSEllipsisIdentify():super("ellipsis"); }
class CSSDiscardIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDiscardIdentify(); const CSSDiscardIdentify():super("discard"); }
class CSSBreakAllIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBreakAllIdentify(); const CSSBreakAllIdentify():super("breakAll"); }
class CSSKeepAllIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSKeepAllIdentify(); const CSSKeepAllIdentify():super("keepAll"); }
class CSSBreakWordIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBreakWordIdentify(); const CSSBreakWordIdentify():super("breakWord"); }
class CSSSpaceIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSpaceIdentify(); const CSSSpaceIdentify():super("space"); }
class CSSLooseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLooseIdentify(); const CSSLooseIdentify():super("loose"); }
class CSSStrictIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStrictIdentify(); const CSSStrictIdentify():super("strict"); }
class CSSAfterWhiteSpaceIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAfterWhiteSpaceIdentify(); const CSSAfterWhiteSpaceIdentify():super("afterWhiteSpace"); }
class CSSManualIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSManualIdentify(); const CSSManualIdentify():super("manual"); }
class CSSCheckboxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCheckboxIdentify(); const CSSCheckboxIdentify():super("checkbox"); }
class CSSRadioIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRadioIdentify(); const CSSRadioIdentify():super("radio"); }
class CSSPushButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPushButtonIdentify(); const CSSPushButtonIdentify():super("pushButton"); }
class CSSSquareButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSquareButtonIdentify(); const CSSSquareButtonIdentify():super("squareButton"); }
class CSSButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSButtonIdentify(); const CSSButtonIdentify():super("button"); }
class CSSButtonBevelIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSButtonBevelIdentify(); const CSSButtonBevelIdentify():super("buttonBevel"); }
class CSSInnerSpinButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInnerSpinButtonIdentify(); const CSSInnerSpinButtonIdentify():super("innerSpinButton"); }
class CSSListboxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSListboxIdentify(); const CSSListboxIdentify():super("listbox"); }
class CSSListitemIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSListitemIdentify(); const CSSListitemIdentify():super("listitem"); }
class CSSMediaEnterFullscreenButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaEnterFullscreenButtonIdentify(); const CSSMediaEnterFullscreenButtonIdentify():super("mediaEnterFullscreenButton"); }
class CSSMediaExitFullscreenButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaExitFullscreenButtonIdentify(); const CSSMediaExitFullscreenButtonIdentify():super("mediaExitFullscreenButton"); }
class CSSMediaMuteButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaMuteButtonIdentify(); const CSSMediaMuteButtonIdentify():super("mediaMuteButton"); }
class CSSMediaPlayButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaPlayButtonIdentify(); const CSSMediaPlayButtonIdentify():super("mediaPlayButton"); }
class CSSMediaOverlayPlayButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaOverlayPlayButtonIdentify(); const CSSMediaOverlayPlayButtonIdentify():super("mediaOverlayPlayButton"); }
class CSSMediaToggleClosedCaptionsButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaToggleClosedCaptionsButtonIdentify(); const CSSMediaToggleClosedCaptionsButtonIdentify():super("mediaToggleClosedCaptionsButton"); }
class CSSMediaSliderIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaSliderIdentify(); const CSSMediaSliderIdentify():super("mediaSlider"); }
class CSSMediaSliderthumbIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaSliderthumbIdentify(); const CSSMediaSliderthumbIdentify():super("mediaSliderthumb"); }
class CSSMediaVolumeSliderContainerIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaVolumeSliderContainerIdentify(); const CSSMediaVolumeSliderContainerIdentify():super("mediaVolumeSliderContainer"); }
class CSSMediaVolumeSliderIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaVolumeSliderIdentify(); const CSSMediaVolumeSliderIdentify():super("mediaVolumeSlider"); }
class CSSMediaVolumeSliderthumbIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaVolumeSliderthumbIdentify(); const CSSMediaVolumeSliderthumbIdentify():super("mediaVolumeSliderthumb"); }
class CSSMediaControlsBackgroundIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaControlsBackgroundIdentify(); const CSSMediaControlsBackgroundIdentify():super("mediaControlsBackground"); }
class CSSMediaControlsFullscreenBackgroundIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaControlsFullscreenBackgroundIdentify(); const CSSMediaControlsFullscreenBackgroundIdentify():super("mediaControlsFullscreenBackground"); }
class CSSMediaCurrentTimeDisplayIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaCurrentTimeDisplayIdentify(); const CSSMediaCurrentTimeDisplayIdentify():super("mediaCurrentTimeDisplay"); }
class CSSMediaTimeRemainingDisplayIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMediaTimeRemainingDisplayIdentify(); const CSSMediaTimeRemainingDisplayIdentify():super("mediaTimeRemainingDisplay"); }
class CSSInternalMediaCastOffButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalMediaCastOffButtonIdentify(); const CSSInternalMediaCastOffButtonIdentify():super("InternalMediaCastOffButton"); }
class CSSInternalMediaOverlayCastOffButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalMediaOverlayCastOffButtonIdentify(); const CSSInternalMediaOverlayCastOffButtonIdentify():super("InternalMediaOverlayCastOffButton"); }
class CSSInternalMediaTrackSelectionCheckmarkIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalMediaTrackSelectionCheckmarkIdentify(); const CSSInternalMediaTrackSelectionCheckmarkIdentify():super("InternalMediaTrackSelectionCheckmark"); }
class CSSInternalMediaClosedCaptionsIconIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalMediaClosedCaptionsIconIdentify(); const CSSInternalMediaClosedCaptionsIconIdentify():super("InternalMediaClosedCaptionsIcon"); }
class CSSInternalMediaSubtitlesIconIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalMediaSubtitlesIconIdentify(); const CSSInternalMediaSubtitlesIconIdentify():super("InternalMediaSubtitlesIcon"); }
class CSSInternalMediaOverflowButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalMediaOverflowButtonIdentify(); const CSSInternalMediaOverflowButtonIdentify():super("InternalMediaOverflowButton"); }
class CSSInternalMediaDownloadButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalMediaDownloadButtonIdentify(); const CSSInternalMediaDownloadButtonIdentify():super("InternalMediaDownloadButton"); }
class CSSInternalMediaRemotingCastIconIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalMediaRemotingCastIconIdentify(); const CSSInternalMediaRemotingCastIconIdentify():super("InternalMediaRemotingCastIcon"); }
class CSSInternalMediaControlIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalMediaControlIdentify(); const CSSInternalMediaControlIdentify():super("InternalMediaControl"); }
class CSSMenulistIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMenulistIdentify(); const CSSMenulistIdentify():super("menulist"); }
class CSSMenulistButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMenulistButtonIdentify(); const CSSMenulistButtonIdentify():super("menulistButton"); }
class CSSMenulistTextIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMenulistTextIdentify(); const CSSMenulistTextIdentify():super("menulistText"); }
class CSSMenulistTextfieldIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMenulistTextfieldIdentify(); const CSSMenulistTextfieldIdentify():super("menulistTextfield"); }
class CSSMeterIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMeterIdentify(); const CSSMeterIdentify():super("meter"); }
class CSSProgressBarIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSProgressBarIdentify(); const CSSProgressBarIdentify():super("progressBar"); }
class CSSProgressBarValueIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSProgressBarValueIdentify(); const CSSProgressBarValueIdentify():super("progressBarValue"); }
class CSSSliderHorizontalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSliderHorizontalIdentify(); const CSSSliderHorizontalIdentify():super("sliderHorizontal"); }
class CSSSliderVerticalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSliderVerticalIdentify(); const CSSSliderVerticalIdentify():super("sliderVertical"); }
class CSSSliderthumbHorizontalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSliderthumbHorizontalIdentify(); const CSSSliderthumbHorizontalIdentify():super("sliderthumbHorizontal"); }
class CSSSliderthumbVerticalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSliderthumbVerticalIdentify(); const CSSSliderthumbVerticalIdentify():super("sliderthumbVertical"); }
class CSSCaretIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCaretIdentify(); const CSSCaretIdentify():super("caret"); }
class CSSSearchfieldIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSearchfieldIdentify(); const CSSSearchfieldIdentify():super("searchfield"); }
class CSSSearchfieldCancelButtonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSearchfieldCancelButtonIdentify(); const CSSSearchfieldCancelButtonIdentify():super("searchfieldCancelButton"); }
class CSSTextfieldIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTextfieldIdentify(); const CSSTextfieldIdentify():super("textfield"); }
class CSSTextareaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTextareaIdentify(); const CSSTextareaIdentify():super("textarea"); }
class CSSCapsLockIndicatorIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCapsLockIndicatorIdentify(); const CSSCapsLockIndicatorIdentify():super("capsLockIndicator"); }
class CSSRoundIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRoundIdentify(); const CSSRoundIdentify():super("round"); }
class CSSBorderIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBorderIdentify(); const CSSBorderIdentify():super("border"); }
class CSSBorderBoxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBorderBoxIdentify(); const CSSBorderBoxIdentify():super("borderBox"); }
class CSSContentIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSContentIdentify(); const CSSContentIdentify():super("content"); }
class CSSContentBoxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSContentBoxIdentify(); const CSSContentBoxIdentify():super("contentBox"); }
class CSSPaddingIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPaddingIdentify(); const CSSPaddingIdentify():super("padding"); }
class CSSPaddingBoxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPaddingBoxIdentify(); const CSSPaddingBoxIdentify():super("paddingBox"); }
class CSSMarginBoxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMarginBoxIdentify(); const CSSMarginBoxIdentify():super("marginBox"); }
class CSSContainIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSContainIdentify(); const CSSContainIdentify():super("contain"); }
class CSSCoverIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCoverIdentify(); const CSSCoverIdentify():super("cover"); }
class CSSLogicalIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLogicalIdentify(); const CSSLogicalIdentify():super("logical"); }
class CSSVisualIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVisualIdentify(); const CSSVisualIdentify():super("visual"); }
class CSSAlternateIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAlternateIdentify(); const CSSAlternateIdentify():super("alternate"); }
class CSSAlternateReverseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAlternateReverseIdentify(); const CSSAlternateReverseIdentify():super("alternateReverse"); }
class CSSForwardsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSForwardsIdentify(); const CSSForwardsIdentify():super("forwards"); }
class CSSBackwardsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBackwardsIdentify(); const CSSBackwardsIdentify():super("backwards"); }
class CSSInfiniteIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInfiniteIdentify(); const CSSInfiniteIdentify():super("infinite"); }
class CSSRunningIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRunningIdentify(); const CSSRunningIdentify():super("running"); }
class CSSPausedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPausedIdentify(); const CSSPausedIdentify():super("paused"); }
class CSSFlatIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFlatIdentify(); const CSSFlatIdentify():super("flat"); }
class CSSPreserve3dIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPreserve3dIdentify(); const CSSPreserve3dIdentify():super("preserve3d"); }
class CSSFillBoxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFillBoxIdentify(); const CSSFillBoxIdentify():super("fillBox"); }
class CSSViewBoxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSViewBoxIdentify(); const CSSViewBoxIdentify():super("viewBox"); }
class CSSEaseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEaseIdentify(); const CSSEaseIdentify():super("ease"); }
class CSSLinearIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLinearIdentify(); const CSSLinearIdentify():super("linear"); }
class CSSEaseInIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEaseInIdentify(); const CSSEaseInIdentify():super("easeIn"); }
class CSSEaseOutIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEaseOutIdentify(); const CSSEaseOutIdentify():super("easeOut"); }
class CSSEaseInOutIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEaseInOutIdentify(); const CSSEaseInOutIdentify():super("easeInOut"); }
class CSSStepStartIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStepStartIdentify(); const CSSStepStartIdentify():super("stepStart"); }
class CSSStepMiddleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStepMiddleIdentify(); const CSSStepMiddleIdentify():super("stepMiddle"); }
class CSSStepEndIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStepEndIdentify(); const CSSStepEndIdentify():super("stepEnd"); }
class CSSStepsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStepsIdentify(); const CSSStepsIdentify():super("steps"); }
class CSSFramesIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFramesIdentify(); const CSSFramesIdentify():super("frames"); }
class CSSCubicBezierIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCubicBezierIdentify(); const CSSCubicBezierIdentify():super("cubicBezier"); }
class CSSDocumentIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDocumentIdentify(); const CSSDocumentIdentify():super("document"); }
class CSSResetIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSResetIdentify(); const CSSResetIdentify():super("reset"); }
class CSSZoomIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSZoomIdentify(); const CSSZoomIdentify():super("zoom"); }
class CSSVisiblePaintedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVisiblePaintedIdentify(); const CSSVisiblePaintedIdentify():super("visiblePainted"); }
class CSSVisibleFillIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVisibleFillIdentify(); const CSSVisibleFillIdentify():super("visibleFill"); }
class CSSVisibleStrokeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVisibleStrokeIdentify(); const CSSVisibleStrokeIdentify():super("visibleStroke"); }
class CSSPaintedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPaintedIdentify(); const CSSPaintedIdentify():super("painted"); }
class CSSFillIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFillIdentify(); const CSSFillIdentify():super("fill"); }
class CSSStrokeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStrokeIdentify(); const CSSStrokeIdentify():super("stroke"); }
class CSSBoundingBoxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBoundingBoxIdentify(); const CSSBoundingBoxIdentify():super("boundingBox"); }
class CSSSpellOutIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSpellOutIdentify(); const CSSSpellOutIdentify():super("spellOut"); }
class CSSDigitsIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDigitsIdentify(); const CSSDigitsIdentify():super("digits"); }
class CSSLiteralPunctuationIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLiteralPunctuationIdentify(); const CSSLiteralPunctuationIdentify():super("literalPunctuation"); }
class CSSNoPunctuationIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNoPunctuationIdentify(); const CSSNoPunctuationIdentify():super("noPunctuation"); }
class CSSAntialiasedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAntialiasedIdentify(); const CSSAntialiasedIdentify():super("antialiased"); }
class CSSSubpixelAntialiasedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSubpixelAntialiasedIdentify(); const CSSSubpixelAntialiasedIdentify():super("subpixelAntialiased"); }
class CSSOptimizeSpeedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOptimizeSpeedIdentify(); const CSSOptimizeSpeedIdentify():super("optimizeSpeed"); }
class CSSOptimizeLegibilityIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOptimizeLegibilityIdentify(); const CSSOptimizeLegibilityIdentify():super("optimizeLegibility"); }
class CSSGeometricPrecisionIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSGeometricPrecisionIdentify(); const CSSGeometricPrecisionIdentify():super("geometricPrecision"); }
class CSSEconomyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEconomyIdentify(); const CSSEconomyIdentify():super("economy"); }
class CSSExactIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSExactIdentify(); const CSSExactIdentify():super("exact"); }
class CSSLrIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLrIdentify(); const CSSLrIdentify():super("lr"); }
class CSSRlIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRlIdentify(); const CSSRlIdentify():super("rl"); }
class CSSTbIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTbIdentify(); const CSSTbIdentify():super("tb"); }
class CSSLrTbIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLrTbIdentify(); const CSSLrTbIdentify():super("lrTb"); }
class CSSRlTbIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRlTbIdentify(); const CSSRlTbIdentify():super("rlTb"); }
class CSSTbRlIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTbRlIdentify(); const CSSTbRlIdentify():super("tbRl"); }
class CSSHorizontalTbIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHorizontalTbIdentify(); const CSSHorizontalTbIdentify():super("horizontalTb"); }
class CSSVerticalRlIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVerticalRlIdentify(); const CSSVerticalRlIdentify():super("verticalRl"); }
class CSSVerticalLrIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVerticalLrIdentify(); const CSSVerticalLrIdentify():super("verticalLr"); }
class CSSAfterIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAfterIdentify(); const CSSAfterIdentify():super("after"); }
class CSSBeforeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBeforeIdentify(); const CSSBeforeIdentify():super("before"); }
class CSSOverIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOverIdentify(); const CSSOverIdentify():super("over"); }
class CSSUnderIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUnderIdentify(); const CSSUnderIdentify():super("under"); }
class CSSFilledIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFilledIdentify(); const CSSFilledIdentify():super("filled"); }
class CSSOpenIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOpenIdentify(); const CSSOpenIdentify():super("open"); }
class CSSDotIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDotIdentify(); const CSSDotIdentify():super("dot"); }
class CSSDoubleCircleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDoubleCircleIdentify(); const CSSDoubleCircleIdentify():super("doubleCircle"); }
class CSSTriangleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTriangleIdentify(); const CSSTriangleIdentify():super("triangle"); }
class CSSSesameIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSesameIdentify(); const CSSSesameIdentify():super("sesame"); }
class CSSEllipseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEllipseIdentify(); const CSSEllipseIdentify():super("ellipse"); }
class CSSClosestSideIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSClosestSideIdentify(); const CSSClosestSideIdentify():super("closestSide"); }
class CSSClosestCornerIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSClosestCornerIdentify(); const CSSClosestCornerIdentify():super("closestCorner"); }
class CSSFarthestSideIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFarthestSideIdentify(); const CSSFarthestSideIdentify():super("farthestSide"); }
class CSSFarthestCornerIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFarthestCornerIdentify(); const CSSFarthestCornerIdentify():super("farthestCorner"); }
class CSSMixedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMixedIdentify(); const CSSMixedIdentify():super("mixed"); }
class CSSSidewaysIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSidewaysIdentify(); const CSSSidewaysIdentify():super("sideways"); }
class CSSSidewaysRightIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSidewaysRightIdentify(); const CSSSidewaysRightIdentify():super("sidewaysRight"); }
class CSSUprightIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUprightIdentify(); const CSSUprightIdentify():super("upright"); }
class CSSVerticalRightIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVerticalRightIdentify(); const CSSVerticalRightIdentify():super("verticalRight"); }
class CSSOnIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOnIdentify(); const CSSOnIdentify():super("on"); }
class CSSOffIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOffIdentify(); const CSSOffIdentify():super("off"); }
class CSSOptimizeQualityIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOptimizeQualityIdentify(); const CSSOptimizeQualityIdentify():super("optimizeQuality"); }
class CSSPixelatedIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPixelatedIdentify(); const CSSPixelatedIdentify():super("pixelated"); }
class CSSWebkitOptimizeContrastIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitOptimizeContrastIdentify(); const CSSWebkitOptimizeContrastIdentify():super("WebkitOptimizeContrast"); }
class CSSFromImageIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFromImageIdentify(); const CSSFromImageIdentify():super("fromImage"); }
class CSSNonzeroIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNonzeroIdentify(); const CSSNonzeroIdentify():super("nonzero"); }
class CSSEvenoddIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEvenoddIdentify(); const CSSEvenoddIdentify():super("evenodd"); }
class CSSAtIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAtIdentify(); const CSSAtIdentify():super("at"); }
class CSSAlphabeticIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAlphabeticIdentify(); const CSSAlphabeticIdentify():super("alphabetic"); }
class CSSFullscreenIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFullscreenIdentify(); const CSSFullscreenIdentify():super("fullscreen"); }
class CSSStandaloneIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStandaloneIdentify(); const CSSStandaloneIdentify():super("standalone"); }
class CSSMinimalUiIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMinimalUiIdentify(); const CSSMinimalUiIdentify():super("minimalUi"); }
class CSSBrowserIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBrowserIdentify(); const CSSBrowserIdentify():super("browser"); }
class CSSStickyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStickyIdentify(); const CSSStickyIdentify():super("sticky"); }
class CSSCoarseIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCoarseIdentify(); const CSSCoarseIdentify():super("coarse"); }
class CSSFineIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFineIdentify(); const CSSFineIdentify():super("fine"); }
class CSSOnDemandIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOnDemandIdentify(); const CSSOnDemandIdentify():super("onDemand"); }
class CSSHoverIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHoverIdentify(); const CSSHoverIdentify():super("hover"); }
class CSSMultiplyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMultiplyIdentify(); const CSSMultiplyIdentify():super("multiply"); }
class CSSScreenIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSScreenIdentify(); const CSSScreenIdentify():super("screen"); }
class CSSDarkenIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDarkenIdentify(); const CSSDarkenIdentify():super("darken"); }
class CSSLightenIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLightenIdentify(); const CSSLightenIdentify():super("lighten"); }
class CSSColorDodgeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSColorDodgeIdentify(); const CSSColorDodgeIdentify():super("colorDodge"); }
class CSSColorBurnIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSColorBurnIdentify(); const CSSColorBurnIdentify():super("colorBurn"); }
class CSSHardLightIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHardLightIdentify(); const CSSHardLightIdentify():super("hardLight"); }
class CSSSoftLightIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSoftLightIdentify(); const CSSSoftLightIdentify():super("softLight"); }
class CSSDifferenceIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDifferenceIdentify(); const CSSDifferenceIdentify():super("difference"); }
class CSSExclusionIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSExclusionIdentify(); const CSSExclusionIdentify():super("exclusion"); }
class CSSHueIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHueIdentify(); const CSSHueIdentify():super("hue"); }
class CSSSaturationIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSaturationIdentify(); const CSSSaturationIdentify():super("saturation"); }
class CSSColorIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSColorIdentify(); const CSSColorIdentify():super("color"); }
class CSSLuminosityIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLuminosityIdentify(); const CSSLuminosityIdentify():super("luminosity"); }
class CSSScaleDownIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSScaleDownIdentify(); const CSSScaleDownIdentify():super("scaleDown"); }
class CSSBalanceIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBalanceIdentify(); const CSSBalanceIdentify():super("balance"); }
class CSSWebkitPagedXIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitPagedXIdentify(); const CSSWebkitPagedXIdentify():super("WebkitPagedX"); }
class CSSWebkitPagedYIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitPagedYIdentify(); const CSSWebkitPagedYIdentify():super("WebkitPagedY"); }
class CSSDragIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDragIdentify(); const CSSDragIdentify():super("drag"); }
class CSSNoDragIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSNoDragIdentify(); const CSSNoDragIdentify():super("noDrag"); }
class CSSSpanIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSpanIdentify(); const CSSSpanIdentify():super("span"); }
class CSSMinmaxIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMinmaxIdentify(); const CSSMinmaxIdentify():super("minmax"); }
class CSSEachLineIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSEachLineIdentify(); const CSSEachLineIdentify():super("eachLine"); }
class CSSProgressiveIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSProgressiveIdentify(); const CSSProgressiveIdentify():super("progressive"); }
class CSSInterlaceIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInterlaceIdentify(); const CSSInterlaceIdentify():super("interlace"); }
class CSSMarkersIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMarkersIdentify(); const CSSMarkersIdentify():super("markers"); }
class CSSInternalExtendToZoomIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalExtendToZoomIdentify(); const CSSInternalExtendToZoomIdentify():super("InternalExtendToZoom"); }
class CSSPanXIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPanXIdentify(); const CSSPanXIdentify():super("panX"); }
class CSSPanYIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPanYIdentify(); const CSSPanYIdentify():super("panY"); }
class CSSPanLeftIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPanLeftIdentify(); const CSSPanLeftIdentify():super("panLeft"); }
class CSSPanRightIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPanRightIdentify(); const CSSPanRightIdentify():super("panRight"); }
class CSSPanUpIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPanUpIdentify(); const CSSPanUpIdentify():super("panUp"); }
class CSSPanDownIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPanDownIdentify(); const CSSPanDownIdentify():super("panDown"); }
class CSSManipulationIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSManipulationIdentify(); const CSSManipulationIdentify():super("manipulation"); }
class CSSPinchZoomIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPinchZoomIdentify(); const CSSPinchZoomIdentify():super("pinchZoom"); }
class CSSLastBaselineIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLastBaselineIdentify(); const CSSLastBaselineIdentify():super("lastBaseline"); }
class CSSFirstBaselineIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFirstBaselineIdentify(); const CSSFirstBaselineIdentify():super("firstBaseline"); }
class CSSFirstIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFirstIdentify(); const CSSFirstIdentify():super("first"); }
class CSSLastIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLastIdentify(); const CSSLastIdentify():super("last"); }
class CSSSelfStartIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSelfStartIdentify(); const CSSSelfStartIdentify():super("selfStart"); }
class CSSSelfEndIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSelfEndIdentify(); const CSSSelfEndIdentify():super("selfEnd"); }
class CSSLegacyIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLegacyIdentify(); const CSSLegacyIdentify():super("legacy"); }
class CSSSmoothIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSmoothIdentify(); const CSSSmoothIdentify():super("smooth"); }
class CSSScrollPositionIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSScrollPositionIdentify(); const CSSScrollPositionIdentify():super("scrollPosition"); }
class CSSRevertIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRevertIdentify(); const CSSRevertIdentify():super("revert"); }
class CSSUnsetIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUnsetIdentify(); const CSSUnsetIdentify():super("unset"); }
class CSSLinearGradientIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLinearGradientIdentify(); const CSSLinearGradientIdentify():super("linearGradient"); }
class CSSRadialGradientIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRadialGradientIdentify(); const CSSRadialGradientIdentify():super("radialGradient"); }
class CSSConicGradientIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSConicGradientIdentify(); const CSSConicGradientIdentify():super("conicGradient"); }
class CSSRepeatingLinearGradientIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRepeatingLinearGradientIdentify(); const CSSRepeatingLinearGradientIdentify():super("repeatingLinearGradient"); }
class CSSRepeatingRadialGradientIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRepeatingRadialGradientIdentify(); const CSSRepeatingRadialGradientIdentify():super("repeatingRadialGradient"); }
class CSSRepeatingConicGradientIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRepeatingConicGradientIdentify(); const CSSRepeatingConicGradientIdentify():super("repeatingConicGradient"); }
class CSSPaintIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPaintIdentify(); const CSSPaintIdentify():super("paint"); }
class CSSWebkitCrossFadeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitCrossFadeIdentify(); const CSSWebkitCrossFadeIdentify():super("WebkitCrossFade"); }
class CSSWebkitGradientIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitGradientIdentify(); const CSSWebkitGradientIdentify():super("WebkitGradient"); }
class CSSWebkitLinearGradientIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitLinearGradientIdentify(); const CSSWebkitLinearGradientIdentify():super("WebkitLinearGradient"); }
class CSSWebkitRadialGradientIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitRadialGradientIdentify(); const CSSWebkitRadialGradientIdentify():super("WebkitRadialGradient"); }
class CSSWebkitRepeatingLinearGradientIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitRepeatingLinearGradientIdentify(); const CSSWebkitRepeatingLinearGradientIdentify():super("WebkitRepeatingLinearGradient"); }
class CSSWebkitRepeatingRadialGradientIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitRepeatingRadialGradientIdentify(); const CSSWebkitRepeatingRadialGradientIdentify():super("WebkitRepeatingRadialGradient"); }
class CSSWebkitImageSetIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitImageSetIdentify(); const CSSWebkitImageSetIdentify():super("WebkitImageSet"); }
class CSSFromIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFromIdentify(); const CSSFromIdentify():super("from"); }
class CSSToIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSToIdentify(); const CSSToIdentify():super("to"); }
class CSSColorStopIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSColorStopIdentify(); const CSSColorStopIdentify():super("colorStop"); }
class CSSRadialIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRadialIdentify(); const CSSRadialIdentify():super("radial"); }
class CSSAttrIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAttrIdentify(); const CSSAttrIdentify():super("attr"); }
class CSSCounterIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCounterIdentify(); const CSSCounterIdentify():super("counter"); }
class CSSCountersIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCountersIdentify(); const CSSCountersIdentify():super("counters"); }
class CSSRectIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRectIdentify(); const CSSRectIdentify():super("rect"); }
class CSSPolygonIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPolygonIdentify(); const CSSPolygonIdentify():super("polygon"); }
class CSSFormatIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSFormatIdentify(); const CSSFormatIdentify():super("format"); }
class CSSInvertIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInvertIdentify(); const CSSInvertIdentify():super("invert"); }
class CSSGrayscaleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSGrayscaleIdentify(); const CSSGrayscaleIdentify():super("grayscale"); }
class CSSSepiaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSepiaIdentify(); const CSSSepiaIdentify():super("sepia"); }
class CSSSaturateIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSaturateIdentify(); const CSSSaturateIdentify():super("saturate"); }
class CSSHueRotateIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHueRotateIdentify(); const CSSHueRotateIdentify():super("hueRotate"); }
class CSSOpacityIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSOpacityIdentify(); const CSSOpacityIdentify():super("opacity"); }
class CSSBrightnessIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBrightnessIdentify(); const CSSBrightnessIdentify():super("brightness"); }
class CSSContrastIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSContrastIdentify(); const CSSContrastIdentify():super("contrast"); }
class CSSBlurIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSBlurIdentify(); const CSSBlurIdentify():super("blur"); }
class CSSDropShadowIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSDropShadowIdentify(); const CSSDropShadowIdentify():super("dropShadow"); }
class CSSUrlIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSUrlIdentify(); const CSSUrlIdentify():super("url"); }
class CSSRgbIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRgbIdentify(); const CSSRgbIdentify():super("rgb"); }
class CSSRgbaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRgbaIdentify(); const CSSRgbaIdentify():super("rgba"); }
class CSSHslIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHslIdentify(); const CSSHslIdentify():super("hsl"); }
class CSSHslaIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSHslaIdentify(); const CSSHslaIdentify():super("hsla"); }
class CSSMatrixIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMatrixIdentify(); const CSSMatrixIdentify():super("matrix"); }
class CSSMatrix3dIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMatrix3dIdentify(); const CSSMatrix3dIdentify():super("matrix3d"); }
class CSSPerspectiveIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPerspectiveIdentify(); const CSSPerspectiveIdentify():super("perspective"); }
class CSSRotateIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRotateIdentify(); const CSSRotateIdentify():super("rotate"); }
class CSSRotateXIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRotateXIdentify(); const CSSRotateXIdentify():super("rotateX"); }
class CSSRotateYIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRotateYIdentify(); const CSSRotateYIdentify():super("rotateY"); }
class CSSRotateZIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRotateZIdentify(); const CSSRotateZIdentify():super("rotateZ"); }
class CSSRotate3dIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRotate3dIdentify(); const CSSRotate3dIdentify():super("rotate3d"); }
class CSSScaleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSScaleIdentify(); const CSSScaleIdentify():super("scale"); }
class CSSScaleXIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSScaleXIdentify(); const CSSScaleXIdentify():super("scaleX"); }
class CSSScaleYIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSScaleYIdentify(); const CSSScaleYIdentify():super("scaleY"); }
class CSSScaleZIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSScaleZIdentify(); const CSSScaleZIdentify():super("scaleZ"); }
class CSSScale3dIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSScale3dIdentify(); const CSSScale3dIdentify():super("scale3d"); }
class CSSSkewIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSkewIdentify(); const CSSSkewIdentify():super("skew"); }
class CSSSkewXIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSkewXIdentify(); const CSSSkewXIdentify():super("skewX"); }
class CSSSkewYIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSkewYIdentify(); const CSSSkewYIdentify():super("skewY"); }
class CSSTranslateIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTranslateIdentify(); const CSSTranslateIdentify():super("translate"); }
class CSSTranslateXIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTranslateXIdentify(); const CSSTranslateXIdentify():super("translateX"); }
class CSSTranslateYIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTranslateYIdentify(); const CSSTranslateYIdentify():super("translateY"); }
class CSSTranslateZIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTranslateZIdentify(); const CSSTranslateZIdentify():super("translateZ"); }
class CSSTranslate3dIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSTranslate3dIdentify(); const CSSTranslate3dIdentify():super("translate3d"); }
class CSSPathIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPathIdentify(); const CSSPathIdentify():super("path"); }
class CSSRayIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRayIdentify(); const CSSRayIdentify():super("ray"); }
class CSSSidesIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSidesIdentify(); const CSSSidesIdentify():super("sides"); }
class CSSCalcIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSCalcIdentify(); const CSSCalcIdentify():super("calc"); }
class CSSWebkitCalcIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSWebkitCalcIdentify(); const CSSWebkitCalcIdentify():super("WebkitCalc"); }
class CSSXIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSXIdentify(); const CSSXIdentify():super("x"); }
class CSSYIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSYIdentify(); const CSSYIdentify():super("y"); }
class CSSMandatoryIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSMandatoryIdentify(); const CSSMandatoryIdentify():super("mandatory"); }
class CSSProximityIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSProximityIdentify(); const CSSProximityIdentify():super("proximity"); }
class CSSStyleIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSStyleIdentify(); const CSSStyleIdentify():super("style"); }
class CSSLayoutIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSLayoutIdentify(); const CSSLayoutIdentify():super("layout"); }
class CSSSizeIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSSizeIdentify(); const CSSSizeIdentify():super("size"); }
class CSSAutoFillIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAutoFillIdentify(); const CSSAutoFillIdentify():super("autoFill"); }
class CSSAutoFitIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAutoFitIdentify(); const CSSAutoFitIdentify():super("autoFit"); }
class CSSVarIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVarIdentify(); const CSSVarIdentify():super("var"); }
class CSSInternalVariableValueIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSInternalVariableValueIdentify(); const CSSInternalVariableValueIdentify():super("InternalVariableValue"); }
class CSSAvoidPageIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAvoidPageIdentify(); const CSSAvoidPageIdentify():super("avoidPage"); }
class CSSPageIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSPageIdentify(); const CSSPageIdentify():super("page"); }
class CSSRectoIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRectoIdentify(); const CSSRectoIdentify():super("recto"); }
class CSSVersoIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSVersoIdentify(); const CSSVersoIdentify():super("verso"); }
class CSSAvoidColumnIdentify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSAvoidColumnIdentify(); const CSSAvoidColumnIdentify():super("avoidColumn"); }
class CSSP3Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSP3Identify(); const CSSP3Identify():super("p3"); }
class CSSRec2020Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSSRec2020Identify(); const CSSRec2020Identify():super("rec2020"); }

class CSS100Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSS100Identify(); const CSS100Identify():super("100"); }
class CSS200Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSS200Identify(); const CSS200Identify():super("200"); }
class CSS300Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSS300Identify(); const CSS300Identify():super("300"); }
class CSS400Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSS400Identify(); const CSS400Identify():super("400"); }
class CSS500Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSS500Identify(); const CSS500Identify():super("500"); }
class CSS600Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSS600Identify(); const CSS600Identify():super("600"); }
class CSS700Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSS700Identify(); const CSS700Identify():super("700"); }
class CSS800Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSS800Identify(); const CSS800Identify():super("800"); }
class CSS900Identify extends CSSKnownIdentify{ static get() {return _instance;} static const _instance = const CSS900Identify(); const CSS900Identify():super("900"); }
