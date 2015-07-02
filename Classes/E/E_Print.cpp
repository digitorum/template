using namespace std;

// Оператор print
class E_Print : public Token {

	// Expression
	Token*  expr;

public:

	// Конструктор. Expression
	E_Print(Token* expr) {
		this->expr = expr;
	}

	// Деструктор
	virtual ~E_Print() {
		delete this->expr;
	}

	// Имя токена
	virtual string getType() {
		return "E_Print";
	}

	// Т>екстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		return Token::LuaInstance->execute("E_Print", this->expr->dump());
	}
};
