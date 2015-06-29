%{

#include <iostream>
#include <string>
#include <vector>
#include <list>
#include <vector>
#include <map>
#include "Classes/Token.cpp"
#include "Classes/E/E_Main.cpp"
#include "Classes/E/E_Expr.cpp"
#include "Classes/E/E_Methods.cpp"
#include "Classes/S/S_List.cpp"
#include "template.tab.h"

S_List states;
std::string buffer;

extern "C" int yylex();
	
%}

%s TEXT
%s NUMERIC
%s VAR
%s METHODS
%s PARAMETERS
%s STRING_SQ
%s STRING_DQ
%s SCRIPT

WS		[ \t]+
WSN		[ \t\r\s]+

%%

<INITIAL,TEXT>{

	\<if{WS}+			{
							states.push(YY_START);
							BEGIN(SCRIPT);
							return T_IF_OPEN;
						}
	\<\/if{WS}*>		{
							return T_IF_CLOSE;
						}
	\n					{
							yylval.sval = strdup(yytext);
							return T_TEXT;
						}
	.					{
							yylval.sval = strdup(yytext);
							return T_TEXT;
						}
	<<EOF>>				{
							return T_END;
						}
}




<NUMERIC>{

	([0-9]+[.]?)+		{
							BEGIN(states.pop());
							yylval.sval = strdup(yytext);
							return T_NUMERIC;
						}
}




<INITIAL,TEXT,SCRIPT,PARAMETERS>{

	\<var				{
							states.push(YY_START);
							BEGIN(VAR);
							return T_VAR_OPEN;
						}
}




<SCRIPT,PARAMETERS>{
	[0-9]				{
							states.push(YY_START);
							BEGIN(NUMERIC);
							yyless(0);
						}
	\"					{
							states.push(YY_START);
							BEGIN(STRING_DQ);
							buffer = "\"";
						}
	'					{
							states.push(YY_START);
							BEGIN(STRING_SQ);
							buffer = "'";
						}
}




<STRING_DQ>{
	\\\"				{
							buffer += yytext;
						}
	\"					{
							BEGIN(states.pop());
							yylval.sval = strdup((buffer + yytext).c_str());
							return T_STRING;
						}
	.					{
							buffer += yytext;
						}
}




<STRING_SQ>{
	\\'					{
							buffer += yytext;
						}
	'					{
							BEGIN(states.pop());
							yylval.sval = strdup((buffer + yytext).c_str());
							return T_STRING;
						}
	.					{
							buffer += yytext;
						}
}




<VAR,SCRIPT>{

	>{WSN}*				{
							BEGIN(states.pop());
							return T_TAG_CLOSE;
						}

}




<METHODS,PARAMETERS>{

	>					{
							// возвращаемся в "VAR", при этом пересканируем ">" заново
							BEGIN(states.pop());
							yyless(0);
						}

}




<SCRIPT>{
	
	\(					{
							return T_RBRACKET_OPEN;
						}
	\)					{
							return T_RBRACKET_CLOSE;
						}
	&&					{
							return T_AND;
						}
	\|\|				{
							return T_OR;
						}
	(==|eq)				{
							return T_EQ;
						}
	!=					{
							return T_NOT_EQ;
						}
	gt					{
							return T_GT;
						}
	ge					{
							return T_GE;
						}
	lt					{
							return T_LT;
						}
	le					{
							return T_LE;
						}
	{WSN}*				;
}




<VAR>{

	\[					{
							return T_SBRACKET_OPEN;
						}
	\]					{
							return T_SBRACKET_CLOSE;
						}
	\.					{
							states.push(YY_START);
							BEGIN(METHODS);
							yyless(0);
						}
	([a-zA-Z_]+(->)*)+	{
							yylval.sval = strdup(yytext);
							return T_VAR_NAME;
						}
}




<METHODS>{

	\.					{
							return T_DOT;
						}
	\(					{
							states.push(YY_START);
							BEGIN(PARAMETERS);
							return T_RBRACKET_OPEN;
						}
	[_a-z0-9]+			{
							yylval.sval = strdup(yytext);
							return T_METHOD_NAME;
						}
}




<PARAMETERS>{

	\)					{
							BEGIN(states.pop());
							return T_RBRACKET_CLOSE;
						}
	,					{
							return T_COMMA;
						}
}
%%
