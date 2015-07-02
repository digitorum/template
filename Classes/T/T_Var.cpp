using namespace std;

// Оператор var
class T_Var : public Token {

protected:

	// Имя переменной
	string varname;

	// список применяемых методов
	E_Methods* methods;

public:

	// Конструктор. На вход принимаем имя переменной и список методов
	T_Var(string str, E_Methods* methods) {
		this->varname = str;
		this->methods = methods;
	}

	// Деструктор
	virtual ~T_Var() {
		delete this->methods;
	}

	// Имя токена
	virtual string getType() {
		return "T_Var";
	}

	// Текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		string result = Token::LuaInstance->execute("T_Var", this->varname);
		if(this->methods->size()) {
			for(int i=0; i<this->methods->size(); ++i) {
				vector<string> data = vector<string>();
				vector<Token*> parameters = this->methods->at(i)->getParameters()->get();
				data.push_back(Token::LuaInstance->execute("getMethodName", this->methods->at(i)->getName()));
				data.push_back(result);
				if(parameters.size() > 0) {
					for(int j=0; j<parameters.size(); ++j) {
						data.push_back(parameters.at(j)->dump());
					}
				}
				result = Token::LuaInstance->execute("castMethod", data);
			}
		}
		return result;
	}

};
