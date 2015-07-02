using namespace std;

// Оператор each
class E_Each : public Token {

protected:

	// Expression
	Token* var;

	// Key
	Token* k;

	// Value
	Token* v;

	// Statement
	E_Main* body;

public:

	// Конструктор. foreach(expression as key => value ) { statement }
	E_Each(Token* var, Token* k, Token* v, E_Main* body) {
		this->var = var;
		this->k = k;
		this->v = v;
		this->body = body;
	}

	// Деструктор
	virtual ~E_Each() {
		delete this->var;
		delete this->k;
		delete this->v;
		delete this->body;
	}

	// Имя токена
	virtual string getType() {
		return "E_Each";
	}

	// Текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		map<string,string> table = map<string,string> {
			{"var", this->var->dump()},
			{"k", this->k->dump()},
			{"v", this->v->dump()},
			{"body", this->body->dump()}
		};
		return Token::LuaInstance->execute("E_Each", table);
	}
};
