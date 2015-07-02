using namespace std;

// Оператор switch
class E_Switch : public Token {

protected:

	// Список case
	vector<E_Case*> list;

	// Expression
	Token* expr;

public:

	// Конструктор. Инициализация списка case
	// TODO: refactor. разобраться с определением expr
	E_Switch() {
		this->list = vector<E_Case*>();
	}

	// Деструктор
	virtual ~E_Switch() {
		for(int i=0; i<this->list.size(); ++i) {
			delete this->list.at(i);
		}
		delete this->expr;
	}

	// Установить expression
	void setExpr(Token* expr) {
		this->expr = expr;
	}

	// Имя токена
	virtual string getType() {
		return "E_Switch";
	}

	// Добавить case в список
	void push(E_Case* ptr) {
		this->list.push_back(ptr);
	}

	// Текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		vector<string> list;

		list.push_back(this->expr->dump());
		for(int i=0; i<this->list.size(); ++i) {
			list.push_back(this->list[i]->dump());
		}
		return Token::LuaInstance->execute("E_Switch", list);
	}
};
