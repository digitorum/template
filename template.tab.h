/* A Bison parser, made by GNU Bison 2.5.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2011 Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     T_TEXT = 258,
     T_NUMERIC = 259,
     T_VAR_NAME = 260,
     T_METHOD_NAME = 261,
     T_STRING = 262,
     T_VAR_OPEN = 263,
     T_CONST_OPEN = 264,
     T_IF_OPEN = 265,
     T_IF_ELSE = 266,
     T_IF_CLOSE = 267,
     T_SET_OPEN = 268,
     T_TAG_CLOSE = 269,
     T_SBRACKET_OPEN = 270,
     T_SBRACKET_CLOSE = 271,
     T_RBRACKET_OPEN = 272,
     T_RBRACKET_CLOSE = 273,
     T_AND = 274,
     T_OR = 275,
     T_EQ = 276,
     T_NOT_EQ = 277,
     T_GT = 278,
     T_GE = 279,
     T_LT = 280,
     T_LE = 281,
     T_ASSIGNMENT = 282,
     T_PLUS = 283,
     T_MINUS = 284,
     T_MULTIPLY = 285,
     T_DIVISION = 286,
     T_MODULO = 287,
     T_POW = 288,
     T_DOT = 289,
     T_COMMA = 290,
     T_END = 291
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 2068 of yacc.c  */
#line 34 "template.y"

	char *sval;
	Token *tpointer;
	E_Methods *mpointer;



/* Line 2068 of yacc.c  */
#line 94 "template.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


