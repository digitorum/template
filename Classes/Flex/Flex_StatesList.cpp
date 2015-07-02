using namespace std;

// Список состояний
class Flex_StatesList {

	// Список состояний
	vector<int> states;

public:

	// Получить последнее состояние
	int pop() {
		int last = states[states.size() - 1];
		states.pop_back();
		return last;
	}

	// Добавить состояние в список
	void push(int state) {
		states.push_back(state);
	}

};
