%{
#include <iostream>
#include <stdlib.h>
using namespace std;
#include "sql.tab.h"
%}

%option noyywrap

%%

                        /* val in yylval.val is the field declared in
                           sql.y with the %union directive. */
SELECT					{return SELECT;}
\*						{return STAR;}
DISTINCT				{return DISTINCT;}
ALL                     {return ALL;}
ANY                     {return ANY;}
SOME                    {return SOME;}
FROM                    {return FROM;}
WHERE                   {return WHERE;}
GROUP                   {return GROUP;}
BY                      {return BY;}
ORDER                   {return ORDER;}
UNION                   {return UNION;}
MINUS                   {return MINUS;}
EXCEPT                  {return EXCEPT;}
INTERSECT               {return INTERSECT;}
LIMIT                   {return LIMIT;}
OFFSET                  {return OFFSET;}
LEFT                    {return DIRECT;}
RIGHT                   {return DIRECT;}
OUTER                   {return OUTER;}
INNER                   {return JSELECT;}
CROSS                   {return JSELECT;}
ON                      {return ON;}
IN                      {return IN;}
AS                      {return AS;}
JOIN                    {return JOIN;}
IS                      {return IS;}
NOT                     {return NOT;}
NULL                    {return NIL;}
EXISTS                  {return EXISTS;}
DATE                    {printf("%s\n", yytext); return DATE;}
TIME                    {printf("%s\n", yytext); return TIME;}
TRUE                    {printf("%s\n", yytext); return BOOLEAN;}
FALSE                   {printf("%s\n", yytext); return BOOLEAN;}
ASC                     {return ASC;}
DESC                    {return DESC;}
NULLS                   {return NULLS;}
FIRST                   {return FIRST;}
LAST                    {return LAST;}
HAVING                  {return HAVING;}
NATURAL                 {return JSELECT;}
\<\>					{return COMP;}
\<\=                    {return COMP;}
\>\=                    {return COMP;}
\=                      {return COMP;}
\<                      {return COMP;}
\>                      {return COMP;}
[a-zA-Z_][a-zA-Z0-9_]*			{yylval.sval = yytext; return STRING;}
\'[a-zA-Z0-9_]*\'				{printf("String: %s\n", yytext); return STRING;}
\$\$[a-zA-Z0-9_]*\$\$					{printf("dollarQuotedString: %s\n", yytext);}
\-						{return NEG;}
[0-9]+(.[0-9]+)?		{yylval.dval = atof(yytext); return DECIMAL;}
[0-9]{4}\-[0-9]{2}\-[0-9]{2}					{printf("date:%s\n", yytext); return DATE;}
[0-9]{2}:[0-9]{2}:[0-9]{2}						{printf("time:%s\n", yytext); return TIME;}
\(						{return LPAREN;}
\)						{return RPAREN;}
\.						{return DOT;}
\,						{return COMMA;}
[ \t\r\n;]+              { /* Ignore white characters. */ }
.                       { std::cerr << "Invalid token" << std::endl; exit(1); }

%%
