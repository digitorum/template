using namespace std;

// Опеоартор const
class T_Const : public Token {

protected:

	// Имя константы
	string varname;

	// Список применяемых методов
	E_Methods* methods;

public:

	// Конструктор. На вход принимаем имя константы и список методов
	T_Const(string str, E_Methods* methods) {
		this->varname = str;
		this->methods = methods;
	}

	// Деструктор
	virtual ~T_Const() {
		delete this->methods;
	}

	// Имя токена
	virtual string getType() {
		return "T_Const";
	}

	// Текстовое представление ноды
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
