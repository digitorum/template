extern "C" {
	#include <lua5.2/lua.h>
	#include <lua5.2/lualib.h>
	#include <lua5.2/lauxlib.h>
}
#include <stdlib.h>

using namespace std;

class Lua {

protected:

	lua_State* L;

public:

	// конструктор
	Lua() {
		this->L = luaL_newstate();
		luaL_openlibs(this->L);
		if (luaL_loadfile(this->L, "Lua/javascript.lua")) {
			this->error(L);
		}
		if (lua_pcall(this->L, 0, 0, 0)) {
			this->error(this->L);
		}
	}

	// деструктор
	~Lua(){
		lua_close(this->L);
	}

	// сообщение об ощибке
	void error(lua_State *L){
		fprintf(stderr, "\nFATAL ERROR:\n  %s: %s\n\n", lua_tostring(L, -1));
		exit(1);
	}

	// вызов функции из LUA файла
	string execute(string fname, map<string,string> m) {
		string result;

		lua_getglobal(this->L, fname.c_str());
		lua_newtable(this->L);
		for(map<string,string>::const_iterator i = m.begin(); i !=m.end(); ++i) {
			lua_pushstring(this->L, i->first.c_str());
			lua_pushstring(this->L, i->second.c_str());
			lua_settable(this->L, -3);
		}
		if (lua_pcall(L, 1, 1, 0)) {
			this->error(L);
		}
		result = lua_tostring(L, -1);
		lua_pop(L,1);
		return result;
	}


	// вызов функции из LUA файла
	string execute(string fname, vector<string> v) {
		string result;

		lua_getglobal(this->L, fname.c_str());
		lua_newtable(this->L);
		for(int i=0; i<v.size(); ++i) {
			lua_pushinteger(this->L, i+1);
			lua_pushstring(this->L, v.at(i).c_str());
			lua_settable(this->L, -3);
		}
		if (lua_pcall(L, 1, 1, 0)) {
			this->error(L);
		}
		result = lua_tostring(L, -1);
		lua_pop(L,1);
		return result;
	}


	// вызов функции из LUA файла
	string execute(string fname, string s) {
		string result;

		lua_getglobal(this->L, fname.c_str());
		lua_pushstring(L, s.c_str());
		if (lua_pcall(L, 1, 1, 0)) {
			this->error(L);
		}
		result = lua_tostring(L, -1);
		lua_pop(L,1);
		return result;
	}

};
