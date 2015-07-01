using namespace std;


class E_Expr : public Token {

	// список токенов
	vector<Token*> tokens;

public:

	// конструктор "(token)"
	E_Expr(Token* obracket, Token* token, Token* cbracket) {
		this->tokens.push_back(obracket);
		this->tokens.push_back(token);
		this->tokens.push_back(cbracket);
	}

	// деструктор
	virtual ~E_Expr() {
		this->tokens.clear();
	}

	// имя токена
	virtual string getType() {
		return "E_Expr";
	}

	// текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		vector<string> dumps;

		// объединяем текстовые ноды
		for(int i=0; i<this->tokens.size(); ++i) {
			dumps.push_back(this->tokens.at(i)->dump());
		}
		return Token::LuaInstance->execute("E_Expr", dumps);
	}
};
