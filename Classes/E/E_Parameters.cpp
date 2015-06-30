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
		this->parameters.empty();
	}

	// добавить параметр
	void push(Token* parameter) {
		this->parameters.push_back(parameter);
	}

	// текстовое представление
	vector<Token*> get() {
		return this->parameters;
	}
};
