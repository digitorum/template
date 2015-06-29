using namespace std;

class T_if : public Token {

protected:

	Token* expr;
	E_Main* statement;

public:

	// конструктор, на вход вырвжение и инструкции
	T_if(Token* expr, E_Main* statement) {
		this->expr = expr;
		this->statement = statement;
	}

	// деструтокр
	virtual ~T_if() {
		delete this->expr;
		delete this->statement;
	}

	// текстовое представление ноды
	virtual string Dump() {
		return " if ( " + this->expr->Dump() + " ) { " + this->statement->Dump() + " } ";
	}
};
