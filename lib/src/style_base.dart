
part of css;

class StyleBase extends StyleImpl{
  
  static const propertyKeyMap = StyleImpl.propertyKeyMap;


  @override
  get parent{}

  operator [] (key){
    return getProperty(key);
  }

  operator []= (key, value){
    return setProperty(key, value);
  }

  String get cssText{
    var rtn = new StringBuffer();
    var groups = {};
    
    for(var i = 0, len = length; i < len; i++){
      var v = getProperty(i, true);
      if(v == null)
        continue;
      
      if(v.value == null)
        continue;

      var name = StyleImpl.propertyNames[i];
      groups[name] = true;
      
      if(groups[ propertyKeyMap[name].group ] == true){
        continue;  
      }

      rtn.write(name + ":" + v.toString() + ";");
    }

    return rtn.toString();
  }

  set cssText(String css){
    var decls = _parseCssDeclations(css);

    if(decls is List<Declaration>){
      
      decls.forEach((v)=>setProperty(v.property, v.expression));
      
      return ;
    }

    return ;
  }

  int get length => StyleImpl.propertyNames.length;

  @override
  toString(){
    return cssText;
  }
}