using namespace std;

// Список атрибутов оператора
class E_Attributes {

	// Список аттрибутов
	map<string, Token*> list;

public:

	// Конструктор. Инициализация пустого списка атрибутов
	E_Attributes() {
		this->list = map<string, Token*>();
	}

	// Деструктор
	~E_Attributes() {
		for(map<string,Token*>::const_iterator i = this->list.begin(); i !=this->list.end(); ++i) {
			delete i->second;
		}
		this->list.clear();
	}

	// Получить конкретный аттрибут по имени
	string get(string name) {
		if(this->list.count(name) == 0) {
			return "";
		}
		return this->list[name]->dump();
	}

	// Получить список переменных для оператора include
	// TODO: refactor. Вынести в E_Include>
	map<string,string> getVariables() {
		map<string,string> table;

		for(map<string,Token*>::const_iterator i = this->list.begin(); i !=this->list.end(); ++i) {
			if(i->first == "name") {
				continue;
			}
			table.insert(pair<string,string>(i->first, i->second->dump()));
		}
		return table;
	}

	// Добавить атрибут в список
	void push(string name, Token* expr) {
		this->list.insert(pair<string, Token*>(name, expr));
	}

};
