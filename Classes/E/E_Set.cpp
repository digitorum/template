using namespace std;

// Оператор set
class E_Set : public Token {

	// Список токенов
	vector<Token*> tokens;

public:

	// Конструктор "(token)"
	E_Set(Token* var, Token* expr) {
		this->tokens.push_back(var);
		this->tokens.push_back(expr);
	}

	// Деструктор
	virtual ~E_Set() {
		for(int i=0; i<this->tokens.size(); ++i) {
			delete this->tokens.at(i);
		}
		this->tokens.clear();
	}

	// Имя токена
	virtual string getType() {
		return "E_Set";
	}

	// Текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		return Token::LuaInstance->execute(
			"E_Set",
			map<string,string>() = {
				{"name", this->tokens.at(0)->dump()},
				{"value", this->tokens.at(1)->dump()}
			}
		);
	}
};
