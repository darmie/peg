// This code was generated by a tool.
// Processing tool available at https://github.com/mezoni/peg

import 'package:peg/expressions.dart';
import 'package:peg/grammar.dart';
import 'package:peg/production_rule.dart';

void main() {
  var parser  = new PegParser(text);
  var result = parser.parse_Grammar();
  if (!parser.success) {
    print("error");
  } else {
    print(result);
  }
}

var text = r'''
%{
import 'package:peg/expressions.dart';
import 'package:peg/grammar.dart';
import 'package:peg/production_rule.dart';

int _escape(int c) {
  switch (c) {
    case 110:
      return 10;      
    case 114:
      return 13;      
    case 116:
      return 9;      
  }    
  return c;
}

Expression _prefix(dynamic prefix, Expression expression, String action) {  
  switch (prefix) {
    case '&':
     expression = new AndPredicateExpression(expression);
     break;
    case '!':
     expression = new NotPredicateExpression(expression);
     break;        
  }
  expression.action = action;
  return expression;
}

dynamic _spacing(s) => s == null ? '' : s;

Expression _suffix(String suffix, Expression expression) {
  switch (suffix) {
    case '?':
      return new OptionalExpression(expression);
    case '*':
      return  new ZeroOrMoreExpression(expression);
    case '+':
      return new OneOrMoreExpression(expression);        
  }
  return expression;
}

}%

Grammar <-
  SPACING Globals? Members? Definition+ EOF { $$ = new Grammar($4, $2, $3); }

Globals <-
  '%{' GlobalsBody* '}%' SPACING { $$ = _flatten(["{", $2, "}", _spacing($4)]).join(); }

GlobalsBody <-
  !'}%' . { $$ = $2; }

Members <-
  '{' ActionBody* '}' SPACING { $$ = _flatten([$1, $2, $3, _spacing($4)]).join(); }
  
Action <-
  '{' ActionBody* '}' SPACING { $$ = _flatten([$1, $2, $3, _spacing($4)]).join(); }

ActionBody <-
  Action
  / !'}' . { $$ = $2; }  

Definition <-
  IDENTIFIER LEFTARROW Expression { $$ = new ProductionRule($1, $3); }

Expression <-
  Sequence (SLASH Sequence { $$ = $2; })* { $$ = new OrderedChoiceExpression(_flatten([$1, $2])); }  

Sequence <-
  Prefix+ { $$ = new SequenceExpression($1); }
  
Prefix <-
  (AND / NOT)? Suffix Action? { $$ = _prefix($1, $2, $3); }  
  
Suffix <-
  Primary (QUESTION / STAR / PLUS)? { $$ = _suffix($2, $1); }  
  
Primary <-
  IDENTIFIER !LEFTARROW   { $$ = new RuleExpression($1); }
  / OPEN Expression CLOSE { $$ = $2; }
  / Literal
  / Class
  / DOT                   { $$ = new AnyCharacterExpression(); }
  
Literal <-
  '\'' (!'\'' Char { $$ = $2; })* '\'' SPACING { $$ = new LiteralExpression(new String.fromCharCodes($2)); } 
  / '"' (!'"' Char { $$ = $2; })* '"' SPACING  { $$ = new LiteralExpression(new String.fromCharCodes($2)); }  
  
Class <-
  '[' (!']' Range { $$ = $2; })* ']' SPACING { $$ = new CharacterClassExpression($2); }
  
Range <-
  Char '-' Char { $$ = [$1, $3]; }
  / Char        { $$ = [$1, $1]; }
  
Char <-
  '\\' ["'\-\[-\]nrt] { $$ = _escape($2.codeUnitAt(0)); }  
  / HEX_NUMBER
  / !'\\' !EOL .      { $$ = _toRune($3); }
  
# Tokens

EOF <-
  !.

IDENTIFIER <-
  IDENT_START IDENT_CONT* SPACING { $$ = _flatten([$1, $2]).join(); }
  
IDENT_START <-
  [a-zA-Z_]
  
IDENT_CONT <-
  IDENT_START / [0-9]

LEFTARROW <-
  '<-' SPACING
  
SLASH <-
  '/' SPACING
  
AND <-
  '&' SPACING { $$ = $1; }
  
NOT <-
  '!' SPACING { $$ = $1; }
  
QUESTION <-
  '?' SPACING { $$ = $1; }
  
STAR <-
  '*' SPACING { $$ = $1; }
  
PLUS <-
  '+' SPACING { $$ = $1; }
  
OPEN <-
  '(' SPACING
  
CLOSE <-
  ')' SPACING
  
DOT <-
  '.' SPACING

HEX_NUMBER <-
  '\\u' [0-9a-fA-F]+ { $$ = int.parse($2.join(), radix: 16); }
  
SPACING <-
  (SPACE / COMMENT)*
  
COMMENT <-
  '#' (!EOL .)* EOL?
  
SPACE <-
  [ \t] 
  / EOL
 
EOL <-
  '\r\n'
  / [\n\r]
  
''';

