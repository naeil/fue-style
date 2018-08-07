part of css;

str_repeat(str, i){  
  var rtn = "";
  for(var x = 0; x < i; x++){
    rtn+=str;
  }

  return rtn;
}


abstract class CSSElement{
  CSSElement get parent;
  CSSElement get previousElementSibling;
  get tagName;
  get nthChild;
  get classList;
  get attributes;

  addEventListener(ev, cb);
}

class CssTreeNode<T extends StyleBase>{

  int depth = 0;
  final CssTreeNode parent;
  final int combinator;
  final SimpleSelector selector;
  List<CssTreeNode> children = [];
  List<CssTreeNode> details = [];
  T style;

  CssTreeNode([this.parent, this.combinator, this.selector]){
    if(parent != null){
      depth = parent.depth + 1;

      switch(selector.runtimeType){
        case ElementSelector:
        case AttributeSelector:
        case IdSelector:
        case ClassSelector:
          parent.children.add(this);
          break;
        default:
          parent.details.add(this);
      }
    }
  }


  static combinatorToString(int combinator){
  
    switch(combinator){
      case TokenKind.COMBINATOR_NONE: return "";
      case TokenKind.COMBINATOR_DESCENDANT: return "' '";
      case TokenKind.COMBINATOR_PLUS: return "'+'";
      case TokenKind.COMBINATOR_GREATER: return "'>'";
      case TokenKind.COMBINATOR_TILDE: return "'~'";
      case TokenKind.COMBINATOR_SHADOW_PIERCING_DESCENDANT: return "'>>>'";
      case TokenKind.COMBINATOR_DEEP: return "'/deep/'";
    }

  }

  static int _toStringDepth = 1;

  @override
  toString(){
    if(parent == null){
      return "CssTreeNode => \n"+ children.map((v)=>v.toString()).join();
    }
    var rtn = 
      depth.toString() + " " + str_repeat("  ", _toStringDepth++) + combinatorToString(combinator) + selector.toString() + 
      "{" + style.toString()+"} \n" + children.map((v)=>v.toString()).join() +
      details.map((v)=>v.toString()).join();

    _toStringDepth--;
    return rtn;
  }
}

class CssTree<T extends StyleBase>{
  var css;
  StyleSheet sheets;
  var map = {};

  CssTreeNode<T> root = new CssTreeNode<T>();
  List<CssTreeNode> leafs = <CssTreeNode>[];

  var styleFactory;

  CssTree(this.css, T styleFactory()):this.styleFactory=styleFactory{_parse();}

  // static const int COMBINATOR_NONE = 513;
  // static const int COMBINATOR_DESCENDANT = 514; // Space combinator
  // static const int COMBINATOR_PLUS = 515; // + combinator
  // static const int COMBINATOR_GREATER = 516; // > combinator
  // static const int COMBINATOR_TILDE = 517; // ~ combinator
  // static const int COMBINATOR_SHADOW_PIERCING_DESCENDANT = 518; // >>>
  // static const int COMBINATOR_DEEP = 519; // /deep/ (aliases >>>)

  _parse(){
    sheets = parse(this.css);

    for(var sheet in sheets.topLevels){
      if(sheet is RuleSet){
          
        var style = styleFactory();
        for(Declaration decl in sheet.declarationGroup.declarations){
          style.setProperty(decl.property, decl.expression);
        }
        
        for(Selector selectors in sheet.selectorGroup.selectors){
          selectors.simpleSelectorSequences;
          var current = root;
          for(SimpleSelectorSequence selector in selectors.simpleSelectorSequences){

            var exists = false;
            for(var child in current.children){
              if(child.combinator == selector.combinator &&
                child.selector.name == selector.simpleSelector.name){
                  current = child;
                  exists = true;
              }
            }

            if(!exists){
              current = new CssTreeNode<T>(current, selector.combinator, selector.simpleSelector);
            }
          }
          if(current.style == null)
            current.style = style;
          else
            current.style << style;
          
          //if(leafs.indexOf(current) == -1)
          leafs.add(current);
        }
        //map[]
      }
    }


    leafs.sort((a, b){
      if(a.depth > b.depth){
        return -1;
      }
      if(a.depth < b.depth){
        return 1;
      }      
      return 0;
    });
    leafs.forEach(_reduce);
    
  }

  bool leaf_check(CssTreeNode left, CssTreeNode right){
    var a = 0;

    if(left == null || right == null || right.selector == null)
      return false;

    if(left.selector.name == right.selector.name){
      if(left.parent == root){
        return true;
      }

      if(left.combinator == right.combinator){
        return leaf_check(left.parent, right.parent);
      }
    }

    return false;
  }


  _reduce_leaf(CssTreeNode node, CssTreeNode leaf){

      if(leaf_check(node, leaf)){
        leaf.style << node.style;
      }

      if(leaf.parent != null){
        leaf_check(node, leaf.parent);
      }
  }

  _reduce(CssTreeNode node){
    
    for(var leaf in leafs){
      if(node == leaf){
        continue;
      }

      _reduce_leaf(node, leaf);
    }
    

  }
  
