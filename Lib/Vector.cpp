using namespace std;

// объединить вектор в строку
string vector_join(vector<string> elements, string seperator) {
	string result = "";

	for(int i=0; i<elements.size(); ++i) {
		if(i != 0) {
			result += seperator;
		}
		result += elements.at(i);
	}
	return result;
}
