using namespace std;

class E_Attributes {

	map<string, Token*> list;

public:

	E_Attributes() {
		this->list = map<string, Token*>();
	}

	~E_Attributes() {

	}

	string get(string name) {
		if(this->list.count(name) == 0) {
			return "";
		}
		return this->list[name]->dump();
	}

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

	void push(string name, Token* expr) {
		this->list.insert(pair<string, Token*>(name, expr));
	}

};
