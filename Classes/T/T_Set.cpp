class T_Set : public Token {

	// список токенов
	vector<Token*> tokens;

public:

	// конструктор "(token)"
	T_Set(Token* var, Token* expr) {
		this->tokens.push_back(var);
		this->tokens.push_back(expr);
	}

	// деструктор
	virtual ~T_Set() {
		this->tokens.clear();
	}

	// текстовое представление ноды
	string Dump() {
		return this->tokens.at(0)->Dump() + " = " + this->tokens.at(1)->Dump();
	}
};
