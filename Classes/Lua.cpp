extern "C" {
	#include <lua5.2/lua.h>
	#include <lua5.2/lualib.h>
	#include <lua5.2/lauxlib.h>
}
#include <stdlib.h>

using namespace std;

// Интерфейс работы с Lua
class Lua {

protected:

	// указатель на lua_State
	lua_State* L;

	// текщий язык
	string language;

	// Вызов фуцнкции из lua-файла
	string luaCall() {
		if (lua_pcall(L, 2, 1, 0)) {
			this->error(L);
		}
		string result = lua_tostring(L, -1);
		lua_pop(L,1);
		return result;
	}

public:

	// Конструктор
	Lua() {
		this->L = luaL_newstate();
		this->language = "";
		luaL_openlibs(this->L);
	}

	// Деструктор
	~Lua(){
		lua_close(this->L);
	}

	// получить текущий язык
	string getLaguage() {
		return this->language;
	}

	// загрузить необходимый файл
	void loadLanguageFile(string languague) {
		string filename = "Lua/" + languague + ".lua";

		this->language = languague;
		if (luaL_loadfile(this->L, filename.c_str())) {
			this->error(L);
		}
		if (lua_pcall(this->L, 0, 0, 0)) {
			this->error(this->L);
		}
	}

	// Cообщение об ощибке
	void error(lua_State *L){
		fprintf(stderr, "\nFATAL ERROR:\n  %s: %s\n\n", lua_tostring(L, -1));
		exit(1);
	}

	// Добавить таблиц в стэк из map
	// TODO: refactor. template?
	void pushTable(map<string,string> table) {
		lua_newtable(this->L);
		for(map<string,string>::const_iterator i = table.begin(); i !=table.end(); ++i) {
			lua_pushstring(this->L, i->first.c_str());
			lua_pushstring(this->L, i->second.c_str());
			lua_settable(this->L, -3);
		}
	}

	// Добавить таблиц в стэк из vecor
	// TODO: refactor. template?
	void pushTable(vector<string> v) {
		lua_newtable(this->L);
		for(int i=0; i<v.size(); ++i) {
			lua_pushinteger(this->L, i+1);
			lua_pushstring(this->L, v.at(i).c_str());
			lua_settable(this->L, -3);
		}
	}

	// Вызов функции из LUA файла
	// TODO: refactor. template?
	string execute(string fname, map<string,string> table, map<string,string> options = map<string,string>()) {
		lua_getglobal(this->L, fname.c_str());
		this->pushTable(table);
		this->pushTable(options);
		return this->luaCall();
	}


	// Вызов функции из LUA файла
	// TODO: refactor. template?
	string execute(string fname, vector<string> v, map<string,string> options = map<string,string>()) {
		lua_getglobal(this->L, fname.c_str());
		this->pushTable(v);
		this->pushTable(options);
		return this->luaCall();
	}


	// Вызов функции из LUA файла
	// TODO: refactor. template?
	string execute(string fname, string s, map<string,string> options = map<string,string>()) {
		lua_getglobal(this->L, fname.c_str());
		lua_pushstring(L, s.c_str());
		this->pushTable(options);
		return this->luaCall();
	}

};
