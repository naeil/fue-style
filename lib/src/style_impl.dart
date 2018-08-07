
part of css;



class _PropertyKeyMapItem{
    final int index;
    final String group;
    const _PropertyKeyMapItem(this.index, this.group);
}

class DefaultStyle{

  /// color
  static final color = new TypedStyleProperty<CSSColor>( initial : new CSSColor(0xff000000), allow : [CSSColor, CSSTransparentIdentify] );

  /// font
  static final font = new SHStyleProperty( order : StylePropertyOrder.orderOfAppearance, computed : [fontStyle, fontWeight, fontSize, fontFamily] );

  /// font group
  static final fontStyle = new TypedStyleProperty<CSSIdentify>( initial : CSSNormalIdentify.get(), allow : [CSSNormalIdentify, CSSItalicIdentify, CSSObliqueIdentify, CSSInitialIdentify, CSSInheritIdentify] );
  static final fontWeight = new TypedStyleProperty<CSSIdentify>( initial : CSSNormalIdentify.get(), allow : [CSSNormalIdentify, CSSBoldIdentify, CSSBolderIdentify, CSSLighterIdentify, CSSInitialIdentify, CSSInheritIdentify, CSS100Identify, CSS200Identify, CSS300Identify, CSS400Identify, CSS500Identify, CSS600Identify, CSS700Identify, CSS800Identify, CSS900Identify] );
  static final fontSize = new LHStyleProperty( initial : CSSMediumIdentify.get(), allow : [CSSSize, CSSMediumIdentify, CSSXxSmallIdentify, CSSXSmallIdentify, CSSSmallIdentify, CSSLargeIdentify, CSSXLargeIdentify, CSSXxLargeIdentify, CSSSmallerIdentify, CSSLargerIdentify, CSSInitialIdentify, CSSInheritIdentify] );
  static final fontFamily = new TypedStyleProperty<CSSIdentify>( initial : CSSDefaultIdentify.get(), allow : [CSSIdentify, CSSDefaultIdentify] );

  /// background
  static final background = new SHStyleProperty( order : StylePropertyOrder.orderOfAppearance, computed : [backgroundColor, backgroundImage, backgroundPositionX, backgroundPositionY, backgroundRepeat] );

  /// background group
  static final backgroundColor = new LHStyleProperty( initial : CSSTransparentIdentify.get(), allow : [CSSColor, CSSTransparentIdentify] );
  static final backgroundImage = new LHStyleProperty( initial : CSSNoneIdentify.get(), allow : [CSSUrl, CSSNoneIdentify] );
  static final backgroundPositionX = new LHStyleProperty( initial : new CSSSize(50, CSSUnit.percent), allow : [CSSSize, CSSLeftIdentify, CSSRightIdentify, CSSCenterIdentify, CSSInitialIdentify, CSSInheritIdentify] );
  static final backgroundPositionY = new LHStyleProperty( initial : new CSSSize(50, CSSUnit.percent), allow : [CSSSize, CSSTopIdentify, CSSBottomIdentify, CSSCenterIdentify, CSSInitialIdentify, CSSInheritIdentify] );
  static final backgroundRepeat = new LHStyleProperty( initial : CSSRepeatIdentify.get(), allow : [CSSRepeatIdentify, CSSRepeatXIdentify, CSSRepeatYIdentify, CSSNoRepeatIdentify, CSSInitialIdentify, CSSInheritIdentify] );

  /// background-size
  static final backgroundSize = new SHStyleProperty( initial : CSSNoneIdentify.get(), order : StylePropertyOrder.uniqueOrder, computed : [backgroundSizeX, backgroundSizeY] );

  /// background-size group
  static final backgroundSizeX = new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSCoverIdentify, CSSContainIdentify, CSSInitialIdentify, CSSInheritIdentify] );
  static final backgroundSizeY = new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSCoverIdentify, CSSContainIdentify, CSSInitialIdentify, CSSInheritIdentify] );

  /// text-decoration
  static final textDecoration = new SHStyleProperty( order : StylePropertyOrder.orderOfAppearance, computed : [textDecorationColor, textDecorationStyle, textDecorationLine] );

  /// text-decoration group
  static final textDecorationColor = new TypedStyleProperty<CSSColor>( initial : new CSSColor(0xff000000), allow : [CSSColor, CSSTransparentIdentify] );
  static final textDecorationStyle = new TypedStyleProperty<CSSIdentify>( initial : CSSSolidIdentify.get(), allow : [CSSSolidIdentify, CSSDoubleIdentify, CSSDottedIdentify, CSSDashedIdentify, CSSWavyIdentify] );
  static final textDecorationLine = new TypedStyleProperty<CSSIdentify>( initial : CSSNoneIdentify.get(), allow : [CSSNoneIdentify, CSSUnderlineIdentify, CSSOverlineIdentify, CSSLineThroughIdentify] );

  /// width
  static final width = new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] );

  /// height
  static final height = new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] );

  /// min-width
  static final minWidth = new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] );

  /// min-height
  static final minHeight = new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] );

  /// max-width
  static final maxWidth = new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] );

  /// max-height
  static final maxHeight = new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] );

  /// padding
  static final padding = new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [paddingTop, paddingRight, paddingBottom, paddingLeft] );

  /// padding group
  static final paddingTop = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] );
  static final paddingRight = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] );
  static final paddingBottom = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] );
  static final paddingLeft = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] );

  /// margin
  static final margin = new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [marginTop, marginRight, marginBottom, marginLeft] );

  /// margin group
  static final marginTop = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] );
  static final marginRight = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] );
  static final marginBottom = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] );
  static final marginLeft = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] );

  /// border
  static final border = new SHStyleProperty( order : StylePropertyOrder.orderOfAppearance, computed : [borderWidth, borderColor, borderStyle] );

  /// border group
  static final borderWidth = new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [borderTopWidth, borderRightWidth, borderBottomWidth, borderLeftWidth] );
  static final borderColor = new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [borderTopColor, borderRightColor, borderBottomColor, borderLeftColor] );
  static final borderStyle = new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [borderTopStyle, borderRightStyle, borderBottomStyle, borderLeftStyle] );

  /// border-width group
  static final borderTopWidth = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] );
  static final borderRightWidth = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] );
  static final borderBottomWidth = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] );
  static final borderLeftWidth = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] );

  /// border-color group
  static final borderTopColor = new TypedStyleProperty<CSSColor>( initial : new CSSColor(0), allow : [CSSColor, CSSTransparentIdentify] );
  static final borderRightColor = new TypedStyleProperty<CSSColor>( initial : new CSSColor(0), allow : [CSSColor, CSSTransparentIdentify] );
  static final borderBottomColor = new TypedStyleProperty<CSSColor>( initial : new CSSColor(0), allow : [CSSColor, CSSTransparentIdentify] );
  static final borderLeftColor = new TypedStyleProperty<CSSColor>( initial : new CSSColor(0), allow : [CSSColor, CSSTransparentIdentify] );

  /// border-style group
  static final borderTopStyle = new TypedStyleProperty<CSSIdentify>( initial : CSSNoneIdentify.get(), allow : [CSSNoneIdentify, CSSHiddenIdentify, CSSDottedIdentify, CSSDashedIdentify, CSSSolidIdentify, CSSDoubleIdentify, CSSGrooveIdentify, CSSRidgeIdentify, CSSInsetIdentify, CSSOutsetIdentify] );
  static final borderRightStyle = new TypedStyleProperty<CSSIdentify>( initial : CSSNoneIdentify.get(), allow : [CSSNoneIdentify, CSSHiddenIdentify, CSSDottedIdentify, CSSDashedIdentify, CSSSolidIdentify, CSSDoubleIdentify, CSSGrooveIdentify, CSSRidgeIdentify, CSSInsetIdentify, CSSOutsetIdentify] );
  static final borderBottomStyle = new TypedStyleProperty<CSSIdentify>( initial : CSSNoneIdentify.get(), allow : [CSSNoneIdentify, CSSHiddenIdentify, CSSDottedIdentify, CSSDashedIdentify, CSSSolidIdentify, CSSDoubleIdentify, CSSGrooveIdentify, CSSRidgeIdentify, CSSInsetIdentify, CSSOutsetIdentify] );
  static final borderLeftStyle = new TypedStyleProperty<CSSIdentify>( initial : CSSNoneIdentify.get(), allow : [CSSNoneIdentify, CSSHiddenIdentify, CSSDottedIdentify, CSSDashedIdentify, CSSSolidIdentify, CSSDoubleIdentify, CSSGrooveIdentify, CSSRidgeIdentify, CSSInsetIdentify, CSSOutsetIdentify] );

  /// border-radius
  static final borderRadius = new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [borderTopLeftRadius, borderTopRightRadius, borderBottomRightRadius, borderBottomLeftRadius] );

  /// border-radius group
  static final borderTopLeftRadius = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] );
  static final borderTopRightRadius = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] );
  static final borderBottomRightRadius = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] );
  static final borderBottomLeftRadius = new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] );
}




