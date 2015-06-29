using namespace std;


class E_Parameters {

protected:

	vector<Token*> parameters;

public:

	// конструктор
	E_Parameters() {
		this->parameters = vector<Token*>();
	}

	// деструтокр
	~E_Parameters() {

	}

	// добавить параметр
	void push(Token* parameter) {
		this->parameters.push_back(parameter);
	}

	// текстовое представление
	string Dump() {
		string result = "";
		int i = 0;

		for(i=0; i<this->parameters.size(); ++i) {
			result += ", " + this->parameters.at(i)->Dump();
		}
		return result;
	}
};
