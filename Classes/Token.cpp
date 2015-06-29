using namespace std;

class Token {

public:

	// текстовое представление ноды
	virtual string Dump() = 0;

	// виртуальный деструктор
	virtual ~Token() {

	}
};
