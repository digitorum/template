using namespace std;

class T_Text : public Token {

protected:

	// текст ноды
	string text = "";

public:

	// конструктор, на вход принимаем строку
	T_Text(string str) {
		this->text = str;
	}

	// деструктор
	virtual ~T_Text() {

	}

	// имя токена
	virtual string getType() {
		return "T_Text";
	}

	// вернуть текстовое значение
	virtual string dump(map<string,string> options = map<string,string>()) {
		return this->text;
	}

	// получить raw представление токена
	virtual string getRaw() {
		return this->text;
	}

	// дописать текстовый токен
	virtual void mergeWith(Token* token) {
		if(token->getType() == "T_Text") {
			this->text += token->getRaw();
		}
	}

};
