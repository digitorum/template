class E_Set : public Token {

	// список токенов
	vector<Token*> tokens;

public:

	// конструктор "(token)"
	E_Set(Token* var, Token* expr) {
		this->tokens.push_back(var);
		this->tokens.push_back(expr);
	}

	// деструктор
	virtual ~E_Set() {
		this->tokens.clear();
	}

	// имя токена
	virtual string getType() {
		return "E_Set";
	}

	// текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		return Token::LuaInstance->execute(
			"E_Set",
			map<string,string>() = {
				{"name", this->tokens.at(0)->dump()},
				{"value", this->tokens.at(1)->dump()}
			}
		);
	}
};