abstract class StyleImpl{

  static const propertyNames = const [
    "color",
    "font",
    "font-style",
    "font-weight",
    "font-size",
    "font-family",
    "background",
    "background-color",
    "background-image",
    "background-position-x",
    "background-position-y",
    "background-repeat",
    "background-size",
    "background-size-x",
    "background-size-y",
    "text-decoration",
    "text-decoration-color",
    "text-decoration-style",
    "text-decoration-line",
    "width",
    "height",
    "min-width",
    "min-height",
    "max-width",
    "max-height",
    "padding",
    "padding-top",
    "padding-right",
    "padding-bottom",
    "padding-left",
    "margin",
    "margin-top",
    "margin-right",
    "margin-bottom",
    "margin-left",
    "border",
    "border-width",
    "border-color",
    "border-style",
    "border-top-width",
    "border-right-width",
    "border-bottom-width",
    "border-left-width",
    "border-top-color",
    "border-right-color",
    "border-bottom-color",
    "border-left-color",
    "border-top-style",
    "border-right-style",
    "border-bottom-style",
    "border-left-style",
    "border-radius",
    "border-top-left-radius",
    "border-top-right-radius",
    "border-bottom-right-radius",
    "border-bottom-left-radius",
  ];

  static const propertyKeyMap = const {
    "color" : const _PropertyKeyMapItem(0, ""),
    "font" : const _PropertyKeyMapItem(1, ""),
    "font-style" : const _PropertyKeyMapItem(2, "font"),
    "font-weight" : const _PropertyKeyMapItem(3, "font"),
    "font-size" : const _PropertyKeyMapItem(4, "font"),
    "font-family" : const _PropertyKeyMapItem(5, "font"),
    "background" : const _PropertyKeyMapItem(6, ""),
    "background-color" : const _PropertyKeyMapItem(7, "background"),
    "background-image" : const _PropertyKeyMapItem(8, "background"),
    "background-position-x" : const _PropertyKeyMapItem(9, "background"),
    "background-position-y" : const _PropertyKeyMapItem(10, "background"),
    "background-repeat" : const _PropertyKeyMapItem(11, "background"),
    "background-size" : const _PropertyKeyMapItem(12, ""),
    "background-size-x" : const _PropertyKeyMapItem(13, "background-size"),
    "background-size-y" : const _PropertyKeyMapItem(14, "background-size"),
    "text-decoration" : const _PropertyKeyMapItem(15, ""),
    "text-decoration-color" : const _PropertyKeyMapItem(16, "text-decoration"),
    "text-decoration-style" : const _PropertyKeyMapItem(17, "text-decoration"),
    "text-decoration-line" : const _PropertyKeyMapItem(18, "text-decoration"),
    "width" : const _PropertyKeyMapItem(19, ""),
    "height" : const _PropertyKeyMapItem(20, ""),
    "min-width" : const _PropertyKeyMapItem(21, ""),
    "min-height" : const _PropertyKeyMapItem(22, ""),
    "max-width" : const _PropertyKeyMapItem(23, ""),
    "max-height" : const _PropertyKeyMapItem(24, ""),
    "padding" : const _PropertyKeyMapItem(25, ""),
    "padding-top" : const _PropertyKeyMapItem(26, "padding"),
    "padding-right" : const _PropertyKeyMapItem(27, "padding"),
    "padding-bottom" : const _PropertyKeyMapItem(28, "padding"),
    "padding-left" : const _PropertyKeyMapItem(29, "padding"),
    "margin" : const _PropertyKeyMapItem(30, ""),
    "margin-top" : const _PropertyKeyMapItem(31, "margin"),
    "margin-right" : const _PropertyKeyMapItem(32, "margin"),
    "margin-bottom" : const _PropertyKeyMapItem(33, "margin"),
    "margin-left" : const _PropertyKeyMapItem(34, "margin"),
    "border" : const _PropertyKeyMapItem(35, ""),
    "border-width" : const _PropertyKeyMapItem(36, "border"),
    "border-color" : const _PropertyKeyMapItem(37, "border"),
    "border-style" : const _PropertyKeyMapItem(38, "border"),
    "border-top-width" : const _PropertyKeyMapItem(39, "border-width"),
    "border-right-width" : const _PropertyKeyMapItem(40, "border-width"),
    "border-bottom-width" : const _PropertyKeyMapItem(41, "border-width"),
    "border-left-width" : const _PropertyKeyMapItem(42, "border-width"),
    "border-top-color" : const _PropertyKeyMapItem(43, "border-color"),
    "border-right-color" : const _PropertyKeyMapItem(44, "border-color"),
    "border-bottom-color" : const _PropertyKeyMapItem(45, "border-color"),
    "border-left-color" : const _PropertyKeyMapItem(46, "border-color"),
    "border-top-style" : const _PropertyKeyMapItem(47, "border-style"),
    "border-right-style" : const _PropertyKeyMapItem(48, "border-style"),
    "border-bottom-style" : const _PropertyKeyMapItem(49, "border-style"),
    "border-left-style" : const _PropertyKeyMapItem(50, "border-style"),
    "border-radius" : const _PropertyKeyMapItem(51, ""),
    "border-top-left-radius" : const _PropertyKeyMapItem(52, "border-radius"),
    "border-top-right-radius" : const _PropertyKeyMapItem(53, "border-radius"),
    "border-bottom-right-radius" : const _PropertyKeyMapItem(54, "border-radius"),
    "border-bottom-left-radius" : const _PropertyKeyMapItem(55, "border-radius"),
    "fontStyle" : const _PropertyKeyMapItem(2, "font"),
    "fontWeight" : const _PropertyKeyMapItem(3, "font"),
    "fontSize" : const _PropertyKeyMapItem(4, "font"),
    "fontFamily" : const _PropertyKeyMapItem(5, "font"),
    "backgroundColor" : const _PropertyKeyMapItem(7, "background"),
    "backgroundImage" : const _PropertyKeyMapItem(8, "background"),
    "backgroundPositionX" : const _PropertyKeyMapItem(9, "background"),
    "backgroundPositionY" : const _PropertyKeyMapItem(10, "background"),
    "backgroundRepeat" : const _PropertyKeyMapItem(11, "background"),
    "backgroundSize" : const _PropertyKeyMapItem(12, ""),
    "backgroundSizeX" : const _PropertyKeyMapItem(13, "background-size"),
    "backgroundSizeY" : const _PropertyKeyMapItem(14, "background-size"),
    "textDecoration" : const _PropertyKeyMapItem(15, ""),
    "textDecorationColor" : const _PropertyKeyMapItem(16, "text-decoration"),
    "textDecorationStyle" : const _PropertyKeyMapItem(17, "text-decoration"),
    "textDecorationLine" : const _PropertyKeyMapItem(18, "text-decoration"),
    "minWidth" : const _PropertyKeyMapItem(21, ""),
    "minHeight" : const _PropertyKeyMapItem(22, ""),
    "maxWidth" : const _PropertyKeyMapItem(23, ""),
    "maxHeight" : const _PropertyKeyMapItem(24, ""),
    "paddingTop" : const _PropertyKeyMapItem(26, "padding"),
    "paddingRight" : const _PropertyKeyMapItem(27, "padding"),
    "paddingBottom" : const _PropertyKeyMapItem(28, "padding"),
    "paddingLeft" : const _PropertyKeyMapItem(29, "padding"),
    "marginTop" : const _PropertyKeyMapItem(31, "margin"),
    "marginRight" : const _PropertyKeyMapItem(32, "margin"),
    "marginBottom" : const _PropertyKeyMapItem(33, "margin"),
    "marginLeft" : const _PropertyKeyMapItem(34, "margin"),
    "borderWidth" : const _PropertyKeyMapItem(36, "border"),
    "borderColor" : const _PropertyKeyMapItem(37, "border"),
    "borderStyle" : const _PropertyKeyMapItem(38, "border"),
    "borderTopWidth" : const _PropertyKeyMapItem(39, "border-width"),
    "borderRightWidth" : const _PropertyKeyMapItem(40, "border-width"),
    "borderBottomWidth" : const _PropertyKeyMapItem(41, "border-width"),
    "borderLeftWidth" : const _PropertyKeyMapItem(42, "border-width"),
    "borderTopColor" : const _PropertyKeyMapItem(43, "border-color"),
    "borderRightColor" : const _PropertyKeyMapItem(44, "border-color"),
    "borderBottomColor" : const _PropertyKeyMapItem(45, "border-color"),
    "borderLeftColor" : const _PropertyKeyMapItem(46, "border-color"),
    "borderTopStyle" : const _PropertyKeyMapItem(47, "border-style"),
    "borderRightStyle" : const _PropertyKeyMapItem(48, "border-style"),
    "borderBottomStyle" : const _PropertyKeyMapItem(49, "border-style"),
    "borderLeftStyle" : const _PropertyKeyMapItem(50, "border-style"),
    "borderRadius" : const _PropertyKeyMapItem(51, ""),
    "borderTopLeftRadius" : const _PropertyKeyMapItem(52, "border-radius"),
    "borderTopRightRadius" : const _PropertyKeyMapItem(53, "border-radius"),
    "borderBottomRightRadius" : const _PropertyKeyMapItem(54, "border-radius"),
    "borderBottomLeftRadius" : const _PropertyKeyMapItem(55, "border-radius"),
  };


