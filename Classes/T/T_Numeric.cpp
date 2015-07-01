using namespace std;

class T_Numeric : public Token {

	string number;

public:

	// конструктор, на вход строка
	T_Numeric(string str) {
		this->number = str;
	}

	// виртуальный деструктор
	virtual ~T_Numeric() {

	}

	// имя токена
	virtual string getType() {
		return "T_Numeric";
	}

	// текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		return this->number;
	}

};
