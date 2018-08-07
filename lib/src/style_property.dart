
part of css;

// parse(String v){
//   var file = new SourceFile.fromString(v);
//   var parser = new _Parser(file, v);

//   PreprocessorOptions opt = new PreprocessorOptions(checked:false);

//   _createMessages(errors: [], options: opt);

//   return parser.parse();
// }


_parseCssValue(String v){
  var file = new SourceFile.fromString(v);
  var parser = new _Parser(file, v);

  PreprocessorOptions opt = new PreprocessorOptions(checked:false);

  _createMessages(errors: [], options: opt);

  return parser.processExpr();
}

_parseCssDeclations(String v){
  var file = new SourceFile.fromString(v);
  var parser = new _Parser(file, v);

  PreprocessorOptions opt = new PreprocessorOptions(checked:false);

  _createMessages(errors: [], options: opt);

  var style = [];
  var decls = <Declaration>[];
  do{
    var decl = parser.processDeclaration([]);

    if(decl != null){
      decls.add(decl);
    }
  }while(parser._maybeEat(TokenKind.SEMICOLON));

  return decls;
}

abstract class StyleProperty{

  var _value;

  get value => _value;

  set value(v) {
    _value = v;
  }

  bool checkAllow(CSSValue value);

  void reset();

  StyleProperty();

  bool isSingleValue()=>true;

  @override
  String toString() {
      // TODO: implement toString
      return value.toString();
    }
}

enum StylePropertyOrder{
  canonicalOrder,
  lengthOrPercentageBeforeKeywordIfBothPresent,
  lengthOrPercentageBeforeKeywords,
  oneOrTwoValuesLengthAbsoluteKeywordsPercentages,
  orderOfAppearance,
  percentagesOrLengthsFollowedByFill,
  perGrammar,
  uniqueOrder,
  parse
}

class TypedStyleProperty<T> extends LHStyleProperty{
  TypedStyleProperty({group, initial, allow}):super(group:group, initial:initial, allow:allow);
  T get value => _value;

}

class SHStyleProperty extends StyleProperty{
  final initial;
  final group;
  final List<StyleProperty> computed;
  final StylePropertyOrder order;

  SHStyleProperty({this.initial, this.group, this.computed, this.order:StylePropertyOrder.orderOfAppearance}){
    if(initial != null)
      value = initial;
  }

  SHStyleProperty clone() => new SHStyleProperty(initial: initial, computed: computed, order: order);


  void reset(){
    computed.forEach((v)=>v.reset());
  }

  @override
  bool checkAllow(CSSValue value){
    return computed.any((v)=>v.checkAllow(value));
  }


  @override
  bool isSingleValue(){
    if(order == StylePropertyOrder.uniqueOrder){
      var tv = computed[0].value;
      var result = computed.every((v)=>v.value==tv);

      var debug = computed.join(' ');
      return result;
    }

    return computed.length == 1;
  }

  @override
  get value {

    if(order == StylePropertyOrder.uniqueOrder){
      var tv = computed[0].value;
      var every = computed.every((v)=>v.value==tv);

      if(every)
        return tv;
    }

    if(order == StylePropertyOrder.orderOfAppearance){
      var ok = computed.every((v)=>v.isSingleValue());
      if(ok)
        return computed.join(' ');

      return null;
    }

    return computed.join(' ');
  }

  @override
  set value(value){
    if(value is String){
      value = _parseCssValue(value);
    }


    if(value is SHStyleProperty || value is LHStyleProperty){

      if(value is SHStyleProperty){
        if(value.computed.length == computed.length){
          for(var x = 0; x < computed.length; x++)
          computed[x].value = value.computed[x];
        }
        return;
      }

      this.value = value.toString();
      return;
    }

    if(value is Expressions){
      this.value = CSSValueFactory.fromExpression(value);
      //this.value = value.expressions.map<CSSValue>((exp)=>CSSValueFactory.fromExpression(exp)).toList();
      return;
    }

    if(value is Expression){
      value = CSSValueFactory.fromExpression(value);
    }

    if(value is List<CSSValue> && value is! CSSList){
      if(this.order == StylePropertyOrder.uniqueOrder){

        if(computed.length != 4){
          debugger();
        }

        switch(value.length){
          case 1:
            computed.forEach((property){
              property.value = value[0];
            });
            break;
          case 2:
            computed[0].value = value[0];
            computed[1].value = value[1];
            computed[2].value = value[0];
            computed[3].value = value[1];
            break;
          case 3:
            computed[0].value = value[0];
            computed[1].value = value[1];
            computed[2].value = value[2];
            computed[3].value = value[1];
            break;
          
          default:
            computed[0].value = value[0];
            computed[1].value = value[1];
            computed[2].value = value[2];
            computed[3].value = value[3];
            break;
        }

        return;
      }

      var properties = computed.toList();
      for(var v in value){
        var idx = properties.indexWhere((property){
          return property.checkAllow(v);
        });
        if(idx > -1){
          properties[idx].value = v;
          properties.removeAt(idx);
        }
      }

      properties.forEach((v)=>v.reset());
      return ;
    }
    
    var properties = computed.toList();

    for(var x = 0; x < properties.length; x++){
      var property = properties[x];
      if(property.checkAllow(value)){
        property.value = value;
      }
      //properties.removeAt(x);
    }

    computed.forEach((property){

      //property.value = value;
    });
  }

  @override
  String toString() {
      // TODO: implement toString
      return value.toString();
    }
}


class LHStyleProperty extends StyleProperty{
  final initial;
  final group;
  final List allow;
  LHStyleProperty({this.initial, this.group, this.allow}){
    if(initial != null)
      _value = initial;
  }

  LHStyleProperty clone() => new LHStyleProperty(initial: initial, allow: allow);

  @override
  void reset(){
    value = initial;
  }

  @override
  bool isSingleValue(){
    return true;
  }

  @override
  bool checkAllow(CSSValue value){
    return allow.indexOf(value.runtimeType) > -1;
  }

  @override
  set value(value){
    if(value is String || value is num){
      value = _parseCssValue(value);
    }

    if(value is SHStyleProperty || value is LHStyleProperty){
      this.value = value.toString();
      return;
    }

    if(value is Expressions){
      this.value = CSSValueFactory.fromExpression(value);
      return;
    }

    if(value is Expression){
      value = CSSValueFactory.fromExpression(value);
    }

    if(value is List<CSSValue> && value is! CSSList){
      this.value = value[0];
      return ;
    }

    if(value == null){
      _value = null;
      return;
    }

    if(value is! CSSValue){
      debugger();
    }

    if(allow != null){
      if(allow.indexOf(value.runtimeType) > -1) {

          if(value is CSSInitialIdentify){
            this.value = initial;
            return;
          }

        _value = value;
      }
    }else{
      _value = value;
    }
  }

}
