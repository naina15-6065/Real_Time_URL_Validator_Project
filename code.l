%{
#include "code.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

"http"       { return HTTP; }
"https"      { return HTTPS; }
"ftp"        { return FTP; }

"://"        { return COLONSLASH; }
":"          { return COLON; }
"/"          { return SLASH; }
"?"          { return QMARK; }
"="          { return EQUAL; }
"&"          { return AMP; }
"#"          { return HASH; }
"."          { return DOT; }

[0-9]+       { yylval.str = strdup(yytext); return NUMBER; }
[a-zA-Z0-9_-]+ { yylval.str = strdup(yytext); return ID; }

[ \t\r\n]+   ;  // ignore whitespace
.            { return yytext[0]; }

%%

int yywrap() { return 1; }