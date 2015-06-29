#include "E_Parameters.cpp"

using namespace std;


class E_Method {

protected:

	string name;
	E_Parameters* parameters;

public:

	E_Method(string name, E_Parameters* parameters) {
		this->name = name;
		this->parameters = parameters;
	}

	~E_Method() {

	}

	string getName() {
		return this->name;
	}

	E_Parameters* getParameters() {
		return this->parameters;
	}

};

class E_Methods {

protected:

	vector<E_Method*> methods;

public:

	// конструктор
	E_Methods() {
		this->methods = vector<E_Method*>();
	}

	// деструктор
	~E_Methods() {
	}

	// добавить элемент
	void push(string name, E_Parameters* parameters) {
		this->methods.push_back(new E_Method(name, parameters));
	}

	// получить общее количество методов
	int size() {
		return this->methods.size();
	}

	// получить элемент
	E_Method* at(int i) {
		return this->methods.at(i);
	}

};
