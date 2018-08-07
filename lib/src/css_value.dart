

part of css;


class CSSValueFactory{


  static fromExpression(Expression exp){
    switch(exp.runtimeType){
      case Expressions:
        return fromExpressions(exp);
      case LengthTerm:
        var v = (exp as LengthTerm);
        return new CSSSize(v.value, CSSUnit.get(TokenKind.unitToString(v.unit)));
      case PercentageTerm:
        var v = (exp as PercentageTerm);
        return new CSSSize(v.value, CSSUnit.percent);
      case HexColorTerm:
        return new CSSColor((exp as HexColorTerm).value);
      case LiteralTerm:
        var identify = (exp as LiteralTerm).text;
        return CSSIdentify.get(identify) ?? new CSSIdentify(identify);
      case NumberTerm:
        var identify = (exp as NumberTerm).text;
        return CSSIdentify.get(identify) ?? new CSSIdentify(identify);
      case UriTerm:
        var url = (exp as UriTerm).value;
        return new CSSUrl(url);

    }
  }
  

  static fromExpressions(Expressions arg){

    var rtn = <CSSValue>[];
    var exps = arg.expressions;
    for(var x = 0, len = exps.length; x < len; x++){
      var exp = exps[x];

      if(exp is OperatorComma){

        if(x > 0 && x < len -1){
          var before = rtn[x - 1];
          if(before is CSSList){
            before.add(fromExpression(exps[x+1]));
          }else{
            var list = new CSSList();
            list.add(before);
            list.add(fromExpression(exps[x+1]));
            rtn[x - 1] = list;
          }
          x++;
        }

        continue;
      }

      rtn.add(fromExpression(exp));
    }
    
    return rtn;
  }
}