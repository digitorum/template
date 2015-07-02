using namespace std;

// оператор include
class E_Include : public Token {

protected:

	// Список аттрибутов
	E_Attributes* attrs;

public:

	// Конструтокр. На вход получаем список аттирбутов
	E_Include(E_Attributes* attrs) {
		this->attrs = attrs;
	}

	// Деструктор
	virtual ~E_Include() {
		delete this->attrs;
	}

	// Имя токена
	virtual string getType() {
		return "E_Include";
	}

	// Текстовое представление ноды
	string dump(map<string,string> options = map<string,string>()) {
		string result = "";
		string cmd = Token::AppPath;

		if(this->attrs->get("name") == "") {
			return "";
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
		return Token::LuaInstance->execute("E_Include", result, this->attrs->getVariables());
	}
};
