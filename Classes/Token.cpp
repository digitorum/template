#include "Lua.cpp"

using namespace std;

// "Базовыый" токен
class Token {

public:

	// Указатель на lua
	static Lua* LuaInstance;

	// Путь до приложения
	static string AppPath;

	// Конструктор
	Token() { }

	// Виртуальный деструктор
	virtual ~Token() { }

	// Имя токена
	virtual string getType() = 0;

	// Объединить текущий токен с token
	virtual void mergeWith(Token* token) {
		throw "Токен не может быть объединен с Token*.";
	}

	// Получить raw представление токена
	virtual string getRaw() {
		throw "Токен не может быть представлен в сыром виде.";
	}

	// Текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) = 0;

};
