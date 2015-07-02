#include "E_Parameters.cpp"

using namespace std;

// Метод
class E_Method {

protected:

	// Имя метода
	string name;

	// Список параметров
	E_Parameters* parameters;

public:

	// Конструктор. На вход имя и список параметров
	E_Method(string name, E_Parameters* parameters) {
		this->name = name;
		this->parameters = parameters;
	}

	// Деструктор
	~E_Method() {
		delete this->parameters;
	}

	// Получить имя метода
	string getName() {
		return this->name;
	}

	// Получить список параметров
	E_Parameters* getParameters() {
		return this->parameters;
	}

};


// Список методов
class E_Methods {

protected:

	// Список методов
	vector<E_Method*> methods;

public:

	// Конструктор, инициализируем пустой список
	E_Methods() {
		this->methods = vector<E_Method*>();
	}

	// Деструктор
	~E_Methods() {
		for(int i=0;i<this->methods.size(); ++i) {
			delete this->methods.at(i);
		}
		this->methods.clear();
	}

	// Добавить метод в список
	void push(string name, E_Parameters* parameters) {
		this->methods.push_back(new E_Method(name, parameters));
	}

	// Получить количество методов
	int size() {
		return this->methods.size();
	}

	// Получить элемент
	E_Method* at(int i) {
		return this->methods.at(i);
	}

};
