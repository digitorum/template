#include <typeinfo>

using namespace std;

class E_Main {

protected:

	// список токенов состояния
	vector<Token*> tokens;

public:

	// добавить токен в список
	void push(Token* token) {
		this->tokens.push_back(token);
	}

	// деструктор
	virtual ~E_Main() {
		this->tokens.clear();
	}

	// имя токена
	virtual string getType() {
		return "E_Main";
	}

	// текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		vector<Token*> list;
		vector<string> dumps;

		// объединяем текстовые ноды
		for(int i=0; i<this->tokens.size(); ++i) {
			if(i > 0) {
				if(this->tokens.at(i)->getType() == "T_Text" && list.back()->getType() == "T_Text") {
					list.back()->mergeWith(this->tokens.at(i));
					continue;
				}
			}
			list.push_back(this->tokens.at(i));
		}
		// формируем текстове представление
		for(int i=0; i<list.size(); ++i) {
			dumps.push_back(list.at(i)->dump());
		}
		list.clear();
		return Token::LuaInstance->execute("E_Main", dumps, options);
	}

};
