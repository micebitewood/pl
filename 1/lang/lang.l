%{
#include <iostream>
#include <stdlib.h>
using namespace std;
#include "lang.tab.h"
%}

%option noyywrap

%%

                        /* val in yylval.val is the field declared in
                           sql.y with the %union directive. */
begin					{ return BEG;}
if						{ return IF;}
\=						{ return EQUALS;}
[\<\>][\=]?				{ return COMP;}
\!\=					{ return COMP;}
\=\=					{ return COMP;}
[0-9]+					{ yylval.ival = atoi(yytext); return INT;}
[0-9]\.[0-9]+			{ yylval.dval = atof(yytext); return DOUBLE;}
then					{ return THEN;}
\+\=					{ return INC;}
\-\=					{ return DEC;}
\*\=					{ return MULT;}
\/\=					{ return DIV;}
[\+\-]					{ return ADDOP;}
[\*\/]					{ return MULTOP;}
fi						{ return ENDIF;}
read					{ return READ;}
while					{ return WHILE;}
do						{ return DO;}
od						{ return ENDDO;}
write					{ return WRITE;}
end						{ return END;}
\:						{ return COLON;}
int						{ return TYPE;}
float					{ return TYPE;}
double					{ return TYPE;}
long					{ return TYPE;}
byte					{ return TYPE;}
char					{ return TYPE;}
string					{ return TYPE;}
\)						{ return RPAREN;}
\(						{ return LPAREN;}						   
TRUE					{ return BOOLEAN;}
FALSE					{ return BOOLEAN;}
[a-zA-Z][a-zA-Z0-9]*	{ yylval.sval = yytext; return ID;}
\#.+					{ cout << "OH COMMENTS!" << endl;/* Ignore comments. */}
[ \t\r\n;]+              { /* Ignore white characters. */ }
.                       { std::cerr << "Invalid token" << std::endl; exit(1); }

%%