  get parent;

  StyleImpl _defaultStyle;

  StyleImpl get defaultStyle => _defaultStyle;

  set defaultStyle(v) {
    _defaultStyle = v;
  }

  StyleImpl();

  didChangeProperty(int idx, newValue){

  }

  getProperty(name, [ internalValue = false ]){
    if(name is String)
      name = propertyKeyMap[name]?.index;
    if(name == null)
      return null;
    switch(name){
      case 0 : return internalValue ? _color : color;
      case 1 : return internalValue ? _font : font;
      case 2 : return internalValue ? _fontStyle : fontStyle;
      case 3 : return internalValue ? _fontWeight : fontWeight;
      case 4 : return internalValue ? _fontSize : fontSize;
      case 5 : return internalValue ? _fontFamily : fontFamily;
      case 6 : return internalValue ? _background : background;
      case 7 : return internalValue ? _backgroundColor : backgroundColor;
      case 8 : return internalValue ? _backgroundImage : backgroundImage;
      case 9 : return internalValue ? _backgroundPositionX : backgroundPositionX;
      case 10 : return internalValue ? _backgroundPositionY : backgroundPositionY;
      case 11 : return internalValue ? _backgroundRepeat : backgroundRepeat;
      case 12 : return internalValue ? _backgroundSize : backgroundSize;
      case 13 : return internalValue ? _backgroundSizeX : backgroundSizeX;
      case 14 : return internalValue ? _backgroundSizeY : backgroundSizeY;
      case 15 : return internalValue ? _textDecoration : textDecoration;
      case 16 : return internalValue ? _textDecorationColor : textDecorationColor;
      case 17 : return internalValue ? _textDecorationStyle : textDecorationStyle;
      case 18 : return internalValue ? _textDecorationLine : textDecorationLine;
      case 19 : return internalValue ? _width : width;
      case 20 : return internalValue ? _height : height;
      case 21 : return internalValue ? _minWidth : minWidth;
      case 22 : return internalValue ? _minHeight : minHeight;
      case 23 : return internalValue ? _maxWidth : maxWidth;
      case 24 : return internalValue ? _maxHeight : maxHeight;
      case 25 : return internalValue ? _padding : padding;
      case 26 : return internalValue ? _paddingTop : paddingTop;
      case 27 : return internalValue ? _paddingRight : paddingRight;
      case 28 : return internalValue ? _paddingBottom : paddingBottom;
      case 29 : return internalValue ? _paddingLeft : paddingLeft;
      case 30 : return internalValue ? _margin : margin;
      case 31 : return internalValue ? _marginTop : marginTop;
      case 32 : return internalValue ? _marginRight : marginRight;
      case 33 : return internalValue ? _marginBottom : marginBottom;
      case 34 : return internalValue ? _marginLeft : marginLeft;
      case 35 : return internalValue ? _border : border;
      case 36 : return internalValue ? _borderWidth : borderWidth;
      case 37 : return internalValue ? _borderColor : borderColor;
      case 38 : return internalValue ? _borderStyle : borderStyle;
      case 39 : return internalValue ? _borderTopWidth : borderTopWidth;
      case 40 : return internalValue ? _borderRightWidth : borderRightWidth;
      case 41 : return internalValue ? _borderBottomWidth : borderBottomWidth;
      case 42 : return internalValue ? _borderLeftWidth : borderLeftWidth;
      case 43 : return internalValue ? _borderTopColor : borderTopColor;
      case 44 : return internalValue ? _borderRightColor : borderRightColor;
      case 45 : return internalValue ? _borderBottomColor : borderBottomColor;
      case 46 : return internalValue ? _borderLeftColor : borderLeftColor;
      case 47 : return internalValue ? _borderTopStyle : borderTopStyle;
      case 48 : return internalValue ? _borderRightStyle : borderRightStyle;
      case 49 : return internalValue ? _borderBottomStyle : borderBottomStyle;
      case 50 : return internalValue ? _borderLeftStyle : borderLeftStyle;
      case 51 : return internalValue ? _borderRadius : borderRadius;
      case 52 : return internalValue ? _borderTopLeftRadius : borderTopLeftRadius;
      case 53 : return internalValue ? _borderTopRightRadius : borderTopRightRadius;
      case 54 : return internalValue ? _borderBottomRightRadius : borderBottomRightRadius;
      case 55 : return internalValue ? _borderBottomLeftRadius : borderBottomLeftRadius;
    }
  }

