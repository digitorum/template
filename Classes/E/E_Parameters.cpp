using namespace std;

// Список параметров метода
class E_Parameters {

protected:

	// Список параметров метода
	vector<Token*> parameters;

public:

	// Конструктор. Инициализируем пустой список
	E_Parameters() {
		this->parameters = vector<Token*>();
	}

	// Деструтокр
	~E_Parameters() {
		for(int i=0;i<this->parameters.size(); ++i) {
			delete this->parameters.at(i);
		}
		this->parameters.empty();
	}

	// Добавить параметр в список
	void push(Token* parameter) {
		this->parameters.push_back(parameter);
	}

	// Получить список параметров
	vector<Token*> get() {
		return this->parameters;
	}
};
