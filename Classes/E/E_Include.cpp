using namespace std;

class E_Include : public Token {

protected:

	E_Attributes* attrs;

public:

	E_Include(E_Attributes* attrs) {
		this->attrs = attrs;
	}

	virtual ~E_Include() {
		delete this->attrs;
	}

	// имя токена
	virtual string getType() {
		return "E_Include";
	}

	// текстовое представление ноды
	string dump(map<string,string> options = map<string,string>()) {
		if(this->attrs->get("name") == "") {
			return "";
		}

		string result = "";
		string cmd = Token::AppPath;

		map<string,string> variables = this->attrs->getVariables();
		for(map<string,string>::const_iterator i = variables.begin(); i !=variables.end(); ++i) {
			string val = i->second;
			val = string_replace_all(val, "\\", "\\\\");
			val = string_replace_all(val, "\"", "\\\"");
			val = string_replace_all(val, "$", "\\$");
			cmd += " -v " + i->first + "=\"" + val + "\"";
		}
		cmd += " < " + this->attrs->get("name");
		char buffer[128];
		FILE* pipe = popen(cmd.c_str(), "r");
		if(!pipe) {
			return "";
		}
		while(!feof(pipe)) {
			if(fgets(buffer, 128, pipe) != NULL) {
				result += buffer;
			}
		}
		pclose(pipe);
		return Token::LuaInstance->execute("E_Include", result, variables);
	}
};
