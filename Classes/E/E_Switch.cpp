using namespace std;

class E_Switch : public Token {

protected:

	vector<E_Case*> list;
	Token* expr;

public:

	E_Switch() {
		this->list = vector<E_Case*>();
	}

	virtual ~E_Switch() {

	}

	void setExpr(Token* expr) {
		this->expr = expr;
	}

	// имя токена
	virtual string getType() {
		return "E_Switch";
	}

	void push(E_Case* ptr) {
		this->list.push_back(ptr);
	}

	virtual string dump(map<string,string> options = map<string,string>()) {
		vector<string> list;

		list.push_back(this->expr->dump());
		for(int i=0; i<this->list.size(); ++i) {
			list.push_back(this->list[i]->dump());
		}
		return Token::LuaInstance->execute("E_Switch", list);
	}
};