  setProperty(name, value){
    if(name is String)
      name = propertyKeyMap[name]?.index;
    if(name == null)
      return null;
    switch(name){
      case 0 : return color = value;
      case 1 : return font = value;
      case 2 : return fontStyle = value;
      case 3 : return fontWeight = value;
      case 4 : return fontSize = value;
      case 5 : return fontFamily = value;
      case 6 : return background = value;
      case 7 : return backgroundColor = value;
      case 8 : return backgroundImage = value;
      case 9 : return backgroundPositionX = value;
      case 10 : return backgroundPositionY = value;
      case 11 : return backgroundRepeat = value;
      case 12 : return backgroundSize = value;
      case 13 : return backgroundSizeX = value;
      case 14 : return backgroundSizeY = value;
      case 15 : return textDecoration = value;
      case 16 : return textDecorationColor = value;
      case 17 : return textDecorationStyle = value;
      case 18 : return textDecorationLine = value;
      case 19 : return width = value;
      case 20 : return height = value;
      case 21 : return minWidth = value;
      case 22 : return minHeight = value;
      case 23 : return maxWidth = value;
      case 24 : return maxHeight = value;
      case 25 : return padding = value;
      case 26 : return paddingTop = value;
      case 27 : return paddingRight = value;
      case 28 : return paddingBottom = value;
      case 29 : return paddingLeft = value;
      case 30 : return margin = value;
      case 31 : return marginTop = value;
      case 32 : return marginRight = value;
      case 33 : return marginBottom = value;
      case 34 : return marginLeft = value;
      case 35 : return border = value;
      case 36 : return borderWidth = value;
      case 37 : return borderColor = value;
      case 38 : return borderStyle = value;
      case 39 : return borderTopWidth = value;
      case 40 : return borderRightWidth = value;
      case 41 : return borderBottomWidth = value;
      case 42 : return borderLeftWidth = value;
      case 43 : return borderTopColor = value;
      case 44 : return borderRightColor = value;
      case 45 : return borderBottomColor = value;
      case 46 : return borderLeftColor = value;
      case 47 : return borderTopStyle = value;
      case 48 : return borderRightStyle = value;
      case 49 : return borderBottomStyle = value;
      case 50 : return borderLeftStyle = value;
      case 51 : return borderRadius = value;
      case 52 : return borderTopLeftRadius = value;
      case 53 : return borderTopRightRadius = value;
      case 54 : return borderBottomRightRadius = value;
      case 55 : return borderBottomLeftRadius = value;
    }
  }

  operator << (style){
    if(style is List){
        style.forEach((style)=>this << style);
        return;
    }

    if(style._color != null) { _color = style._color; didChangeProperty(0, _color); }
    if(style._font != null) { _font = style._font; didChangeProperty(1, _font); }
    if(style._fontStyle != null) { _fontStyle = style._fontStyle; didChangeProperty(2, _fontStyle); }
    if(style._fontWeight != null) { _fontWeight = style._fontWeight; didChangeProperty(3, _fontWeight); }
    if(style._fontSize != null) { _fontSize = style._fontSize; didChangeProperty(4, _fontSize); }
    if(style._fontFamily != null) { _fontFamily = style._fontFamily; didChangeProperty(5, _fontFamily); }
    if(style._background != null) { _background = style._background; didChangeProperty(6, _background); }
    if(style._backgroundColor != null) { _backgroundColor = style._backgroundColor; didChangeProperty(7, _backgroundColor); }
    if(style._backgroundImage != null) { _backgroundImage = style._backgroundImage; didChangeProperty(8, _backgroundImage); }
    if(style._backgroundPositionX != null) { _backgroundPositionX = style._backgroundPositionX; didChangeProperty(9, _backgroundPositionX); }
    if(style._backgroundPositionY != null) { _backgroundPositionY = style._backgroundPositionY; didChangeProperty(10, _backgroundPositionY); }
    if(style._backgroundRepeat != null) { _backgroundRepeat = style._backgroundRepeat; didChangeProperty(11, _backgroundRepeat); }
    if(style._backgroundSize != null) { _backgroundSize = style._backgroundSize; didChangeProperty(12, _backgroundSize); }
    if(style._backgroundSizeX != null) { _backgroundSizeX = style._backgroundSizeX; didChangeProperty(13, _backgroundSizeX); }
    if(style._backgroundSizeY != null) { _backgroundSizeY = style._backgroundSizeY; didChangeProperty(14, _backgroundSizeY); }
    if(style._textDecoration != null) { _textDecoration = style._textDecoration; didChangeProperty(15, _textDecoration); }
    if(style._textDecorationColor != null) { _textDecorationColor = style._textDecorationColor; didChangeProperty(16, _textDecorationColor); }
    if(style._textDecorationStyle != null) { _textDecorationStyle = style._textDecorationStyle; didChangeProperty(17, _textDecorationStyle); }
    if(style._textDecorationLine != null) { _textDecorationLine = style._textDecorationLine; didChangeProperty(18, _textDecorationLine); }
    if(style._width != null) { _width = style._width; didChangeProperty(19, _width); }
    if(style._height != null) { _height = style._height; didChangeProperty(20, _height); }
    if(style._minWidth != null) { _minWidth = style._minWidth; didChangeProperty(21, _minWidth); }
    if(style._minHeight != null) { _minHeight = style._minHeight; didChangeProperty(22, _minHeight); }
    if(style._maxWidth != null) { _maxWidth = style._maxWidth; didChangeProperty(23, _maxWidth); }
    if(style._maxHeight != null) { _maxHeight = style._maxHeight; didChangeProperty(24, _maxHeight); }
    if(style._padding != null) { _padding = style._padding; didChangeProperty(25, _padding); }
    if(style._paddingTop != null) { _paddingTop = style._paddingTop; didChangeProperty(26, _paddingTop); }
    if(style._paddingRight != null) { _paddingRight = style._paddingRight; didChangeProperty(27, _paddingRight); }
    if(style._paddingBottom != null) { _paddingBottom = style._paddingBottom; didChangeProperty(28, _paddingBottom); }
    if(style._paddingLeft != null) { _paddingLeft = style._paddingLeft; didChangeProperty(29, _paddingLeft); }
    if(style._margin != null) { _margin = style._margin; didChangeProperty(30, _margin); }
    if(style._marginTop != null) { _marginTop = style._marginTop; didChangeProperty(31, _marginTop); }
    if(style._marginRight != null) { _marginRight = style._marginRight; didChangeProperty(32, _marginRight); }
    if(style._marginBottom != null) { _marginBottom = style._marginBottom; didChangeProperty(33, _marginBottom); }
    if(style._marginLeft != null) { _marginLeft = style._marginLeft; didChangeProperty(34, _marginLeft); }
    if(style._border != null) { _border = style._border; didChangeProperty(35, _border); }
    if(style._borderWidth != null) { _borderWidth = style._borderWidth; didChangeProperty(36, _borderWidth); }
    if(style._borderColor != null) { _borderColor = style._borderColor; didChangeProperty(37, _borderColor); }
    if(style._borderStyle != null) { _borderStyle = style._borderStyle; didChangeProperty(38, _borderStyle); }
    if(style._borderTopWidth != null) { _borderTopWidth = style._borderTopWidth; didChangeProperty(39, _borderTopWidth); }
    if(style._borderRightWidth != null) { _borderRightWidth = style._borderRightWidth; didChangeProperty(40, _borderRightWidth); }
    if(style._borderBottomWidth != null) { _borderBottomWidth = style._borderBottomWidth; didChangeProperty(41, _borderBottomWidth); }
    if(style._borderLeftWidth != null) { _borderLeftWidth = style._borderLeftWidth; didChangeProperty(42, _borderLeftWidth); }
    if(style._borderTopColor != null) { _borderTopColor = style._borderTopColor; didChangeProperty(43, _borderTopColor); }
    if(style._borderRightColor != null) { _borderRightColor = style._borderRightColor; didChangeProperty(44, _borderRightColor); }
    if(style._borderBottomColor != null) { _borderBottomColor = style._borderBottomColor; didChangeProperty(45, _borderBottomColor); }
    if(style._borderLeftColor != null) { _borderLeftColor = style._borderLeftColor; didChangeProperty(46, _borderLeftColor); }
    if(style._borderTopStyle != null) { _borderTopStyle = style._borderTopStyle; didChangeProperty(47, _borderTopStyle); }
    if(style._borderRightStyle != null) { _borderRightStyle = style._borderRightStyle; didChangeProperty(48, _borderRightStyle); }
    if(style._borderBottomStyle != null) { _borderBottomStyle = style._borderBottomStyle; didChangeProperty(49, _borderBottomStyle); }
    if(style._borderLeftStyle != null) { _borderLeftStyle = style._borderLeftStyle; didChangeProperty(50, _borderLeftStyle); }
    if(style._borderRadius != null) { _borderRadius = style._borderRadius; didChangeProperty(51, _borderRadius); }
    if(style._borderTopLeftRadius != null) { _borderTopLeftRadius = style._borderTopLeftRadius; didChangeProperty(52, _borderTopLeftRadius); }
    if(style._borderTopRightRadius != null) { _borderTopRightRadius = style._borderTopRightRadius; didChangeProperty(53, _borderTopRightRadius); }
    if(style._borderBottomRightRadius != null) { _borderBottomRightRadius = style._borderBottomRightRadius; didChangeProperty(54, _borderBottomRightRadius); }
    if(style._borderBottomLeftRadius != null) { _borderBottomLeftRadius = style._borderBottomLeftRadius; didChangeProperty(55, _borderBottomLeftRadius); }
  }


