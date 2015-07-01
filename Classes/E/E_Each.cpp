using namespace std;

class E_Each : public Token {

protected:

	Token* var;
	Token* k;
	Token* v;
	E_Main* body;

public:

	E_Each(Token* var, Token* k, Token* v, E_Main* body) {
		this->var = var;
		this->k = k;
		this->v = v;
		this->body = body;
	}

	virtual ~E_Each() {

	}

	// имя токена
	virtual string getType() {
		return "E_Each";
	}

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
