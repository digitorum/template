using namespace std;

class E_If : public Token {

protected:

	Token* expr;
	vector<E_Main*> statements;

public:

	// конструктор, на вход вырвжение и инструкции
	E_If(Token* expr, E_Main* statement) {
		this->expr = expr;
		this->statements.push_back(statement);
	}

	// Конструктор if-else
	E_If(Token* expr, E_Main* statement, E_Main* elsestatement) {
		this->expr = expr;
		this->statements.push_back(statement);
		this->statements.push_back(elsestatement);
	}

	// деструтокр
	virtual ~E_If() {
		delete this->expr;
		this->statements.clear();
	}

	// имя токена
	virtual string getType() {
		return "E_If";
	}

	// текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		return Token::LuaInstance->execute(
			"E_If",
			map<string, string>() = {
				{ "expr", this->expr->dump() },
				{ "statement", this->statements.at(0)->dump() },
				{ "elsestatement", this->statements.size() > 1 ? this->statements.at(1)->dump() : "" }
			}
		);
	}
};
