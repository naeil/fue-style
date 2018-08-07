
library fue.style;

import "src/css.dart" as _css;

export 'src/css_util.dart';
export 'src/style_key_map.dart';
export 'src/css_type.dart';

class StyleBase extends _css.StyleBase{
    static const propertyKeyMap = _css.StyleBase.propertyKeyMap;
}

class CssTree<T extends _css.StyleBase> extends _css.CssTree<T>{
  CssTree(css, T styleFactory()) : super(css, styleFactory);

}

abstract class CSSElement extends _css.CSSElement{}
