using namespace std;

class T_If : public Token {

protected:

	Token* expr;
	vector<E_Main*> statements;

public:

	// конструктор, на вход вырвжение и инструкции
	T_If(Token* expr, E_Main* statement) {
		this->expr = expr;
		this->statements.push_back(statement);
	}

	// Конструктор if-else
	T_If(Token* expr, E_Main* statement, E_Main* elsestatement) {
		this->expr = expr;
		this->statements.push_back(statement);
		this->statements.push_back(elsestatement);
	}

	// деструтокр
	virtual ~T_If() {
		delete this->expr;
		this->statements.clear();
	}

	// текстовое представление ноды
	virtual string Dump() {
		return Token::LuaInstance->execute(
			"getIf",
			map<string, string>() = {
				{ "expr", this->expr->Dump() },
				{ "statement", this->statements.at(0)->Dump() },
				{ "elsestatement", this->statements.size() > 1 ? this->statements.at(1)->Dump() : "" }
			}
		);
	}
};