  var _color;
  TypedStyleProperty<CSSColor> get color => _color ?? defaultStyle?._color ??  parent?._color ??  DefaultStyle.color;
  set color(v){  _getColor().value = v; didChangeProperty(0, _color); }
  _getColor() => (_color ??= new TypedStyleProperty<CSSColor>( initial : new CSSColor(0xff000000), allow : [CSSColor, CSSTransparentIdentify] )); 


  var _font;
  SHStyleProperty get font => _font ?? defaultStyle?._font ??  DefaultStyle.font;
  set font(v){  _getFont().value = v; didChangeProperty(1, _font); }
  _getFont() => (_font ??= new SHStyleProperty( order : StylePropertyOrder.orderOfAppearance, computed : [_getFontStyle(), _getFontWeight(), _getFontSize(), _getFontFamily()] )); 


  /// font group

  var _fontStyle;
  TypedStyleProperty<CSSIdentify> get fontStyle => _fontStyle ?? defaultStyle?._fontStyle ??  parent?._fontStyle ??  DefaultStyle.fontStyle;
  set fontStyle(v){ _getFont();  _getFontStyle().value = v; didChangeProperty(2, _fontStyle); }
  _getFontStyle() => (_fontStyle ??= new TypedStyleProperty<CSSIdentify>( initial : CSSNormalIdentify.get(), allow : [CSSNormalIdentify, CSSItalicIdentify, CSSObliqueIdentify, CSSInitialIdentify, CSSInheritIdentify] )); 


  var _fontWeight;
  TypedStyleProperty<CSSIdentify> get fontWeight => _fontWeight ?? defaultStyle?._fontWeight ??  parent?._fontWeight ??  DefaultStyle.fontWeight;
  set fontWeight(v){ _getFont();  _getFontWeight().value = v; didChangeProperty(3, _fontWeight); }
  _getFontWeight() => (_fontWeight ??= new TypedStyleProperty<CSSIdentify>( initial : CSSNormalIdentify.get(), allow : [CSSNormalIdentify, CSSBoldIdentify, CSSBolderIdentify, CSSLighterIdentify, CSSInitialIdentify, CSSInheritIdentify, CSS100Identify, CSS200Identify, CSS300Identify, CSS400Identify, CSS500Identify, CSS600Identify, CSS700Identify, CSS800Identify, CSS900Identify] )); 


  var _fontSize;
  LHStyleProperty get fontSize => _fontSize ?? defaultStyle?._fontSize ??  parent?._fontSize ??  DefaultStyle.fontSize;
  set fontSize(v){ _getFont();  _getFontSize().value = v; didChangeProperty(4, _fontSize); }
  _getFontSize() => (_fontSize ??= new LHStyleProperty( initial : CSSMediumIdentify.get(), allow : [CSSSize, CSSMediumIdentify, CSSXxSmallIdentify, CSSXSmallIdentify, CSSSmallIdentify, CSSLargeIdentify, CSSXLargeIdentify, CSSXxLargeIdentify, CSSSmallerIdentify, CSSLargerIdentify, CSSInitialIdentify, CSSInheritIdentify] )); 


  var _fontFamily;
  TypedStyleProperty<CSSIdentify> get fontFamily => _fontFamily ?? defaultStyle?._fontFamily ??  parent?._fontFamily ??  DefaultStyle.fontFamily;
  set fontFamily(v){ _getFont();  _getFontFamily().value = v; didChangeProperty(5, _fontFamily); }
  _getFontFamily() => (_fontFamily ??= new TypedStyleProperty<CSSIdentify>( initial : CSSDefaultIdentify.get(), allow : [CSSIdentify, CSSDefaultIdentify] )); 


  var _background;
  SHStyleProperty get background => _background ?? defaultStyle?._background ??  DefaultStyle.background;
  set background(v){  _getBackground().value = v; didChangeProperty(6, _background); }
  _getBackground() => (_background ??= new SHStyleProperty( order : StylePropertyOrder.orderOfAppearance, computed : [_getBackgroundColor(), _getBackgroundImage(), _getBackgroundPositionX(), _getBackgroundPositionY(), _getBackgroundRepeat()] )); 


  /// background group

  var _backgroundColor;
  LHStyleProperty get backgroundColor => _backgroundColor ?? defaultStyle?._backgroundColor ??  DefaultStyle.backgroundColor;
  set backgroundColor(v){ _getBackground();  _getBackgroundColor().value = v; didChangeProperty(7, _backgroundColor); }
  _getBackgroundColor() => (_backgroundColor ??= new LHStyleProperty( initial : CSSTransparentIdentify.get(), allow : [CSSColor, CSSTransparentIdentify] )); 


  var _backgroundImage;
  LHStyleProperty get backgroundImage => _backgroundImage ?? defaultStyle?._backgroundImage ??  DefaultStyle.backgroundImage;
  set backgroundImage(v){ _getBackground();  _getBackgroundImage().value = v; didChangeProperty(8, _backgroundImage); }
  _getBackgroundImage() => (_backgroundImage ??= new LHStyleProperty( initial : CSSNoneIdentify.get(), allow : [CSSUrl, CSSNoneIdentify] )); 


  var _backgroundPositionX;
  LHStyleProperty get backgroundPositionX => _backgroundPositionX ?? defaultStyle?._backgroundPositionX ??  DefaultStyle.backgroundPositionX;
  set backgroundPositionX(v){ _getBackground();  _getBackgroundPositionX().value = v; didChangeProperty(9, _backgroundPositionX); }
  _getBackgroundPositionX() => (_backgroundPositionX ??= new LHStyleProperty( initial : new CSSSize(50, CSSUnit.percent), allow : [CSSSize, CSSLeftIdentify, CSSRightIdentify, CSSCenterIdentify, CSSInitialIdentify, CSSInheritIdentify] )); 


