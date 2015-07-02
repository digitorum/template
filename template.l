%{

#include <iostream>
#include <string>
#include <vector>
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
%s ATTRIBUTES
%s ATTRIBUTE_VALUE
%s SET
%s COMMENT
%s SETTINGS

WS		[ \t]+
WSN		[ \t\r\s\n]+

%%

<INITIAL,TEXT>{

	\{\{					{
								states.push(YY_START);
								BEGIN(COMMENT);
							}
	\<if{WS}+				{
								states.push(YY_START);
								BEGIN(SCRIPT);
								return T_IF_OPEN;
							}
	\<else{WS}*>			{
								return T_IF_ELSE;
							}
	\<\/if{WS}*>			{
								return T_IF_CLOSE;
							}
	\<set{WS}+				{
								states.push(YY_START);
								BEGIN(SET);
								return T_SET_OPEN;
							}
	\<print{WS}+			{
								states.push(YY_START);
								BEGIN(SCRIPT);
								return T_PRINT_OPEN;
							}
	\<include{WS}+			{
								states.push(YY_START);
								BEGIN(ATTRIBUTES);
								return T_INCLUDE_OPEN;
							}
	\<each{WS}+				{
								states.push(YY_START);
								BEGIN(SCRIPT);
								return T_EACH_OPEN;
							}
	\<\/each{WS}*>			{
								return T_EACH_CLOSE;
							}
	\<switch{WS}+			{
								states.push(YY_START);
								BEGIN(SCRIPT);
								return T_SWICTH_OPEN;
							}
	\<\/switch{WS}*>{WSN}*	{
								return T_SWICTH_CLOSE;
							}
	\<case{WS}+				{
								states.push(YY_START);
								BEGIN(SCRIPT);
								return T_CASE_OPEN;
							}
	\<\/case{WS}*>{WSN}*	{
								return T_CASE_CLOSE;
							}
	\<settings{WS}*>{WSN}*	{
								states.push(YY_START);
								BEGIN(SETTINGS);
							}
	\n						{
								yylval.sval = strdup(yytext);
								return T_TEXT;
							}
	.						{
								yylval.sval = strdup(yytext);
								return T_TEXT;
							}
	<<EOF>>					{
								return T_END;
							}
}



<SETTINGS>{

	\<param{WS}+				{
									states.push(YY_START);
									BEGIN(ATTRIBUTES);
									return T_PARAM_OPEN;
								}
	\<\/settings{WS}*>{WSN}*	{
									BEGIN(states.pop());
								}
	.							;
}




<COMMENT>{

	\{\{					{
								states.push(YY_START);
								BEGIN(COMMENT);
							}
	.						;
	\}\}					{
								BEGIN(states.pop());
							}
}




<NUMERIC>{

	([0-9]+[.]?)+			{
								BEGIN(states.pop());
								yylval.sval = strdup(yytext);
								return T_NUMERIC;
							}
}




<INITIAL,TEXT,SCRIPT,PARAMETERS,ATTRIBUTE_VALUE>{

	\<var					{
								states.push(YY_START);
								BEGIN(VAR);
								return T_VAR_OPEN;
							}
	\<const					{
								states.push(YY_START);
								BEGIN(VAR);
								return T_CONST_OPEN;
							}
}




<SCRIPT,PARAMETERS,ATTRIBUTE_VALUE>{

	[0-9]					{
								states.push(YY_START);
								BEGIN(NUMERIC);
								yyless(0);
							}
	\"						{
								states.push(YY_START);
								BEGIN(STRING_DQ);
								buffer = "\"";
							}
	'						{
								states.push(YY_START);
								BEGIN(STRING_SQ);
								buffer = "'";
							}
}




<STRING_DQ>{

	\\\"					{
								buffer += yytext;
							}
	\"						{
								BEGIN(states.pop());
								yylval.sval = strdup((buffer + yytext).c_str());
								return T_STRING;
							}
	.						{
								buffer += yytext;
							}
}




<STRING_SQ>{

	\\'						{
								buffer += yytext;
							}
	'						{
								BEGIN(states.pop());
								yylval.sval = strdup((buffer + yytext).c_str());
								return T_STRING;
							}
	.						{
								buffer += yytext;
							}
}




<VAR,SCRIPT,ATTRIBUTES>{

	>{WSN}*					{
								BEGIN(states.pop());
								return T_TAG_CLOSE;
							}

}




<METHODS,PARAMETERS,ATTRIBUTE_VALUE>{

	>						{
								// возвращаемся в "VAR,ATTRIUTE", при этом пересканируем ">" заново
								BEGIN(states.pop());
								yyless(0);
							}

}




<SCRIPT>{
	
	\(						{
								return T_RBRACKET_OPEN;
							}
	\)						{
								return T_RBRACKET_CLOSE;
							}
	&&						{
								return T_AND;
							}
	\|\|					{
								return T_OR;
							}
	(==|eq)					{
								return T_EQ;
							}
	!=						{
								return T_NOT_EQ;
							}
	gt						{
								return T_GT;
							}
	ge						{
								return T_GE;
							}
	lt						{
								return T_LT;
							}
	le						{
								return T_LE;
							}
	as						{
								return T_AS;
							}
	\+						{
								return T_PLUS;
							}
	\-						{
								return T_MINUS;
							}
	\*						{
								return T_MULTIPLY;
							}
	\/						{
								return T_DIVISION;
							}
	\%						{
								return T_MODULO;
							}
	\^						{
								return T_POW;
							}
}




<SCRIPT,SET>{

	{WSN}+					;

}




<VAR,SET>{
	
	([a-zA-Z_0-9]+(->)*)+	{
								yylval.sval = strdup(yytext);
								return T_VAR_NAME;
							}
}




<SET>{
	=						{
								// SET=SCRIPT, стэк не наполняем, просто изменяем состояние
								BEGIN(SCRIPT);
								return T_ASSIGNMENT;
							}
}




<VAR>{

	\[						{
								return T_SBRACKET_OPEN;
							}
	\]						{
								return T_SBRACKET_CLOSE;
							}
	\.						{
								states.push(YY_START);
								BEGIN(METHODS);
								yyless(0);
							}
}




<METHODS>{

	\.						{
								return T_DOT;
							}
	\(						{
								states.push(YY_START);
								BEGIN(PARAMETERS);
								return T_RBRACKET_OPEN;
							}
	[_a-z0-9]+				{
								yylval.sval = strdup(yytext);
								return T_METHOD_NAME;
							}
}




<PARAMETERS>{

	\)						{
								BEGIN(states.pop());
								return T_RBRACKET_CLOSE;
							}
	,						{
								return T_COMMA;
							}
}



<ATTRIBUTES>{
	[a-z0-9_]+				{
								yylval.sval = strdup(yytext);
								return T_ATTR_NAME;
							}
	=						{
								states.push(YY_START);
								BEGIN(ATTRIBUTE_VALUE);
								return T_ASSIGNMENT;
							}
	{WS}+					;
}



<ATTRIBUTE_VALUE>{
	{WS}+					{
								BEGIN(states.pop());
							}
	[a-z0-9_]				{
								// внезапно нашли символ, значит мы подошли вплотную к следующему аттрибуту, нужно пересканировать
								BEGIN(states.pop());
								yyless(0);
							}		
}
%%
