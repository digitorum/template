#include "Lua.cpp"

using namespace std;

class Token {

public:

	// указатель на lua
	static Lua* LuaInstance;

	// путь до приложения
	static string AppPath;

	// конструктор
	Token() {
	}

	// виртуальный деструктор
	virtual ~Token() {
	}

	// имя токена
	virtual string getType() = 0;

	// получить raw представление токена
	virtual void mergeWith(Token* token) {
		throw "Токен не может быть объединен с Token*.";
	}

	// получить raw представление токена
	virtual string getRaw() {
		throw "Токен не может быть представлен в сыром виде.";
	}

	// текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) = 0;

};
