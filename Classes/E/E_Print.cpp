class E_Print : public Token {

	Token*  expr;

public:

	// конструктор
	E_Print(Token* expr) {
		this->expr = expr;
	}

	// деструктор
	virtual ~E_Print() {
		delete this->expr;
	}

	// имя токена
	virtual string getType() {
		return "E_Print";
	}

	// текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		return Token::LuaInstance->execute("E_Print", this->expr->dump());
	}
};
