#include "Lua.cpp"

using namespace std;

class Token {

public:

	static Lua* LuaInstance;

	// текстовое представление ноды
	virtual string Dump() = 0;

	// конструктор
	Token() {
	}

	// виртуальный деструктор
	virtual ~Token() {
	}
};
