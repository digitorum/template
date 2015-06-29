class S_List {

	std::vector<int> states;

public:

	int pop() {
		int state = states[states.size() - 1];
		states.pop_back();
		return state;
	}

	void push(int state) {
		states.push_back(state);
	}

};
