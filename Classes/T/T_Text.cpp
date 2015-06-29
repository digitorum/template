using namespace std;

class T_Text : public Token {

protected:

	// текст ноды
	string text = "";

public:

	// конструктор, на вход принимаем строку
	T_Text(string str) {
		text = str;
	}

	// деструктор
	virtual ~T_Text() {

	}

	// вернуть текстовое значение
	virtual string Dump() {
		return text;
	}
};
