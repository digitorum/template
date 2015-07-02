#include "E_Cases.cpp"

using namespace std;

// Оператор switch
class E_Switch : public Token {

protected:

	// Список case
	E_Cases* list;

	// Expression
	Token* expr;

public:

	// Конструктор. Инициализация списка case
	E_Switch(Token* expr, E_Cases* cases) {
		this->list = cases;
		this->expr = expr;
	}

	// Деструктор
	virtual ~E_Switch() {
		delete this->list;
		delete this->expr;
	}

	// Имя токена
	virtual string getType() {
		return "E_Switch";
	}

	// Текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		vector<string> list;

		list.push_back(this->expr->dump());
		for(int i=0; i<this->list->size(); ++i) {
			list.push_back(this->list->at(i)->dump());
		}
		return Token::LuaInstance->execute("E_Switch", list);
	}
};
