using namespace std;

class T_Varname : public Token {

protected:

	// имя переменной
	string varname;

public:

	// конструктор, на вход приминмаем имя переменной
	T_Varname(string str) {
		varname = str;
	}

	// виртуальный деструктор
	virtual ~T_Varname() {

	}

	// текстовое представление ноды
	virtual string Dump() {
		return "$" + varname;
	}

};
