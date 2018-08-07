
var fs = require("fs");
var peg = require("pegjs");

var properties_json = require("./style_properties.json");



function toCamelCase(str){
    return str.replace(/-[a-z0-9]/g, ($0)=>{ return $0.substr(1).toUpperCase()});
}

function typeToString(type){
    var str = type.replace(/<([a-zA-Z0-9_]+)>/g, ($0, $1)=>"CSS" + toCamelCase($1.substr(0, 1).toUpperCase() + $1.substr(1)))

    if(str != type){
        return str;
    }

    return "CSS" + toCamelCase(type.substr(0, 1).toUpperCase() + type.substr(1)) + "Identify";
}

function typeToInitialString(type){

    if(type == "[]"){
        return "new CSSList()";
    }

    var str = type.replace(/<([a-zA-Z0-9_]+)>/g, ($0, $1)=>"CSS" + toCamelCase($1.substr(0, 1).toUpperCase() + $1.substr(1)))

    if(str != type){
        return "new " + str;
    }

    return "CSS" + toCamelCase(type.substr(0, 1).toUpperCase() + type.substr(1)) + "Identify.get()";
}

var declations = {};
var properties = [];
var i = 0;
for(var name in properties_json){
    if(!name)
        continue;

    var info = properties_json[name];

    if(name.startsWith("<")){
        declations[name] = info;
        continue;
    }

    var data = {
        index : i++,
        type : info.type ? typeToString(info.type) : undefined,
        group : info.group ? info.group : "",
        initial : info.initial ? typeToInitialString(info.initial) : undefined,
        name : name,
        inherit : !!info.inherit,
        camelCaseName : toCamelCase(name),
        order : info.order ? "StylePropertyOrder." + info.order : undefined,
        allow : info.allow ? info.allow.map(v=>typeToString(v)) : undefined,
    };

    info.computed && ( data.computed = info.computed.map(v=>toCamelCase(v)) );
    // info.order && ( data.order = "StylePropertyOrder." + info.order );

    properties.push(data);
}

var last_group = null;

var DefaultStyle =
// var stylePropertyNames = const [
//     ${properties.map(v=>`"${v.name}",`).join("\r\n")}
//     ];
    
`

class _PropertyKeyMapItem{
    final int index;
    final String group;
    const _PropertyKeyMapItem(this.index, this.group);
}

class DefaultStyle{
${properties.map(v=>get_default_style(v)).join("\r\n")}
}

`

var last_group = null;
var StyleImpl =
`
abstract class StyleImpl{

${gen_names(properties)}

${gen_keymap(properties)}


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
${gen_property_get(properties)}
    }
  }

  setProperty(name, value){
    if(name is String)
      name = propertyKeyMap[name]?.index;
    if(name == null)
      return null;
    switch(name){
${gen_property_set(properties)}
    }
  }

  operator << (style){
    if(style is List){
        style.forEach((style)=>this << style);
        return;
    }

${gen_copy(properties)}
  }

${properties.map(v=>get_style(v)).join("\r\n")}
}
`;

function gen_copy(properties){
    var rtn = [];
    for(var property of properties){
        rtn.push(`    if(style._${property.camelCaseName} != null) { _${property.camelCaseName} = style._${property.camelCaseName}; didChangeProperty(${property.index}, _${property.camelCaseName}); }`);
    }
    return rtn.join("\r\n");
}

function gen_property_get(properties){
    var rtn = [];
    var i = 0;
    for(var property of properties){
        rtn.push(`      case ${i++} : return internalValue ? _${property.camelCaseName} : ${property.camelCaseName};`);
    }
    return rtn.join("\r\n");
}

function gen_property_set(properties){
    var rtn = [];
    var i = 0;
    for(var property of properties){
        rtn.push(`      case ${i++} : return ${property.camelCaseName} = value;`);
    }
    return rtn.join("\r\n");
}

