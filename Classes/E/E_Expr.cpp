using namespace std;


class E_Expr : public Token {

	// список токенов
	vector<Token*> tokens;

public:

	// конструктор "(token)"
	E_Expr(Token* obracket, Token* token, Token* cbracket) {
		this->tokens.push_back(obracket);
		this->tokens.push_back(token);
		this->tokens.push_back(cbracket);
	}

	// деструктор
	~E_Expr() {
		this->tokens.clear();
	}

	// текстовое представление ноды
	string Dump() {
		string result = "";
		int i = 0;

		for(i=0; i<this->tokens.size(); ++i) {
			if(result != "") {
				result += " ";
			}
			result += this->tokens.at(i)->Dump();
		}
		return result;
	}
};