int _escape(int c) {
  switch (c) {
    case 110:
      return 10;
    case 114:
      return 13;
    case 116:
      return 9;
  }
  return c;
}

Expression _prefix(dynamic prefix, Expression expression, String action) {
  switch (prefix) {
    case '&':
      expression = new AndPredicateExpression(expression);
      break;
    case '!':
      expression = new NotPredicateExpression(expression);
      break;
  }
  expression.action = action;
  return expression;
}

dynamic _spacing(s) => s == null ? '' : s;

Expression _suffix(String suffix, Expression expression) {
  switch (suffix) {
    case '?':
      return new OptionalExpression(expression);
    case '*':
      return new ZeroOrMoreExpression(expression);
    case '+':
      return new OneOrMoreExpression(expression);
  }
  return expression;
}
class PegParser {
  static final List<String> _ascii =
      new List<String>.generate(128, (c) => new String.fromCharCode(c));
  List _cache;
  int _cachePos;
  List<int> _cacheRule;
  List<int> _cacheState;
  int _ch;
  List<int> _code = [
      10,
      423,
      9,
      420,
      12,
      418,
      11,
      8,
      10,
      56,
      9,
      53,
      13,
      51,
      14,
      16,
      9,
      48,
      13,
      30,
      11,
      22,
      10,
      28,
      9,
      25,
      13,
      5,
      3,
      0,
      13,
      23,
      11,
      34,
      10,
      21,
      9,
      18,
      13,
      9,
      5,
      7,
      13,
      16,
      3,
      11,
      13,
      46,
      11,
      50,
      10,
      44,
      9,
      41,
      12,
      39,
      2,
      32,
      14,
      60,
      9,
      36,
      12,
      34,
      6,
      66,
      11,
      36,
      1,
      8,
      71,
      11,
      36,
      8,
      75,
      11,
      77,
      10,
      76,
      9,
      73,
      12,
      71,
      5,
      58,
      14,
      87,
      11,
      89,
      10,
      67,
      9,
      64,
      12,
      62,
      6,
      97,
      5,
      60,
      1,
      5,
      69,
      11,
      10,
      8,
      106,
      11,
      108,
      10,
      109,
      9,
      106,
      12,
      104,
      2,
      78,
      14,
      118,
      11,
      120,
      10,
      100,
      9,
      97,
      13,
      91,
      11,
      128,
      10,
      89,
      9,
      86,
      12,
      84,
      2,
      80,
      14,
      138,
      11,
      122,
      2,
      82,
      11,
      10,
      12,
      95,
      6,
      148,
      2,
      93,
      1,
      2,
      102,
      11,
      10,
      7,
      157,
      11,
      159,
      10,
      409,
      9,
      406,
      12,
      404,
      11,
      167,
      10,
      142,
      9,
      139,
      12,
      137,
      11,
      175,
      10,
      123,
      9,
      120,
      13,
      118,
      3,
      111,
      14,
      185,
      11,
      187,
      10,
      135,
      9,
      132,
      13,
      125,
      11,
      177,
      13,
      130,
      3,
      127,
      11,
      10,
      11,
      203,
      10,
      151,
      9,
      148,
      12,
      146,
      5,
      144,
      11,
      10,
      11,
      215,
      10,
      402,
      9,
      399,
      12,
      397,
      11,
      223,
      10,
      381,
      9,
      378,
      13,
      376,
      7,
      231,
      11,
      233,
      10,
      374,
      9,
      371,
      12,
      369,
      8,
      241,
      9,
      175,
      13,
      162,
      11,
      247,
      10,
      160,
      9,
      157,
      12,
      155,
      2,
      153,
      11,
      10,
      13,
      173,
      11,
      261,
      10,
      171,
      9,
      168,
      12,
      166,
      2,
      164,
      11,
      10,
      11,
      273,
      10,
      367,
      9,
      364,
      12,
      362,
      11,
      281,
      10,
      324,
      9,
      321,
      12,
      178,
      11,
      169,
      6,
      291,
      11,
      205,
      12,
      198,
      11,
      297,
      10,
      187,
      9,
      184,
      12,
      182,
      2,
      180,
      11,
      10,
      11,
      217,
      11,
      311,
      10,
      196,
      9,
      193,
      12,
      191,
      2,
      189,
      11,
      10,
      13,
      277,
      11,
      325,
      10,
      275,
      9,
      272,
      12,
      257,
      2,
      200,
      14,
      335,
      9,
      252,
      12,
      250,
      6,
      341,
      2,
      202,
      11,
      345,
      10,
      248,
      9,
      245,
      12,
      221,
      2,
      204,
      3,
      206,
      13,
      239,
      11,
      359,
      10,
      237,
      9,
      234,
      12,
      232,
      5,
      223,
      7,
      369,
      3,
      225,
      12,
      243,
      6,
      375,
      2,
      241,
      6,
      379,
      11,
      36,
      1,
      2,
      255,
      11,
      10,
      12,
      270,
      2,
      259,
      14,
      392,
      9,
      265,
      12,
      263,
      6,
      398,
      2,
      261,
      11,
      347,
      2,
      268,
      11,
      10,
      13,
      308,
      11,
      410,
      10,
      306,
      9,
      303,
      12,
      301,
      2,
      279,
      14,
      420,
      9,
      296,
      12,
      294,
      6,
      426,
      2,
      281,
      11,
      430,
      10,
      292,
      9,
      289,
      12,
      285,
      11,
      347,
      2,
      283,
      11,
      347,
      13,
      287,
      11,
      347,
      2,
      299,
      11,
      10,
      13,
      319,
      11,
      454,
      10,
      317,
      9,
      314,
      12,
      312,
      2,
      310,
      11,
      10,
      8,
      466,
      9,
      359,
      13,
      335,
      11,
      472,
      10,
      333,
      9,
      330,
      12,
      328,
      2,
      326,
      11,
      10,
      13,
      346,
      11,
      486,
      10,
      344,
      9,
      341,
      12,
      339,
      2,
      337,
      11,
      10,
      13,
      357,
      11,
      500,
      10,
      355,
      9,
      352,
      12,
      350,
      2,
      348,
      11,
      10,
      8,
      512,
      11,
      130,
      14,
      516,
      9,
      394,
      12,
      392,
      11,
      522,
      10,
      390,
      9,
      387,
      12,
      385,
      2,
      383,
      11,
      10,
      11,
      225,
      11,
      536,
      10,
      416,
      9,
      413,
      13,
      411,
      6,
      544,
      1];
  int _column;
  int _cursor;
  List _data = [
      2,
      9,
      9,
      32,
      32,
      0,
      28,
      [13, 10],
      "\r\n",
      0,
      40,
      2,
      10,
      10,
      13,
      13,
      0,
      44,
      0,
      [38, 42],
      [[0, 1114111, [38, 42]]],
      36,
      34,
      0,
      32,
      0,
      [26, 30],
      [[0, 1114111, [26, 30]]],
      24,
      33,
      0,
      20,
      35,
      "#",
      0,
      [64, 68],
      0,
      [62],
      [[0, 1114111, [62]]],
      0,
      [56, 58, 69],
      0,
      [54],
      [[0, 1114111, [54]]],
      52,
      32,
      0,
      48,
      0,
      [18, 46],
      [[0, 1114111, [18, 46]]],
      0,
      14,
      3,
      [12],
      [[0, 1114111, [12]]],
      10,
      31,
      [37, 123],
      "%{",
      [125, 37],
      "}%",
      2,
      [95, 99],
      0,
      [93],
      [[0, 1114111, [93]]],
      91,
      2,
      [125, 37],
      "}%",
      8,
      [83, 85, 100, 102],
      0,
      [81],
      [[0, 1114111, [81]]],
      79,
      1,
      123,
      "{",
      123,
      "{",
      125,
      "}",
      8,
      [134, 136, 140, 142],
      0,
      [132],
      [[0, 1114111, [132]]],
      130,
      4,
      0,
      126,
      125,
      "}",
      2,
      [146, 150],
      0,
      [124, 144],
      [[0, 1114111, [124, 144]]],
      122,
      5,
      125,
      "}",
      8,
      [114, 116, 151, 153],
      0,
      [112],
      [[0, 1114111, [112]]],
      110,
      3,
      3,
      65,
      90,
      95,
      95,
      97,
      122,
      0,
      181,
      0,
      [179],
      [[0, 1114111, [179]]],
      177,
      18,
      0,
      193,
      1,
      48,
      57,
      0,
      197,
      0,
      [191, 195],
      [[0, 1114111, [191, 195]]],
      189,
      19,
      4,
      [173, 183, 199],
      0,
      [171],
      [[0, 1114111, [171]]],
      169,
      17,
      [60, 45],
      "<-",
      0,
      [209, 211],
      0,
      [207],
      [[0, 1114111, [207]]],
      205,
      20,
      38,
      "&",
      2,
      [253, 255],
      0,
      [251],
      [[0, 1114111, [251]]],
      249,
      22,
      0,
      245,
      33,
      "!",
      2,
      [267, 269],
      0,
      [265],
      [[0, 1114111, [265]]],
      263,
      23,
      0,
      259,
      0,
      [243, 257],
      [[0, 1114111, [243, 257]]],
      2,
      [287, 289],
      40,
      "(",
      0,
      [303, 305],
      0,
      [301],
      [[0, 1114111, [301]]],
      299,
      27,
      41,
      ")",
      0,
      [317, 319],
      0,
      [315],
      [[0, 1114111, [315]]],
      313,
      28,
      4,
      [295, 307, 309],
      39,
      "\'",
      39,
      "\'",
      92,
      "\\",
      7,
      34,
      34,
      39,
      39,
      45,
      45,
      91,
      93,
      110,
      110,
      114,
      114,
      116,
      116,
      2,
      [351, 353],
      [92, 117],
      "\\u",
      3,
      48,
      57,
      65,
      70,
      97,
      102,
      2,
      [365, 367],
      0,
      [363],
      [[0, 1114111, [363]]],
      361,
      30,
      0,
      357,
      92,
      "\\",
      4,
      [373, 377, 381],
      0,
      [349, 355, 371],
      [[0, 1114111, [349, 355, 371]]],
      347,
      15,
      2,
      [339, 343],
      0,
      [337],
      [[0, 1114111, [337]]],
      39,
      "\'",
      8,
      [331, 333, 382, 384],
      34,
      "\"",
      34,
      "\"",
      2,
      [396, 400],
      0,
      [394],
      [[0, 1114111, [394]]],
      34,
      "\"",
      8,
      [388, 390, 402, 404],
      0,
      [329, 386],
      [[0, 1114111, [329, 386]]],
      327,
      12,
      0,
      323,
      91,
      "[",
      93,
      "]",
      45,
      "-",
      4,
      [436, 438, 440],
      1,
      444,
      0,
      [434, 442],
      [[0, 1114111, [434, 442]]],
      432,
      14,
      2,
      [424, 428],
      0,
      [422],
      [[0, 1114111, [422]]],
      93,
      "]",
      8,
      [416, 418, 446, 448],
      0,
      [414],
      [[0, 1114111, [414]]],
      412,
      13,
      0,
      408,
      46,
      ".",
      0,
      [460, 462],
      0,
      [458],
      [[0, 1114111, [458]]],
      456,
      29,
      1,
      452,
      0,
      [285, 293, 321, 406, 450],
      [[0, 1114111, [285, 293, 321, 406, 450]]],
      283,
      11,
      63,
      "?",
      2,
      [478, 480],
      0,
      [476],
      [[0, 1114111, [476]]],
      474,
      24,
      0,
      470,
      42,
      "*",
      2,
      [492, 494],
      0,
      [490],
      [[0, 1114111, [490]]],
      488,
      25,
      0,
      484,
      43,
      "+",
      2,
      [506, 508],
      0,
      [504],
      [[0, 1114111, [504]]],
      502,
      26,
      0,
      498,
      0,
      [468, 482, 496],
      [[0, 1114111, [468, 482, 496]]],
      2,
      [279, 464],
      0,
      [277],
      [[0, 1114111, [277]]],
      275,
      10,
      4,
      [239, 271, 510],
      0,
      [237],
      [[0, 1114111, [237]]],
      235,
      9,
      1,
      229,
      0,
      [227],
      [[0, 1114111, [227]]],
      225,
      8,
      47,
      "/",
      0,
      [528, 530],
      0,
      [526],
      [[0, 1114111, [526]]],
      524,
      21,
      2,
      [520, 532],
      0,
      [518],
      [[0, 1114111, [518]]],
      2,
      [221, 514],
      0,
      [219],
      [[0, 1114111, [219]]],
      217,
      7,
      4,
      [165, 201, 213],
      0,
      [163],
      [[0, 1114111, [163]]],
      161,
      6,
      0,
      542,
      0,
      [540],
      [[0, 1114111, [540]]],
      538,
      16,
      16,
      [6, 73, 104, 155, 534],
      0,
      [4],
      [[0, 1114111, [4]]],
      2,
      0];
  List<String> _expected;
  int _failurePos;
  int _flag;
  int _inputLen;
  int _line;
  Object _result;
  List<int> _runes;
  int _testing;
  bool success;