function gen_names(properties){
    var rtn = [
        `  static const propertyNames = const [`
    ];
    for(var property of properties){
        rtn.push(`    "${property.name}",`);
    }

    rtn.push(`  ];`);
    return rtn.join("\r\n");
}

function gen_keymap(properties){
    var rtn = [
        `  static const propertyKeyMap = const {`
    ];
    var i = 0;
    for(var property of properties){
        rtn.push(`    "${property.name}" : const _PropertyKeyMapItem(${i++}, "${property.group}"),`);
    }
    i = 0;
    for(var property of properties){
        if(property.camelCaseName == property.name){
            i++;
            continue;
        }
        rtn.push(`    "${property.camelCaseName}" : const _PropertyKeyMapItem(${i++}, "${property.group}"),`);
    }

    rtn.push(`  };`);
    return rtn.join("\r\n");
}

function capitalize(s)
{
    return s && s[0].toUpperCase() + s.slice(1);
}

function get_style(info){

    var comment = '';
    if(last_group != info.group && info.group){
        comment = `
  /// ${info.group ? info.group + " group" : info.name}
`;
        last_group = info.group;
    }

    var type = info.type ? `TypedStyleProperty<${info.type}>` : info.computed ? 'SHStyleProperty' : 'LHStyleProperty';

    var args = {};

    if(info.initial)
        args.initial = info.initial;
    if(info.order)
        args.order = info.order;
    if(info.allow)
        args.allow = info.allow;
    if(info.computed)
        args.computed = info.computed;

    var name = info.camelCaseName;
    var Name = name.substr(0,1).toUpperCase() + name.substr(1);
    return comment+
`
  var _${name};
  ${type} get ${name} => _${name} ?? defaultStyle?._${name} ?? ${info.inherit ? ' parent?._'+name+' ?? ': ''} DefaultStyle.${name};
  set ${name}(v){ ${info.group ? '_get'+capitalize(toCamelCase(info.group))+'(); ':''} _get${Name}().value = v; didChangeProperty(${info.index}, _${info.camelCaseName}); }
  _get${Name}() => (_${name} ??= new ${type}( ${gen_args(args, true)} )); 
`
}

function get_default_style(info){

    var comment = '';

    if(!info.group){
        comment = `
  /// ${info.name}
`
    }else if(last_group != info.group){
        comment = `
  /// ${info.group ? info.group + " group" : info.name}
`;
        last_group = info.group;
    }

    var type = info.type ? `TypedStyleProperty<${info.type}>` : info.computed ? 'SHStyleProperty' : 'LHStyleProperty';

    var args = {};
   
    if(info.initial)
        args.initial = info.initial;
    if(info.order)
        args.order = info.order;
    if(info.allow)
        args.allow = info.allow;
    if(info.computed)
        args.computed = info.computed;

    return comment+`  static final ${info.camelCaseName} = new ${type}( ${gen_args(args)} );`;
}

function gen_args(args, isNotDefault){
    var rtn = [];
    for(var name in args){
        var value = args[name];

        if(isNotDefault){
            if(name == "computed"){
                value = value.map(v=>"_get" + v.substr(0,1).toUpperCase() + v.substr(1) + "()");
            }
        }

        switch(name){
            case 'allow': case 'computed':
                rtn.push(`${name} : [${value.join(', ')}]`);
                break;

            default:
                rtn.push(`${name} : ${value}`);
        }

    }

    return rtn.join(', ');
}

 

fs.writeFileSync("src/style_impl.dart", `
part of css;

${DefaultStyle}

${StyleImpl}

`);


function gen_export_keymap(){
    var rtn = [];
    for(var property of properties){
        rtn.push(`  static const int ${property.camelCaseName} = ${property.index};`);
    }
    return rtn.join("\r\n");
}

fs.writeFileSync("src/style_key_map.dart", `
class StyleKeyMap{
${gen_export_keymap(properties)}
}
`);

//console.log(StyleImpl);