using namespace std;

// Оператор case
class E_Case : public Token {

	// Expression
	Token* expr;

	// Statement
	E_Main* body;

public:

	// Конструктор. Определяем expression и statement
	E_Case(Token* expr, E_Main* body) {
		this->expr = expr;
		this->body = body;
	}

	// Деструктор
	virtual ~E_Case() {
		delete this->expr;
		delete this->body;
	}

	// Имя токена
	virtual string getType() {
		return "E_Case";
	}

	// Текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		map<string,string> data = map<string,string> {
			{"expr", this->expr->dump()},
			{"body", this->body->dump()}
		};
		return Token::LuaInstance->execute("E_Case", data);
	}
};
