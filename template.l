%{

#include <iostream>
#include <string>
#include <vector>
#include <list>
#include <vector>
#include "Classes/Token.cpp"
#include "Classes/E/E_Main.cpp"
#include "Classes/E/E_Expr.cpp"
#include "Classes/S/S_List.cpp"
#include "template.tab.h"

S_List states;

extern "C" int yylex();
	
%}

%s TEXT
%s NUMERIC
%s VAR
%s METHODS
%s PARAMETERS
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

	[0-9,. ]+			{
							BEGIN(states.pop());
							yylval.sval = strdup(yytext);
							return T_NUMERIC;
						}
}




<INITIAL,TEXT,SCRIPT>{

	\<var				{
							states.push(YY_START);
							BEGIN(VAR);
							return T_VAR_OPEN;
						}
	[0-9]				{
							states.push(YY_START);
							BEGIN(NUMERIC);
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
	>{WSN}*				{
							BEGIN(states.pop());
							return T_TAG_CLOSE;
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
	([a-zA-Z_]+(->)*)+	{
							yylval.sval = strdup(yytext);
							return T_VAR_NAME;
						}
	>					{
							BEGIN(states.pop());
							return T_TAG_CLOSE;
						}
}


%%
