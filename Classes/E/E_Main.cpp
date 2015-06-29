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
	~E_Main() {
		this->tokens.clear();
	}

	// текстовое представление ноды
	string Dump() {
		string result = "";
		int i = 0;

		for(i=0; i<this->tokens.size(); ++i) {
			result += this->tokens.at(i)->Dump();
		}
		return result;
	}

};
