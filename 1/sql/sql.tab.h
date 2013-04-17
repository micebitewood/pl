/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SQL_TAB_H_INCLUDED
# define YY_YY_SQL_TAB_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     LPAREN = 258,
     RPAREN = 259,
     DOT = 260,
     COMMA = 261,
     COMP = 262,
     DIRECT = 263,
     OUTER = 264,
     NEG = 265,
     DATE = 266,
     TIME = 267,
     BOOLEAN = 268,
     SELECT = 269,
     DISTINCT = 270,
     ALL = 271,
     STAR = 272,
     FROM = 273,
     AS = 274,
     JOIN = 275,
     JSELECT = 276,
     ON = 277,
     WHERE = 278,
     GROUP = 279,
     BY = 280,
     HAVING = 281,
     UNION = 282,
     MINUS = 283,
     EXCEPT = 284,
     INTERSECT = 285,
     ORDER = 286,
     LIMIT = 287,
     OFFSET = 288,
     NOT = 289,
     EXISTS = 290,
     IS = 291,
     NIL = 292,
     IN = 293,
     ANY = 294,
     SOME = 295,
     ASC = 296,
     DESC = 297,
     NULLS = 298,
     FIRST = 299,
     LAST = 300,
     DECIMAL = 301,
     STRING = 302
   };
#endif


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 2058 of yacc.c  */
#line 9 "sql.y"

	char *sval;
	double dval;
    /* You may include additional fields as you want. */
    /* char op; */


/* Line 2058 of yacc.c  */
#line 112 "sql.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_SQL_TAB_H_INCLUDED  */
