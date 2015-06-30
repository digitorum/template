-- получить имя константы
function getConstantName(name)
	return "$constants['" .. name .. "']";
end



-- формирование имени переменной
function getVariableName(name)
	return "$" .. name;
end



-- получить имя метода
function getMethodName(method)
	local methods = {
		["ucase"]="ucase",
		["lcase"]="lcase"
	}
	if methods[method] ~= nil then
		return methods[method];
	end;
	return "nil"
end



-- накастать метод(ы) на переменную/константу
function castMethod(params)
	local result = "";
	
	for i,line in pairs(params) do
		if i == 1 then
			result = params[i] .. "("
		elseif i == 2 then
			result = result .. params[i]
		else
			result = result .. ", " .. params[i]
		end
	end
	return result .. ")"
end



-- объявление переменной
function setVariable(data)
	return "var " .. data.name .. " = " .. data.value .. ";"
end



-- if (expr) { statement } [else { statement }]
function getIf(data)
	local result = "";
	
	result = " if (" .. data.expr .. ") { " .. data.statement .. " } "
	if not (data.elsestatement == "") then
		result = result .. " else { " .. data.elsestatement .. " } "
	end
	return result
end