  var _backgroundPositionY;
  LHStyleProperty get backgroundPositionY => _backgroundPositionY ?? defaultStyle?._backgroundPositionY ??  DefaultStyle.backgroundPositionY;
  set backgroundPositionY(v){ _getBackground();  _getBackgroundPositionY().value = v; didChangeProperty(10, _backgroundPositionY); }
  _getBackgroundPositionY() => (_backgroundPositionY ??= new LHStyleProperty( initial : new CSSSize(50, CSSUnit.percent), allow : [CSSSize, CSSTopIdentify, CSSBottomIdentify, CSSCenterIdentify, CSSInitialIdentify, CSSInheritIdentify] )); 


  var _backgroundRepeat;
  LHStyleProperty get backgroundRepeat => _backgroundRepeat ?? defaultStyle?._backgroundRepeat ??  DefaultStyle.backgroundRepeat;
  set backgroundRepeat(v){ _getBackground();  _getBackgroundRepeat().value = v; didChangeProperty(11, _backgroundRepeat); }
  _getBackgroundRepeat() => (_backgroundRepeat ??= new LHStyleProperty( initial : CSSRepeatIdentify.get(), allow : [CSSRepeatIdentify, CSSRepeatXIdentify, CSSRepeatYIdentify, CSSNoRepeatIdentify, CSSInitialIdentify, CSSInheritIdentify] )); 


  var _backgroundSize;
  SHStyleProperty get backgroundSize => _backgroundSize ?? defaultStyle?._backgroundSize ??  DefaultStyle.backgroundSize;
  set backgroundSize(v){  _getBackgroundSize().value = v; didChangeProperty(12, _backgroundSize); }
  _getBackgroundSize() => (_backgroundSize ??= new SHStyleProperty( initial : CSSNoneIdentify.get(), order : StylePropertyOrder.uniqueOrder, computed : [_getBackgroundSizeX(), _getBackgroundSizeY()] )); 


  /// background-size group

