
import 'css.dart';


StyleSheet parserStyleSheets(src){
  return parse(src);
}

var defaultfatory = ()=>new StyleBase();



generateStyles<T extends StyleBase>(src, [T styleFactory()] ){

  if(styleFactory == null){
     styleFactory = ()=>new StyleBase() as T;
  }

  var sheets = parserStyleSheets(src);

  var rtn = <String, List<T> >{};

  for(var sheet in sheets.topLevels){
    if(sheet is RuleSet){
      var styles = <T>[];
      for(Declaration decl in sheet.declarationGroup.declarations){
        var style = styleFactory();
        style.setProperty(decl.property, decl.expression);
        styles.add(style);
      }
      
      for(Selector selectors in sheet.selectorGroup.selectors){
        var span = selectors.span;
        var selector = span.text;
        
        if(rtn[selector] == null){
          rtn[selector] = <T>[];
        }

        rtn[selector].addAll(styles);
      }

    }
  }

  return rtn;
}
