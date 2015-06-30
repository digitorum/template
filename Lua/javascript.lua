-- формирование имени переменной
function varname(var)
	return "$" .. var.name;
end


-- получить имя метода
function methodname(method)
	local methods = {
		["ucase"]="ucase"
	}
	if methods[method.name] ~= nil then
		return methods[method.name];
	end;
	return "nil"
end