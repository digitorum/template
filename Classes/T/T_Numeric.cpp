using namespace std;

// Числовой токен
class T_Numeric : public Token {

	// Число
	string number;

public:

	// Конструктор
	T_Numeric(string str) {
		this->number = str;
	}

	// Деструктор
	virtual ~T_Numeric() {

	}

	// Имя токена
	virtual string getType() {
		return "T_Numeric";
	}

	// Текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		return Token::LuaInstance->execute("T_Numeric", this->number);
	}

};
