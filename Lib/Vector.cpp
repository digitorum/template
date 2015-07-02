// объединить вектор в строку
std::string vector_join(std::vector<std::string> elements, std::string seperator) {
	std::string result = "";

	for(int i=0; i<elements.size(); ++i) {
		if(i != 0) {
			result += seperator;
		}
		result += elements.at(i);
	}
	return result;
}
