%{

#include <iostream>
#include <string>
#include <typeinfo>
#include <vector>
#include <map>
#include "Lib/String.cpp"
#include "Lib/Vector.cpp"
#include "Classes/Token.cpp"
#include "Classes/E/E_Main.cpp"
#include "Classes/E/E_Expr.cpp"
#include "Classes/E/E_Methods.cpp"
#include "Classes/E/E_If.cpp"
#include "Classes/E/E_Set.cpp"
#include "Classes/E/E_Print.cpp"
#include "Classes/E/E_Attributes.cpp"
#include "Classes/E/E_Include.cpp"
#include "Classes/E/E_Each.cpp"
#include "Classes/E/E_Switch.cpp"
#include "Classes/T/T_Text.cpp"
#include "Classes/T/T_Numeric.cpp"
#include "Classes/T/T_Var.cpp"
#include "Classes/T/T_Const.cpp"

extern "C" int yylex();
extern "C" int yyparse();
void  yyerror(const char * str);

using namespace std;

// списки для отслеживания состояний
vector<E_Main*> mains;
vector<E_Methods*> methods;
vector<E_Parameters*> parameters;
vector<E_Attributes*> attibutes;
vector<E_Cases*> cases;
vector<string> paramaters;
// указатель на Lua
Lua* Token::LuaInstance = new Lua();
// Путь до приложения
string Token::AppPath = "";

%}

%union {
	char *sval;
	Token *tpointer;
	E_Methods *mpointer;
}

%token <sval> T_TEXT T_NUMERIC T_VAR_NAME T_METHOD_NAME T_STRING T_ATTR_NAME
%token T_VAR_OPEN T_CONST_OPEN
%token T_IF_OPEN T_IF_ELSE T_IF_CLOSE
%token T_EACH_OPEN T_EACH_CLOSE
%token T_SET_OPEN
%token T_PRINT_OPEN
%token T_INCLUDE_OPEN
%token T_SWICTH_OPEN T_SWICTH_CLOSE
%token T_CASE_OPEN T_CASE_CLOSE
%token T_PARAM_OPEN
%token T_TAG_CLOSE
%token T_SBRACKET_OPEN T_SBRACKET_CLOSE T_RBRACKET_OPEN T_RBRACKET_CLOSE
%token T_AND T_OR T_AS
%token T_EQ T_NOT_EQ T_GT T_GE T_LT T_LE T_ASSIGNMENT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVISION T_MODULO T_POW
%token T_DOT T_COMMA
%token T_END

%left T_EQ T_NOT_EQ T_GT T_GE T_LT T_LE T_AND T_OR T_ASSIGNMENT T_PLUS T_MINUS T_MULTIPLY T_DIVISION T_MODULO T_POW

%type <tpointer> E_EXPR E_IF E_SCRIPT E_ENTITY E_CASES
%type <mpointer> E_METHODS

%%

E_MAIN:
	E_MAIN E_SCRIPT																		{
																							mains.back()->push($2);
																						}
	| E_MAIN T_END																		{
																							cout << mains.back()->dump(
																								map<string,string>() = {
																									{"isFinal", "true"},
																									{"parameters", paramaters.size() == 0 ? "$input" : vector_join(paramaters, ",")}
																								}
																							);
																							delete mains.back();
																							mains.pop_back();
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
	| T_INCLUDE_OPEN E_ATTRIBUTES T_TAG_CLOSE											{
																							$$ = new E_Include(attibutes.back());
																							attibutes.pop_back();
																						}
	| T_EACH_OPEN E_ENTITY T_AS E_ENTITY E_ENTITY T_TAG_CLOSE E_MAIN T_EACH_CLOSE		{
																							$$ = new E_Each($2, $4, $5, mains.back());
																							mains.pop_back();
																						}
	| T_SWICTH_OPEN E_ENTITY T_TAG_CLOSE E_CASES T_SWICTH_CLOSE							{
																							$$ = new E_Switch($2, cases.back());
																							cases.pop_back();
																						}
	| T_PARAM_OPEN E_ATTRIBUTES T_TAG_CLOSE												{
																							$$ = new T_Text("");
																							paramaters.push_back(attibutes.back()->get("name"));
																							delete attibutes.back();
																							attibutes.pop_back();
																						}



E_CASES:
	E_CASES T_CASE_OPEN E_EXPR T_TAG_CLOSE E_MAIN T_CASE_CLOSE							{
																							cases.back()->push(new E_Case($3, mains.back()));
																							mains.pop_back();
																						}
	| /* empty */																		{
																							cases.push_back(new E_Cases());
																						}




E_ATTRIBUTES:
	E_ATTRIBUTES T_ATTR_NAME T_ASSIGNMENT E_EXPR										{
																							attibutes.back()->push($2, $4);
																						}
	| /* empty */																		{
																							attibutes.push_back(new E_Attributes());
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
	Token::AppPath = argv[0];
	Token::LuaInstance->loadLanguageFile(argv[1]);
	yyparse();
}

void yyerror(const char *str) {
	fprintf(stderr, "ошибка %s\n", str);
}