  lookup_check(CSSElement element, CssTreeNode leaf){
    switch(leaf.selector.runtimeType){
      case ElementSelector:
        if(element.tagName.toLowerCase() == leaf.selector.name.toLowerCase()){
          return lookup_combinate(leaf, element);
        }
        break;
      case AttributeSelector:
        var selector = leaf.selector as AttributeSelector;
        if(check_attribute(element.attributes[selector.name]??"", selector.value?.name, selector.operatorKind)){
          return lookup_combinate(leaf, element);
        }
        break;
      case IdSelector:
        var selector = leaf.selector as IdSelector;
        if(check_attribute(element.attributes["id"]??"", selector.name, TokenKind.EQUALS)){
          return lookup_combinate(leaf, element);
        }      
        break;
      case ClassSelector:
        var selector = leaf.selector as ClassSelector;
        if(check_attribute(element.attributes["class"]??"", selector.name, TokenKind.INCLUDES)){
          return lookup_combinate(leaf, element);
        }     
        break;

      case PseudoClassFunctionSelector:
        var selector = leaf.selector as PseudoClassFunctionSelector;

        switch(selector.name){
          case "first-child":
            var cb = (){
              if(element.nthChild == 0){

              }
            };

            cb();

            element.parent?.addEventListener("DOMSubtreeModified", cb);

            if(element.nthChild == 0){
              return true;
            }

            break;          
          case "nth-child":
            var fnc = compilePseudoClassFunction((selector.argument as SelectorExpression)?.expressions);

            var cb = (){
              if(fnc(element.nthChild)){

              }
            };

            cb();

            element.parent?.addEventListener("DOMSubtreeModified", cb);

            if(fnc(element.nthChild)){
              return true;
            }

            break;
        }


        // TODO : add element listen;
        break;
    }

    return false;
  }

  static compilePseudoClassFunction(arguments){

    var len = arguments.length;
    var vs = <int>[];
    var r = 0.0;

    var plus = 1;

    if(arguments.length ==1 && arguments[0].runtimeType == LiteralTerm){
      var text = arguments[0].text;
      if(text == "odd"){
        r = 2.0;
        vs.add(1);
      }else if(text == "even"){
        r = 2.0;
        vs.add(0);
      }

      len = 0;
    }

    for(var x = 0; x < len; x++){

      var arg = arguments[x];

      if(arg.runtimeType == LiteralTerm){
        continue;
      }

      if((x + 1 < len) && (arguments[x + 1].runtimeType == LiteralTerm)){
        r = arg.value * plus;
      }else if(arg is OperatorMinus){
        plus = -1;
        continue;
      }else{
        vs.add(arg.value * plus);
      }

      if(plus < 0) plus = 1;

    }

    return (n){
      double rtn = n;
      for(var v in vs){
        rtn -= v;
      }

      rtn /= r;

      return rtn.toInt().toDouble() == rtn;
    };
  }

  lookup_combinate(CssTreeNode<StyleBase> leaf, CSSElement element) {
    if(leaf.parent == root){
      return true;
    }else{
      switch(leaf.combinator){
        case TokenKind.COMBINATOR_NONE:
          return lookup_check(element, leaf.parent);
        case TokenKind.COMBINATOR_DESCENDANT: // ' '
          var parent = element.parent;
          while(parent != null){
            if(lookup_check(parent, leaf.parent)){
              return true;
            }
            parent = element.parent;
          }
          return false;
        case TokenKind.COMBINATOR_PLUS:  // '+';
          return lookup_check(element.previousElementSibling, leaf.parent);
          break;
        case TokenKind.COMBINATOR_GREATER: // '>'
          return lookup_check(element.parent, leaf.parent);
        case TokenKind.COMBINATOR_TILDE: // return "'~'";
          var prev = element.previousElementSibling;
          while(prev != null){
            if(lookup_check(prev, leaf.parent)){
              return true;
            }
            prev = element.previousElementSibling;
          }
          return false;
        case TokenKind.COMBINATOR_SHADOW_PIERCING_DESCENDANT: return "'>>>'";
        case TokenKind.COMBINATOR_DEEP: return "'deep'";
      }
      return false;
    }
  }

  lookup(CSSElement element){
    for(var leaf in leafs){
      if(lookup_check(element, leaf)){
        return leaf.style;
      }
    }

    return null;
  }

  bool check_attribute(String attribute, String value, int operatorKind) {
    // TokenKind.EQUALS = 23
    // static const int INCLUDES = 530; // '~='
    // static const int DASH_MATCH = 531; // '|='
    // static const int PREFIX_MATCH = 532; // '^='
    // static const int SUFFIX_MATCH = 533; // '$='
    // static const int SUBSTRING_MATCH = 534; // '*='
    // static const int NO_MATCH = 535; // No operator.    
    switch(operatorKind){
      case TokenKind.EQUALS:
        return attribute == value;
      case TokenKind.INCLUDES:
        RegExp exp = new RegExp(r"\b"+value+r"\b");
        var result = exp.hasMatch(attribute);
        return result;
      case TokenKind.DASH_MATCH:
        RegExp exp = new RegExp(r"^"+value+r"(-.*)?$");
        var result = exp.hasMatch(attribute);
        return result;
      case TokenKind.PREFIX_MATCH:
        return attribute.startsWith(value);
      case TokenKind.SUFFIX_MATCH:
        return attribute.endsWith(value);
      case TokenKind.SUBSTRING_MATCH:
        return attribute.indexOf(value) > -1;
      case TokenKind.NO_MATCH:
    }
    
    return false;
  }

}