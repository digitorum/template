%{

#include <iostream>
#include <string>
#include <typeinfo>
#include <vector>
#include <map>
#include "Classes/Token.cpp"
#include "Classes/E/E_Main.cpp"
#include "Classes/E/E_Expr.cpp"
#include "Classes/E/E_Methods.cpp"
#include "Classes/E/E_If.cpp"
#include "Classes/E/E_Set.cpp"
#include "Classes/E/E_Print.cpp"
#include "Classes/T/T_Text.cpp"
#include "Classes/T/T_Numeric.cpp"
#include "Classes/T/T_Var.cpp"
#include "Classes/T/T_Const.cpp"

extern "C" int yylex();
extern "C" int yyparse();

void  yyerror(const char * str);

// списки для отслеживания состояний
std::vector<E_Main*> mains;
std::vector<E_Methods*> methods;
std::vector<E_Parameters*> parameters;

// указатель на Lua
Lua* Token::LuaInstance = new Lua();

%}

%union {
	char *sval;
	Token *tpointer;
	E_Methods *mpointer;
}

%token <sval> T_TEXT T_NUMERIC T_VAR_NAME T_METHOD_NAME T_STRING
%token T_VAR_OPEN T_CONST_OPEN
%token T_IF_OPEN T_IF_ELSE T_IF_CLOSE
%token T_SET_OPEN
%token T_PRINT_OPEN
%token T_TAG_CLOSE
%token T_SBRACKET_OPEN T_SBRACKET_CLOSE T_RBRACKET_OPEN T_RBRACKET_CLOSE
%token T_AND T_OR
%token T_EQ T_NOT_EQ T_GT T_GE T_LT T_LE T_ASSIGNMENT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVISION T_MODULO T_POW
%token T_DOT T_COMMA
%token T_END

%left T_EQ T_NOT_EQ T_GT T_GE T_LT T_LE T_AND T_OR T_ASSIGNMENT T_PLUS T_MINUS T_MULTIPLY T_DIVISION T_MODULO T_POW

%type <tpointer> E_EXPR E_IF E_SCRIPT E_ENTITY
%type <mpointer> E_METHODS

%%

E_MAIN:
	E_MAIN E_SCRIPT																		{
																							mains.back()->push($2);
																						}
	| E_MAIN T_END																		{
																							std::cout << mains.back()->dump(map<string,string>() = { {"isFinal", "true"} }) << std::endl;
																							return 0;
																						}
	| /* empty */																		{
																							mains.push_back(new E_Main());
																						}




E_SCRIPT:
	E_IF																				{
																							$$ = $1;
									 													}
	| E_EXPR																			{
																							$$ = new E_Print($1);
																						}
	| T_SET_OPEN T_VAR_NAME T_ASSIGNMENT E_EXPR T_TAG_CLOSE								{
																							$$ = new E_Set(new T_Var($2, new E_Methods()), $4);
																						}
	| T_PRINT_OPEN E_EXPR T_TAG_CLOSE													{
																							$$ = new E_Print($2);
																						}
	| T_TEXT																			{
																							$$ = new T_Text($1);
																						}




E_IF:
	T_IF_OPEN E_EXPR T_TAG_CLOSE E_MAIN T_IF_CLOSE										{
																							$$ = new E_If($2, mains.back());
																							mains.pop_back();
																						}
	| T_IF_OPEN E_EXPR T_TAG_CLOSE E_MAIN T_IF_ELSE E_MAIN T_IF_CLOSE					{
																							$$ = new E_If($2, mains.at(mains.size()-2), mains.at(mains.size()-1));
																							mains.pop_back();
																							mains.pop_back();
																						}




E_EXPR:
	T_RBRACKET_OPEN E_EXPR T_RBRACKET_CLOSE												{
																							$$ = new E_Expr(new T_Text("("), $2, new T_Text(")"));
																						}
	| E_EXPR T_AND E_EXPR																{
																							$$ = new E_Expr($1, new T_Text("&&"), $3);
																						}
	| E_EXPR T_OR E_EXPR																{
																							$$ = new E_Expr($1, new T_Text("||"), $3);
																						}
	| E_EXPR T_EQ E_EXPR																{
																							$$ = new E_Expr($1, new T_Text("=="), $3);
																						}
	| E_EXPR T_NOT_EQ E_EXPR															{
																							$$ = new E_Expr($1, new T_Text("!="), $3);
																						}
	| E_EXPR T_GE E_EXPR																{
																							$$ = new E_Expr($1, new T_Text(">="), $3);
																						}
	| E_EXPR T_GT E_EXPR																{
																							$$ = new E_Expr($1, new T_Text(">"), $3);
																						}
	| E_EXPR T_LE E_EXPR																{
																							$$ = new E_Expr($1, new T_Text("<="), $3);
																						}
	| E_EXPR T_LT E_EXPR																{
																							$$ = new E_Expr($1, new T_Text("<"), $3);
																						}
	| E_EXPR T_PLUS E_EXPR																{
																							$$ = new E_Expr($1, new T_Text("+"), $3);
																						}
	| E_EXPR T_MINUS E_EXPR																{
																							$$ = new E_Expr($1, new T_Text("-"), $3);
																						}
	| E_EXPR T_MULTIPLY E_EXPR															{
																							$$ = new E_Expr($1, new T_Text("*"), $3);
																						}
	| E_EXPR T_DIVISION E_EXPR															{
																							$$ = new E_Expr($1, new T_Text("/"), $3);
																						}
	| E_EXPR T_MODULO E_EXPR															{
																							$$ = new E_Expr($1, new T_Text("%"), $3);
																						}
	| E_EXPR T_POW E_EXPR																{
																							$$ = new E_Expr($1, new T_Text("^"), $3);
																						}
	| E_ENTITY 																			{
																							$$ = $1;
																						}


E_ENTITY:
	T_VAR_OPEN T_SBRACKET_OPEN T_VAR_NAME T_SBRACKET_CLOSE E_METHODS T_TAG_CLOSE		{
																							$$ = new T_Var($3, methods.back());
																							methods.pop_back();
																						}
	| T_CONST_OPEN T_SBRACKET_OPEN T_VAR_NAME T_SBRACKET_CLOSE E_METHODS T_TAG_CLOSE	{
																							$$ = new T_Const($3, methods.back());
																							methods.pop_back();
																						}
	| T_NUMERIC																			{
																							$$ = new T_Numeric($1);
																						}
	| T_STRING																			{
																							$$ = new T_Text($1);
																						}


E_METHODS:
	E_METHODS T_DOT T_METHOD_NAME														{
																							methods.back()->push($3, new E_Parameters());
																						}
	| E_METHODS T_DOT T_METHOD_NAME T_RBRACKET_OPEN E_PARAMETERS T_RBRACKET_CLOSE		{
																							methods.back()->push($3, parameters.back());
																							parameters.pop_back();
																						}
	| /* empty */																		{
																							methods.push_back(new E_Methods());
																						}



E_PARAMETERS:
	E_PARAMETERS T_COMMA E_ENTITY														{
																							parameters.back()->push($3);
																						}
	| E_PARAMETERS E_ENTITY																{ 
																							parameters.back()->push($2);
																						}
	| /* empty */																		{
																							parameters.push_back(new E_Parameters());
																						}

%%

int main(int argc, char* argv[])
{
	yyparse();
}

void yyerror(const char *str) {
	fprintf(stderr, "ошибка %s\n", str);
}