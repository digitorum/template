#include "E_Case.cpp"

using namespace std;

// Список кейсов
class E_Cases {

protected:

	// Список кейсов
	vector<E_Case*> list;

public:

	// Конструктор. Инициализаця пустого списка
	E_Cases() {
		this->list = vector<E_Case*>();
	}

	// Деструктор
	~E_Cases() {
		for(int i=0; i<this->list.size(); ++i) {
			delete this->list.at(i);
		}
	}

	// Добавить case в список
	void push(E_Case* ptr) {
		this->list.push_back(ptr);
	}

	// размер списка
	int size() {
		return this->list.size();
	}

	// получить конкретный элемент
	E_Case* at(int i) {
		return this->list.at(i);
	}
};
