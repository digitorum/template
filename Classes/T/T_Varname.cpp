using namespace std;

class T_Varname : public Token {

protected:

	// имя переменной
	string varname;
	E_Methods* methods;

public:

	// конструктор, на вход приминмаем имя переменной
	T_Varname(string str, E_Methods* methods) {
		this->varname = str;
		this->methods = methods;
	}

	// виртуальный деструктор
	virtual ~T_Varname() {

	}

	// текстовое представление ноды
	virtual string Dump() {
		string result = "";
		int i = 0;

		result = Token::LuaInstance->execute(
			"varname",
			map<string,string>() = {
				{ "name", this->varname }
			}
		);
		if(this->methods->size()) {
			for(i=0; i<this->methods->size(); i++) {
				result =
					Token::LuaInstance->execute(
						"methodname",
						map<string,string>() = {
							{ "name", this->methods->at(i)->getName() }
						}
					)
					+ "( " + result + this->methods->at(i)->getParameters()->Dump() + " ) ";
			}
		}
		return result;
	}

};
