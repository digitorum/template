using namespace std;

// Expression
class E_Expr : public Token {

	// Список токенов
	vector<Token*> tokens;

public:

	// Конструктор. "(token)"
	E_Expr(Token* obracket, Token* token, Token* cbracket) {
		this->tokens.push_back(obracket);
		this->tokens.push_back(token);
		this->tokens.push_back(cbracket);
	}

	// Деструктор
	virtual ~E_Expr() {
		for(int i=0; i<this->tokens.size(); ++i) {
			delete this->tokens.at(i);
		}
		this->tokens.clear();
	}

	// Имя токена
	virtual string getType() {
		return "E_Expr";
	}

	// Текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		vector<string> dumps;

		// объединяем текстовые ноды
		for(int i=0; i<this->tokens.size(); ++i) {
			dumps.push_back(this->tokens.at(i)->dump());
		}
		return Token::LuaInstance->execute("E_Expr", dumps);
	}
};
