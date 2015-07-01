using namespace std;

class T_Const : public Token {

protected:

	// имя переменной
	string varname;
	E_Methods* methods;

public:

	// конструктор, на вход приминмаем имя переменной
	T_Const(string str, E_Methods* methods) {
		this->varname = str;
		this->methods = methods;
	}

	// виртуальный деструктор
	virtual ~T_Const() {

	}

	// имя токена
	virtual string getType() {
		return "T_Const";
	}

	// текстовое представление ноды
	virtual string dump(map<string,string> options = map<string,string>()) {
		string result = Token::LuaInstance->execute("T_Const", this->varname);
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
