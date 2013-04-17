%{
#include <iostream>
using namespace std;
int yylex(); // A function that is to be generated and provided by flex,
             // which returns a next token when called repeatedly.
int yyerror(const char *p) { std::cerr << "error: " << p << std::endl; };
%}

%union {
	char *sval;
	double dval;
	int ival;
    /* You may include additional fields as you want. */
    /* char op; */
};

%start proc
%token BEG IF EQUALS COMP THEN INC DEC MULT DIV ADDOP MULTOP ENDIF READ WHILE DO ENDDO WRITE END COLON TYPE RPAREN LPAREN BOOLEAN
%token <dval> DOUBLE
%token <ival> INT
%token <sval> ID   /* 'val' is the (only) field declared in %union
                       which represents the type of the token. */
%error-verbose

%%

proc : ID LPAREN para RPAREN BEG body END			{ cout << "BEGIN........" << endl;}
		;
	
para : TYPE COLON ID								{ cout << "PARA........." << endl;}
	;

body : 
	| body calc
	| body IF booleanExpr THEN body ENDIF			{ cout << "IF THEN" << endl;}
	| body rw_Clause								{ cout << "READ OR WRITE?" << endl;}
	| body WHILE booleanExpr DO body ENDDO			{ cout << "WHILE DO" << endl;}
	;

calc : ID equal valExpr								{ cout << "CALC........" << endl;}
	;

equal : EQUALS
	| INC											{ cout << "ADD BY ..." << endl;}
	| DEC											{ cout << "MINUS BY ..." << endl;}
	| MULT											{ cout << "MULTIPLIED BY ..." << endl;}
	| DIV											{ cout << "DIVIDED BY ..." << endl;}
	;

valExpr : valTerm									
		| valExpr ADDOP valTerm						{ cout << "ADD *" << endl;}
		;

valTerm : valTerm MULTOP valFact					{ cout << "MULT *" << endl;}
		| valFact
		;

valFact : val										 
		| LPAREN valExpr RPAREN					
		;

booleanExpr : BOOLEAN
			| ID
			| val COMP val
			;

rw_Clause : READ ID
		| WRITE ID
		;

val : ID
	| DOUBLE
	| INT
	;

%%

int main()
{
	yyparse();// A parsing function that will be generated by Bison.
    return 0;
}
