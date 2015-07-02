using namespace std;

// Оператор if[-else]
class E_If : public Token {

protected:

	// Expression
	Token* expr;

	// Statements
	vector<E_Main*> statements;

public:

	// Конструктор. if(expression) { statement }
	E_If(Token* expr, E_Main* statement) {
		this->expr = expr;
		this->statements.push_back(statement);
	}

	// Конструктор. if(expression) { statement } else { elsestatement }
	E_If(Token* expr, E_Main* statement, E_Main* elsestatement) {
		this->expr = expr;
		this->statements.push_back(statement);
		this->statements.push_back(elsestatement);
	}

	// Деструтокр
	virtual ~E_If() {
		for(int i=0; i<this->statements.size(); ++i) {
			delete this->statements.at(i);
		}
		this->statements.clear();
		delete this->expr;
	}

	// Имя токена
	virtual string getType() {
		return "E_If";
	}

	// Текстовое представление ноды
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