  var _backgroundSizeX;
  LHStyleProperty get backgroundSizeX => _backgroundSizeX ?? defaultStyle?._backgroundSizeX ??  DefaultStyle.backgroundSizeX;
  set backgroundSizeX(v){ _getBackgroundSize();  _getBackgroundSizeX().value = v; didChangeProperty(13, _backgroundSizeX); }
  _getBackgroundSizeX() => (_backgroundSizeX ??= new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSCoverIdentify, CSSContainIdentify, CSSInitialIdentify, CSSInheritIdentify] )); 


  var _backgroundSizeY;
  LHStyleProperty get backgroundSizeY => _backgroundSizeY ?? defaultStyle?._backgroundSizeY ??  DefaultStyle.backgroundSizeY;
  set backgroundSizeY(v){ _getBackgroundSize();  _getBackgroundSizeY().value = v; didChangeProperty(14, _backgroundSizeY); }
  _getBackgroundSizeY() => (_backgroundSizeY ??= new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSCoverIdentify, CSSContainIdentify, CSSInitialIdentify, CSSInheritIdentify] )); 


  var _textDecoration;
  SHStyleProperty get textDecoration => _textDecoration ?? defaultStyle?._textDecoration ??  DefaultStyle.textDecoration;
  set textDecoration(v){  _getTextDecoration().value = v; didChangeProperty(15, _textDecoration); }
  _getTextDecoration() => (_textDecoration ??= new SHStyleProperty( order : StylePropertyOrder.orderOfAppearance, computed : [_getTextDecorationColor(), _getTextDecorationStyle(), _getTextDecorationLine()] )); 


  /// text-decoration group

  var _textDecorationColor;
  TypedStyleProperty<CSSColor> get textDecorationColor => _textDecorationColor ?? defaultStyle?._textDecorationColor ??  DefaultStyle.textDecorationColor;
  set textDecorationColor(v){ _getTextDecoration();  _getTextDecorationColor().value = v; didChangeProperty(16, _textDecorationColor); }
  _getTextDecorationColor() => (_textDecorationColor ??= new TypedStyleProperty<CSSColor>( initial : new CSSColor(0xff000000), allow : [CSSColor, CSSTransparentIdentify] )); 


  var _textDecorationStyle;
  TypedStyleProperty<CSSIdentify> get textDecorationStyle => _textDecorationStyle ?? defaultStyle?._textDecorationStyle ??  DefaultStyle.textDecorationStyle;
  set textDecorationStyle(v){ _getTextDecoration();  _getTextDecorationStyle().value = v; didChangeProperty(17, _textDecorationStyle); }
  _getTextDecorationStyle() => (_textDecorationStyle ??= new TypedStyleProperty<CSSIdentify>( initial : CSSSolidIdentify.get(), allow : [CSSSolidIdentify, CSSDoubleIdentify, CSSDottedIdentify, CSSDashedIdentify, CSSWavyIdentify] )); 


  var _textDecorationLine;
  TypedStyleProperty<CSSIdentify> get textDecorationLine => _textDecorationLine ?? defaultStyle?._textDecorationLine ??  DefaultStyle.textDecorationLine;
  set textDecorationLine(v){ _getTextDecoration();  _getTextDecorationLine().value = v; didChangeProperty(18, _textDecorationLine); }
  _getTextDecorationLine() => (_textDecorationLine ??= new TypedStyleProperty<CSSIdentify>( initial : CSSNoneIdentify.get(), allow : [CSSNoneIdentify, CSSUnderlineIdentify, CSSOverlineIdentify, CSSLineThroughIdentify] )); 


  var _width;
  LHStyleProperty get width => _width ?? defaultStyle?._width ??  DefaultStyle.width;
  set width(v){  _getWidth().value = v; didChangeProperty(19, _width); }
  _getWidth() => (_width ??= new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] )); 


  var _height;
  LHStyleProperty get height => _height ?? defaultStyle?._height ??  DefaultStyle.height;
  set height(v){  _getHeight().value = v; didChangeProperty(20, _height); }
  _getHeight() => (_height ??= new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] )); 


  var _minWidth;
  LHStyleProperty get minWidth => _minWidth ?? defaultStyle?._minWidth ??  DefaultStyle.minWidth;
  set minWidth(v){  _getMinWidth().value = v; didChangeProperty(21, _minWidth); }
  _getMinWidth() => (_minWidth ??= new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] )); 


  var _minHeight;
  LHStyleProperty get minHeight => _minHeight ?? defaultStyle?._minHeight ??  DefaultStyle.minHeight;
  set minHeight(v){  _getMinHeight().value = v; didChangeProperty(22, _minHeight); }
  _getMinHeight() => (_minHeight ??= new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] )); 


  var _maxWidth;
  LHStyleProperty get maxWidth => _maxWidth ?? defaultStyle?._maxWidth ??  DefaultStyle.maxWidth;
  set maxWidth(v){  _getMaxWidth().value = v; didChangeProperty(23, _maxWidth); }
  _getMaxWidth() => (_maxWidth ??= new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] )); 


  var _maxHeight;
  LHStyleProperty get maxHeight => _maxHeight ?? defaultStyle?._maxHeight ??  DefaultStyle.maxHeight;
  set maxHeight(v){  _getMaxHeight().value = v; didChangeProperty(24, _maxHeight); }
  _getMaxHeight() => (_maxHeight ??= new LHStyleProperty( initial : CSSAutoIdentify.get(), allow : [CSSSize, CSSAutoIdentify, CSSInheritIdentify, CSSInitialIdentify] )); 


  var _padding;
  SHStyleProperty get padding => _padding ?? defaultStyle?._padding ??  DefaultStyle.padding;
  set padding(v){  _getPadding().value = v; didChangeProperty(25, _padding); }
  _getPadding() => (_padding ??= new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [_getPaddingTop(), _getPaddingRight(), _getPaddingBottom(), _getPaddingLeft()] )); 


  /// padding group

  var _paddingTop;
  TypedStyleProperty<CSSSize> get paddingTop => _paddingTop ?? defaultStyle?._paddingTop ??  DefaultStyle.paddingTop;
  set paddingTop(v){ _getPadding();  _getPaddingTop().value = v; didChangeProperty(26, _paddingTop); }
  _getPaddingTop() => (_paddingTop ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] )); 


  var _paddingRight;
  TypedStyleProperty<CSSSize> get paddingRight => _paddingRight ?? defaultStyle?._paddingRight ??  DefaultStyle.paddingRight;
  set paddingRight(v){ _getPadding();  _getPaddingRight().value = v; didChangeProperty(27, _paddingRight); }
  _getPaddingRight() => (_paddingRight ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] )); 


  var _paddingBottom;
  TypedStyleProperty<CSSSize> get paddingBottom => _paddingBottom ?? defaultStyle?._paddingBottom ??  DefaultStyle.paddingBottom;
  set paddingBottom(v){ _getPadding();  _getPaddingBottom().value = v; didChangeProperty(28, _paddingBottom); }
  _getPaddingBottom() => (_paddingBottom ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] )); 


  var _paddingLeft;
  TypedStyleProperty<CSSSize> get paddingLeft => _paddingLeft ?? defaultStyle?._paddingLeft ??  DefaultStyle.paddingLeft;
  set paddingLeft(v){ _getPadding();  _getPaddingLeft().value = v; didChangeProperty(29, _paddingLeft); }
  _getPaddingLeft() => (_paddingLeft ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] )); 


  var _margin;
  SHStyleProperty get margin => _margin ?? defaultStyle?._margin ??  DefaultStyle.margin;
  set margin(v){  _getMargin().value = v; didChangeProperty(30, _margin); }
  _getMargin() => (_margin ??= new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [_getMarginTop(), _getMarginRight(), _getMarginBottom(), _getMarginLeft()] )); 


  /// margin group

  var _marginTop;
  TypedStyleProperty<CSSSize> get marginTop => _marginTop ?? defaultStyle?._marginTop ??  DefaultStyle.marginTop;
  set marginTop(v){ _getMargin();  _getMarginTop().value = v; didChangeProperty(31, _marginTop); }
  _getMarginTop() => (_marginTop ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] )); 


  var _marginRight;
  TypedStyleProperty<CSSSize> get marginRight => _marginRight ?? defaultStyle?._marginRight ??  DefaultStyle.marginRight;
  set marginRight(v){ _getMargin();  _getMarginRight().value = v; didChangeProperty(32, _marginRight); }
  _getMarginRight() => (_marginRight ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] )); 


  var _marginBottom;
  TypedStyleProperty<CSSSize> get marginBottom => _marginBottom ?? defaultStyle?._marginBottom ??  DefaultStyle.marginBottom;
  set marginBottom(v){ _getMargin();  _getMarginBottom().value = v; didChangeProperty(33, _marginBottom); }
  _getMarginBottom() => (_marginBottom ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] )); 


  var _marginLeft;
  TypedStyleProperty<CSSSize> get marginLeft => _marginLeft ?? defaultStyle?._marginLeft ??  DefaultStyle.marginLeft;
  set marginLeft(v){ _getMargin();  _getMarginLeft().value = v; didChangeProperty(34, _marginLeft); }
  _getMarginLeft() => (_marginLeft ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSInitialIdentify, CSSSize, CSSInheritIdentify] )); 


  var _border;
  SHStyleProperty get border => _border ?? defaultStyle?._border ??  DefaultStyle.border;
  set border(v){  _getBorder().value = v; didChangeProperty(35, _border); }
  _getBorder() => (_border ??= new SHStyleProperty( order : StylePropertyOrder.orderOfAppearance, computed : [_getBorderWidth(), _getBorderColor(), _getBorderStyle()] )); 


  /// border group

  var _borderWidth;
  SHStyleProperty get borderWidth => _borderWidth ?? defaultStyle?._borderWidth ??  DefaultStyle.borderWidth;
  set borderWidth(v){ _getBorder();  _getBorderWidth().value = v; didChangeProperty(36, _borderWidth); }
  _getBorderWidth() => (_borderWidth ??= new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [_getBorderTopWidth(), _getBorderRightWidth(), _getBorderBottomWidth(), _getBorderLeftWidth()] )); 


  var _borderColor;
  SHStyleProperty get borderColor => _borderColor ?? defaultStyle?._borderColor ??  DefaultStyle.borderColor;
  set borderColor(v){ _getBorder();  _getBorderColor().value = v; didChangeProperty(37, _borderColor); }
  _getBorderColor() => (_borderColor ??= new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [_getBorderTopColor(), _getBorderRightColor(), _getBorderBottomColor(), _getBorderLeftColor()] )); 


  var _borderStyle;
  SHStyleProperty get borderStyle => _borderStyle ?? defaultStyle?._borderStyle ??  DefaultStyle.borderStyle;
  set borderStyle(v){ _getBorder();  _getBorderStyle().value = v; didChangeProperty(38, _borderStyle); }
  _getBorderStyle() => (_borderStyle ??= new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [_getBorderTopStyle(), _getBorderRightStyle(), _getBorderBottomStyle(), _getBorderLeftStyle()] )); 


  /// border-width group

  var _borderTopWidth;
  TypedStyleProperty<CSSSize> get borderTopWidth => _borderTopWidth ?? defaultStyle?._borderTopWidth ??  DefaultStyle.borderTopWidth;
  set borderTopWidth(v){ _getBorderWidth();  _getBorderTopWidth().value = v; didChangeProperty(39, _borderTopWidth); }
  _getBorderTopWidth() => (_borderTopWidth ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] )); 


  var _borderRightWidth;
  TypedStyleProperty<CSSSize> get borderRightWidth => _borderRightWidth ?? defaultStyle?._borderRightWidth ??  DefaultStyle.borderRightWidth;
  set borderRightWidth(v){ _getBorderWidth();  _getBorderRightWidth().value = v; didChangeProperty(40, _borderRightWidth); }
  _getBorderRightWidth() => (_borderRightWidth ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] )); 


  var _borderBottomWidth;
  TypedStyleProperty<CSSSize> get borderBottomWidth => _borderBottomWidth ?? defaultStyle?._borderBottomWidth ??  DefaultStyle.borderBottomWidth;
  set borderBottomWidth(v){ _getBorderWidth();  _getBorderBottomWidth().value = v; didChangeProperty(41, _borderBottomWidth); }
  _getBorderBottomWidth() => (_borderBottomWidth ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] )); 


  var _borderLeftWidth;
  TypedStyleProperty<CSSSize> get borderLeftWidth => _borderLeftWidth ?? defaultStyle?._borderLeftWidth ??  DefaultStyle.borderLeftWidth;
  set borderLeftWidth(v){ _getBorderWidth();  _getBorderLeftWidth().value = v; didChangeProperty(42, _borderLeftWidth); }
  _getBorderLeftWidth() => (_borderLeftWidth ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] )); 


  /// border-color group

  var _borderTopColor;
  TypedStyleProperty<CSSColor> get borderTopColor => _borderTopColor ?? defaultStyle?._borderTopColor ??  DefaultStyle.borderTopColor;
  set borderTopColor(v){ _getBorderColor();  _getBorderTopColor().value = v; didChangeProperty(43, _borderTopColor); }
  _getBorderTopColor() => (_borderTopColor ??= new TypedStyleProperty<CSSColor>( initial : new CSSColor(0), allow : [CSSColor, CSSTransparentIdentify] )); 


  var _borderRightColor;
  TypedStyleProperty<CSSColor> get borderRightColor => _borderRightColor ?? defaultStyle?._borderRightColor ??  DefaultStyle.borderRightColor;
  set borderRightColor(v){ _getBorderColor();  _getBorderRightColor().value = v; didChangeProperty(44, _borderRightColor); }
  _getBorderRightColor() => (_borderRightColor ??= new TypedStyleProperty<CSSColor>( initial : new CSSColor(0), allow : [CSSColor, CSSTransparentIdentify] )); 


  var _borderBottomColor;
  TypedStyleProperty<CSSColor> get borderBottomColor => _borderBottomColor ?? defaultStyle?._borderBottomColor ??  DefaultStyle.borderBottomColor;
  set borderBottomColor(v){ _getBorderColor();  _getBorderBottomColor().value = v; didChangeProperty(45, _borderBottomColor); }
  _getBorderBottomColor() => (_borderBottomColor ??= new TypedStyleProperty<CSSColor>( initial : new CSSColor(0), allow : [CSSColor, CSSTransparentIdentify] )); 


  var _borderLeftColor;
  TypedStyleProperty<CSSColor> get borderLeftColor => _borderLeftColor ?? defaultStyle?._borderLeftColor ??  DefaultStyle.borderLeftColor;
  set borderLeftColor(v){ _getBorderColor();  _getBorderLeftColor().value = v; didChangeProperty(46, _borderLeftColor); }
  _getBorderLeftColor() => (_borderLeftColor ??= new TypedStyleProperty<CSSColor>( initial : new CSSColor(0), allow : [CSSColor, CSSTransparentIdentify] )); 


  /// border-style group

  var _borderTopStyle;
  TypedStyleProperty<CSSIdentify> get borderTopStyle => _borderTopStyle ?? defaultStyle?._borderTopStyle ??  DefaultStyle.borderTopStyle;
  set borderTopStyle(v){ _getBorderStyle();  _getBorderTopStyle().value = v; didChangeProperty(47, _borderTopStyle); }
  _getBorderTopStyle() => (_borderTopStyle ??= new TypedStyleProperty<CSSIdentify>( initial : CSSNoneIdentify.get(), allow : [CSSNoneIdentify, CSSHiddenIdentify, CSSDottedIdentify, CSSDashedIdentify, CSSSolidIdentify, CSSDoubleIdentify, CSSGrooveIdentify, CSSRidgeIdentify, CSSInsetIdentify, CSSOutsetIdentify] )); 


  var _borderRightStyle;
  TypedStyleProperty<CSSIdentify> get borderRightStyle => _borderRightStyle ?? defaultStyle?._borderRightStyle ??  DefaultStyle.borderRightStyle;
  set borderRightStyle(v){ _getBorderStyle();  _getBorderRightStyle().value = v; didChangeProperty(48, _borderRightStyle); }
  _getBorderRightStyle() => (_borderRightStyle ??= new TypedStyleProperty<CSSIdentify>( initial : CSSNoneIdentify.get(), allow : [CSSNoneIdentify, CSSHiddenIdentify, CSSDottedIdentify, CSSDashedIdentify, CSSSolidIdentify, CSSDoubleIdentify, CSSGrooveIdentify, CSSRidgeIdentify, CSSInsetIdentify, CSSOutsetIdentify] )); 


  var _borderBottomStyle;
  TypedStyleProperty<CSSIdentify> get borderBottomStyle => _borderBottomStyle ?? defaultStyle?._borderBottomStyle ??  DefaultStyle.borderBottomStyle;
  set borderBottomStyle(v){ _getBorderStyle();  _getBorderBottomStyle().value = v; didChangeProperty(49, _borderBottomStyle); }
  _getBorderBottomStyle() => (_borderBottomStyle ??= new TypedStyleProperty<CSSIdentify>( initial : CSSNoneIdentify.get(), allow : [CSSNoneIdentify, CSSHiddenIdentify, CSSDottedIdentify, CSSDashedIdentify, CSSSolidIdentify, CSSDoubleIdentify, CSSGrooveIdentify, CSSRidgeIdentify, CSSInsetIdentify, CSSOutsetIdentify] )); 


  var _borderLeftStyle;
  TypedStyleProperty<CSSIdentify> get borderLeftStyle => _borderLeftStyle ?? defaultStyle?._borderLeftStyle ??  DefaultStyle.borderLeftStyle;
  set borderLeftStyle(v){ _getBorderStyle();  _getBorderLeftStyle().value = v; didChangeProperty(50, _borderLeftStyle); }
  _getBorderLeftStyle() => (_borderLeftStyle ??= new TypedStyleProperty<CSSIdentify>( initial : CSSNoneIdentify.get(), allow : [CSSNoneIdentify, CSSHiddenIdentify, CSSDottedIdentify, CSSDashedIdentify, CSSSolidIdentify, CSSDoubleIdentify, CSSGrooveIdentify, CSSRidgeIdentify, CSSInsetIdentify, CSSOutsetIdentify] )); 


  var _borderRadius;
  SHStyleProperty get borderRadius => _borderRadius ?? defaultStyle?._borderRadius ??  DefaultStyle.borderRadius;
  set borderRadius(v){  _getBorderRadius().value = v; didChangeProperty(51, _borderRadius); }
  _getBorderRadius() => (_borderRadius ??= new SHStyleProperty( order : StylePropertyOrder.uniqueOrder, computed : [_getBorderTopLeftRadius(), _getBorderTopRightRadius(), _getBorderBottomRightRadius(), _getBorderBottomLeftRadius()] )); 


  /// border-radius group

  var _borderTopLeftRadius;
  TypedStyleProperty<CSSSize> get borderTopLeftRadius => _borderTopLeftRadius ?? defaultStyle?._borderTopLeftRadius ??  DefaultStyle.borderTopLeftRadius;
  set borderTopLeftRadius(v){ _getBorderRadius();  _getBorderTopLeftRadius().value = v; didChangeProperty(52, _borderTopLeftRadius); }
  _getBorderTopLeftRadius() => (_borderTopLeftRadius ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] )); 


  var _borderTopRightRadius;
  TypedStyleProperty<CSSSize> get borderTopRightRadius => _borderTopRightRadius ?? defaultStyle?._borderTopRightRadius ??  DefaultStyle.borderTopRightRadius;
  set borderTopRightRadius(v){ _getBorderRadius();  _getBorderTopRightRadius().value = v; didChangeProperty(53, _borderTopRightRadius); }
  _getBorderTopRightRadius() => (_borderTopRightRadius ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] )); 


  var _borderBottomRightRadius;
  TypedStyleProperty<CSSSize> get borderBottomRightRadius => _borderBottomRightRadius ?? defaultStyle?._borderBottomRightRadius ??  DefaultStyle.borderBottomRightRadius;
  set borderBottomRightRadius(v){ _getBorderRadius();  _getBorderBottomRightRadius().value = v; didChangeProperty(54, _borderBottomRightRadius); }
  _getBorderBottomRightRadius() => (_borderBottomRightRadius ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] )); 


  var _borderBottomLeftRadius;
  TypedStyleProperty<CSSSize> get borderBottomLeftRadius => _borderBottomLeftRadius ?? defaultStyle?._borderBottomLeftRadius ??  DefaultStyle.borderBottomLeftRadius;
  set borderBottomLeftRadius(v){ _getBorderRadius();  _getBorderBottomLeftRadius().value = v; didChangeProperty(55, _borderBottomLeftRadius); }
  _getBorderBottomLeftRadius() => (_borderBottomLeftRadius ??= new TypedStyleProperty<CSSSize>( initial : new CSSSize(0), allow : [CSSSize] )); 

}


