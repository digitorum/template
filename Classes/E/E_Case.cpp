using namespace std;

class E_Case : public Token {

	Token* expr;
	E_Main* body;

public:

	E_Case(Token* expr, E_Main* body) {
		this->expr = expr;
		this->body = body;
	}

	virtual ~E_Case() {

	}

	// имя токена
	virtual string getType() {
		return "E_Case";
	}

	virtual string dump(map<string,string> options = map<string,string>()) {
		map<string,string> data = map<string,string> {
			{"expr", this->expr->dump()},
			{"body", this->body->dump()}
		};
		return Token::LuaInstance->execute("E_Case", data);
	}
};
