class S_List {

	std::vector<int> states;

public:

	int last;

	int pop() {
		last = states[states.size() - 1];
		states.pop_back();
		return last;
	}

	void push(int state) {
		states.push_back(state);
	}

};
