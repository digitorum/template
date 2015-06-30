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

	// текстовое представление ноды
	virtual string Dump() {
		string result = "";
		int i = 0;

		result = "$" + this->varname;
		if(this->methods->size()) {
			for(i=0; i<this->methods->size(); i++) {
				result = this->methods->at(i)->getName() + "( " + result + this->methods->at(i)->getParameters()->Dump() + " ) ";
			}
		}
		return result;
	}

};
