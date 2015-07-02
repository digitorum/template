using namespace std;

// Текстовый токен
class T_Text : public Token {

protected:

	// Текст ноды
	string text = "";

public:

	// Конструктор
	T_Text(string str) {
		this->text = str;
	}

	// Деструктор
	virtual ~T_Text() {

	}

	// Имя токена
	virtual string getType() {
		return "T_Text";
	}

	// Получить raw представление токена
	virtual string getRaw() {
		return this->text;
	}

	// Дописать текстовый токен
	virtual void mergeWith(Token* token) {
		if(token->getType() == "T_Text") {
			this->text += token->getRaw();
		}
	}

	// Текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		return Token::LuaInstance->execute("T_Text", this->text);
	}
};