  PegParser(String text) {
    if (text == null) {
      throw new ArgumentError('text: $text');
    }
    _runes = _toRunes(text);
    _inputLen = _runes.length;
    if (_inputLen >= 0x3fffffe8 / 32) {
      throw new StateError('File size to big: $_inputLen');
    }
    reset(0);
  }

  dynamic parse_Grammar() {
    _decode(0);
    return _result;
  }

  dynamic _action(int cp, v) {
    var $$ = _result;
    switch (cp) {
      case 99:
        final $1 = v[0],
            $2 = v[1];
        $$ = $2;
        return $$;
      case 102:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2],
            $4 = v[3];
        $$ = _flatten(["{", $2, "}", _spacing($4)]).join();
        return $$;
      case 142:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2],
            $4 = v[3];
        $$ = _flatten([$1, $2, $3, _spacing($4)]).join();
        return $$;
      case 150:
        final $1 = v[0],
            $2 = v[1];
        $$ = $2;
        return $$;
      case 153:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2],
            $4 = v[3];
        $$ = _flatten([$1, $2, $3, _spacing($4)]).join();
        return $$;
      case 199:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2];
        $$ = _flatten([$1, $2]).join();
        return $$;
      case 255:
        final $1 = v[0],
            $2 = v[1];
        $$ = $1;
        return $$;
      case 269:
        final $1 = v[0],
            $2 = v[1];
        $$ = $1;
        return $$;
      case 289:
        final $1 = v[0],
            $2 = v[1];
        $$ = new RuleExpression($1);
        return $$;
      case 309:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2];
        $$ = $2;
        return $$;
      case 353:
        final $1 = v[0],
            $2 = v[1];
        $$ = _escape($2.codeUnitAt(0));
        return $$;
      case 367:
        final $1 = v[0],
            $2 = v[1];
        $$ = int.parse($2.join(), radix: 16);
        return $$;
      case 381:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2];
        $$ = _toRune($3);
        return $$;
      case 343:
        final $1 = v[0],
            $2 = v[1];
        $$ = $2;
        return $$;
      case 384:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2],
            $4 = v[3];
        $$ = new LiteralExpression(new String.fromCharCodes($2));
        return $$;
      case 400:
        final $1 = v[0],
            $2 = v[1];
        $$ = $2;
        return $$;
      case 404:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2],
            $4 = v[3];
        $$ = new LiteralExpression(new String.fromCharCodes($2));
        return $$;
      case 440:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2];
        $$ = [$1, $3];
        return $$;
      case 444:
        final $1 = v;
        $$ = [$1, $1];
        return $$;
      case 428:
        final $1 = v[0],
            $2 = v[1];
        $$ = $2;
        return $$;
      case 448:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2],
            $4 = v[3];
        $$ = new CharacterClassExpression($2);
        return $$;
      case 452:
        final $1 = v;
        $$ = new AnyCharacterExpression();
        return $$;
      case 480:
        final $1 = v[0],
            $2 = v[1];
        $$ = $1;
        return $$;
      case 494:
        final $1 = v[0],
            $2 = v[1];
        $$ = $1;
        return $$;
      case 508:
        final $1 = v[0],
            $2 = v[1];
        $$ = $1;
        return $$;
      case 464:
        final $1 = v[0],
            $2 = v[1];
        $$ = _suffix($2, $1);
        return $$;
      case 510:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2];
        $$ = _prefix($1, $2, $3);
        return $$;
      case 229:
        final $1 = v;
        $$ = new SequenceExpression($1);
        return $$;
      case 532:
        final $1 = v[0],
            $2 = v[1];
        $$ = $2;
        return $$;
      case 514:
        final $1 = v[0],
            $2 = v[1];
        $$ = new OrderedChoiceExpression(_flatten([$1, $2]));
        return $$;
      case 213:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2];
        $$ = new ProductionRule($1, $3);
        return $$;
      case 534:
        final $1 = v[0],
            $2 = v[1],
            $3 = v[2],
            $4 = v[3],
            $5 = v[4];
        $$ = new Grammar($4, $2, $3);
        return $$;
    }
    throw new StateError(
        "Instruction at address '$cp' nas no semantic action.");
  }

  void _addToCache(dynamic result, int start, int id) {
    var cached = _cache[start];
    if (cached == null) {
      _cacheRule[start] = id;
      _cache[start] = [result, _cursor, success];
    } else {
      var slot = start >> 5;
      var r1 = (slot << 5) & 0x3fffffff;
      var mask = 1 << (start - r1);
      if ((_cacheState[slot] & mask) == 0) {
        _cacheState[slot] |= mask;
        cached = [new List.filled(3, 0), new Map<int, List>()];
        _cache[start] = cached;
      }
      slot = id >> 5;
      r1 = (slot << 5) & 0x3fffffff;
      mask = 1 << (id - r1);
      cached[0][slot] |= mask;
      cached[1][id] = [result, _cursor, success];
    }
    if (_cachePos < start) {
      _cachePos = start;
    }
  }

  void _andPredicate(int cp) {
    var ch = _ch;
    var cursor = _cursor;
    var testing = _testing;
    _testing = _inputLen + 1;
    _decode(_code[cp + 1]);
    _testing = testing;
    _cursor = cursor;
    _ch = ch;
  }

  void _anyCharacter(int cp) {
    success = _cursor < _inputLen;
    if (success) {
      if (_ch < 128) {
        _result = _ascii[_ch];
      } else {
        _result = new String.fromCharCode(_ch);
      }
      _cursor++;
      if (_cursor < _inputLen) {
        _ch = _runes[_cursor];
      } else {
        _ch = -1;
      }
    } else {
      _result = null;
      if (_cursor > _testing && _cursor > _failurePos) {
        _expected = [];
        _failurePos = _cursor;
      }
    }
  }

  void _calculatePos(int pos) {
    if (pos == null || pos < 0 || pos > _inputLen) {
      return;
    }
    _line = 1;
    _column = 1;
    for (var i = 0; i < _inputLen && i < pos; i++) {
      var c = _runes[i];
      if (c == 13) {
        _line++;
        _column = 1;
        if (i + 1 < _inputLen && _runes[i + 1] == 10) {
          i++;
        }
      } else if (c == 10) {
        _line++;
        _column = 1;
      } else {
        _column++;
      }
    }
  }

  void _character(int cp) {
    var offset = _code[cp + 1];
    _result = _data[offset + 1];
    success = _cursor < _inputLen;
    if (success && _ch == _data[offset + 0]) {
      _cursor++;
      if (_cursor < _inputLen) {
        _ch = _runes[_cursor];
      } else {
        _ch = -1;
      }
    } else {
      success = false;
      if (_cursor > _testing && _cursor >= _failurePos) {
        if (_cursor > _failurePos) {
          _expected = [];
          _failurePos = _cursor;
        }
        _expected.add(_result);
      }
    }
  }

  void _characterClass(int cp) {
    var offset = _code[cp + 1];
    success = _cursor < _inputLen;
    if (success) {
      int length = _data[offset + 0];
      int ranges = offset + 1;
      for (var i = 0; i < length; i++, ranges += 2) {
        if (_ch >= _data[ranges + 0]) {
          if (_ch <= _data[ranges + 1]) {
            if (_ch < 128) {
              _result = _ascii[_ch];
            } else {
              _result = new String.fromCharCode(_ch);
            }
            _cursor++;
            if (_cursor < _inputLen) {
              _ch = _runes[_cursor];
            } else {
              _ch = -1;
            }
            return;
          }
        } else {
          break;
        }
      }
      success = false;
    }
    _result = null;
    if (_cursor > _testing && _cursor > _failurePos) {
      _expected = [];
      _failurePos = _cursor;
    }
  }

  void _decode(int cp) {
    var op = _code[cp];
    switch (op) {
      case 0:
        return _andPredicate(cp);
      case 1:
        return _anyCharacter(cp);
      case 3:
        return _characterClass(cp);
      case 2:
        return _character(cp);
      case 4:
        return _empty(cp);
      case 5:
        return _literal(cp);
      case 6:
        return _notPredicate(cp);
      case 7:
        return _oneOrMore(cp);
      case 8:
        return _optional(cp);
      case 9:
        return _orderedChoice(cp);
      case 10:
        return _productionRule(cp);
      case 11:
        return _rule(cp);
      case 12:
        return _sequence(cp);
      case 13:
        return _sequenceElement(cp);
      case 14:
        return _zeroOrMore(cp);
    }
    throw new StateError("Illegal instruction op");
  }

  void _empty(int cp) {
    _result = "";
    success = true;
  }

  List _flatten(dynamic value) {
    if (value is List) {
      var result = [];
      var length = value.length;
      for (var i = 0; i < length; i++) {
        var element = value[i];
        if (element is Iterable) {
          result.addAll(_flatten(element));
        } else {
          result.add(element);
        }
      }
      return result;
    } else if (value is Iterable) {
      var result = [];
      for (var element in value) {
        if (element is! List) {
          result.add(element);
        } else {
          result.addAll(_flatten(element));
        }
      }
    }
    return [value];
  }

  dynamic _getFromCache(int id) {
    var result = _cache[_cursor];
    if (result == null) {
      return null;
    }
    var slot = _cursor >> 5;
    var r1 = (slot << 5) & 0x3fffffff;
    var mask = 1 << (_cursor - r1);
    if ((_cacheState[slot] & mask) == 0) {
      if (_cacheRule[_cursor] == id) {
        _cursor = result[1];
        success = result[2];
        if (_cursor < _inputLen) {
          _ch = _runes[_cursor];
        } else {
          _ch = -1;
        }
        return result;
      } else {
        return null;
      }
    }
    slot = id >> 5;
    r1 = (slot << 5) & 0x3fffffff;
    mask = 1 << (id - r1);
    if ((result[0][slot] & mask) == 0) {
      return null;
    }
    var data = result[1][id];
    _cursor = data[1];
    success = data[2];
    if (_cursor < _inputLen) {
      _ch = _runes[_cursor];
    } else {
      _ch = -1;
    }
    return data;
  }

  void _literal(int cp) {
    var offset = _code[cp + 1];
    List<int> runes = _data[offset + 0];
    var length = runes.length;
    _result = _data[offset + 1];
    success = _cursor + length <= _inputLen;
    if (success) {
      for (var i = 0; i < length; i++) {
        if (runes[i] != _runes[_cursor + i]) {
          success = false;
          break;
        }
      }
      if (success) {
        _cursor += length;
        if (_cursor < _inputLen) {
          _ch = _runes[_cursor];
        } else {
          _ch = -1;
        }
        return;
      }
    }
    // TODO: failure
    if (_cursor > _testing && _cursor >= _failurePos) {
      if (_cursor > _failurePos) {
        _expected = [];
        _failurePos = _cursor;
      }
      _expected.add(_result);
    }
  }

  void _notPredicate(int cp) {
    var ch = _ch;
    var cursor = _cursor;
    var testing = _testing;
    _testing = _inputLen + 1;
    _decode(_code[cp + 1]);
    _testing = testing;
    _cursor = cursor;
    _ch = ch;
    success = !success;
  }

  void _oneOrMore(int cp) {
    cp = _code[cp + 1];
    _decode(cp);
    if (!success) {
      return;
    }
    var elements = [_result];
    var testing = _testing;
    while (true) {
      _testing = _inputLen + 1;
      _decode(cp);
      if (!success) {
        break;
      }
      elements.add(_result);
    }
    _testing = testing;
    _result = elements;
    success = true;
  }

  void _optional(int cp) {
    _decode(_code[cp + 1]);
    success = true;
  }

  void _orderedChoice(int cp) {
    var offset = _code[cp + 1];
    List transitions = _data[offset + 2];
    List<int> instructions;
    for (var i = 0; i < transitions.length; i++) {
      List transition = transitions[i];
      if (_ch >= transition[0]) {
        if (_ch <= transition[1]) {
          instructions = transition[2];
          break;
        }
      } else {
        break;
      }
    }
    if (instructions == null) {
      if (_ch == -1) {
        instructions = _data[offset + 1];
      } else {
        var flag = _data[offset + 0];
        if (flag & 1 != 0) {
          if (flag & 2 != 0) {
            _result = [];
          } else {
            _result = null;
          }
          success = true;
        } else {
          _result = null;
          success = false;
        }
        // TODO: failure
        // TODO: !!!Expectations!!!
        if (_cursor > _testing && _cursor > _failurePos) {
          _expected = [];
          _failurePos = _cursor;
        }
        return;
      }
    }
    var index = 0;
    var count = instructions.length - 1;
    while (true) {
      _decode(instructions[index++]);
      if (success) {
        break;
      } else if (count-- == 0) {
        _result = null;
        success = false;
        // TODO: failure
        // TODO: !!!Expectations!!!
        if (_cursor > _testing && _cursor > _failurePos) {
          _expected = [];
          _failurePos = _cursor;
        }
        break;
      }
    }
  }

  void _productionRule(int cp) {
    // TODO: Memoization goes here
    // TODO: If memoized expectation errors goes here
    var offset = _code[cp + 1];
    _decode(_data[offset + 0]);
    // TODO: Memoization goes here
  }

  void _rule(int cp) {
    _decode(_code[cp + 1]);
  }

  void _sequence(int cp) {
    var index = 0;
    var ch = _ch;
    var cursor = _cursor;
    var offset = _code[cp + 1];
    List<int> instructions = _data[offset + 1];
    var count = instructions.length;
    cp = instructions[index++];
    _decode(cp);
    if (!success) {
      return;
    }
    var result = new List(count--);
    result[0] = _result;
    var flag = _data[offset + 0];
    if (flag & 1 != 0) {
      if (count == 0) {
        result = _action(cp, result);
      } else {
        result[0] = _action(cp, result);
      }
    }
    flag >>= 1;
    for ( ; count-- > 0; flag >>= 1, index++) {
      cp = instructions[index];
      _decode(cp);
      if (!success) {
        _ch = ch;
        _cursor = cursor;
        return;
      }
      result[index] = _result;
      if (flag & 1 != 0) {
        if (count == 0) {
          result = _action(cp, result);
        } else {
          result[index] = _action(cp, result);
        }
      }
    }
    _result = result;
  }

  void _sequenceElement(int cp) {
    var offset = _code[cp + 1];
    cp = _data[offset + 1];
    _decode(cp);
    if (!success) {
      return;
    }
    if (_data[offset + 0] & 1 != 0) {
      _result = _action(cp, _result);
    }
  }

  int _toRune(String string) {
    if (string == null) {
      throw new ArgumentError("string: $string");
    }

    var length = string.length;
    if (length == 0) {
      throw new StateError("An empty string contains no elements.");
    }

    var start = string.codeUnitAt(0);
    if (length == 1) {
      return start;
    }

    if ((start & 0xFC00) == 0xD800) {
      var end = string.codeUnitAt(1);
      if ((end & 0xFC00) == 0xDC00) {
        return (0x10000 + ((start & 0x3FF) << 10) + (end & 0x3FF));
      }
    }

    return start;
  }

  List<int> _toRunes(String string) {
    if (string == null) {
      throw new ArgumentError("string: $string");
    }

    var length = string.length;
    if (length == 0) {
      return const <int>[];
    }

    var runes = <int>[];
    runes.length = length;
    var i = 0;
    var pos = 0;
    for ( ; i < length; pos++) {
      var start = string.codeUnitAt(i);
      i++;
      if ((start & 0xFC00) == 0xD800 && i < length) {
        var end = string.codeUnitAt(i);
        if ((end & 0xFC00) == 0xDC00) {
          runes[pos] = (0x10000 + ((start & 0x3FF) << 10) + (end & 0x3FF));
          i++;
        } else {
          runes[pos] = start;
        }
      } else {
        runes[pos] = start;
      }
    }

    runes.length = pos;
    return runes;
  }

  void _zeroOrMore(int cp) {
    cp = _code[cp + 1];
    var testing = _testing;
    _testing = _inputLen + 1;
    _decode(cp);
    if (!success) {
      _result = const [];
      _testing = testing;
      success = true;
      return;
    }
    var elements = [_result];
    while (true) {
      _testing = _inputLen + 1;
      _decode(cp);
      if (!success) {
        break;
      }
      elements.add(_result);
    }
    _testing = testing;
    _result = elements;
    success = true;
  }

  int get column {
    if (_column == -1) {
      _calculatePos(_failurePos);
    }
    return _column;
  }

  List<String> get expected {
    var set = new Set<String>();
    set.addAll(_expected);
    if (set.contains(null)) {
      set.clear();
    }
    var result = set.toList();
    result.sort();
    return result;
  }

  int get line {
    if (_line == -1) {
      _calculatePos(_failurePos);
    }
    return _line;
  }

  void reset(int pos) {
    if (pos == null) {
      throw new ArgumentError('pos: $pos');
    }
    if (pos < 0 || pos > _inputLen) {
      throw new RangeError('pos');
    }
    _result = null;
    success = true;
    _cursor = pos;
    _cache = new List(_inputLen + 1);
    _cachePos = -1;
    _cacheRule = new List(_inputLen + 1);
    _cacheState = new List.filled(((_inputLen + 1) >> 5) + 1, 0);
    _ch = -1;
    _column = -1;
    _expected = [];
    _failurePos = -1;
    _flag = 0;
    _line = -1;
    success = true;
    _testing = -1;
    if (_cursor < _inputLen) {
      _ch = _runes[_cursor];
    }
  }

}
