-- разбить строку по разделителю
local function split(str, sep)
	local result = {}
	local regex = string.format("([^%s]+)", sep)
	
	if(str == nill) then
		return result
	end
	for line,_ in str:gmatch(regex) do
		table.insert(result, line)
	end
	return result
end



-- получить имя константы
function T_Const(name)
	local constants = {
		["SELFNAME"]="\"tempate\""
	}
	if constants[name] ~= nil then
		return constants[name];
	end;
	return "nil"
end



-- получить число
function T_Numeric(data)
	return data;
end



-- получить текст
function T_Text(data)
	return data;
end



-- формирование имени переменной
function T_Var(name)
	return "$" .. name;
end



-- получить имя метода
function getMethodName(method)
	local methods = {
		["ucase"]="ucase",
		["lcase"]="lcase",
		["substr"]="substr"
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
function E_Set(data)
	return "'; var " .. data.name .. "=" .. data.value .. "; $_template_result += '"
end



-- получить E_If в виде строки
function E_If(data)
	local result = "";
	
	result = "'+((" .. data.expr .. ")?(" .. data.statement .. "):"
	if not (data.elsestatement == "") then
		result = result .. "(" .. data.elsestatement .. ")"
	else
		result = result .. "('')"
	end
	result = result .. ")+'"
	return result
end



-- получить E_Main в виде строки
function E_Main(data, options)
	local parameters = split(options["parameters"], ",")
	
	if(options["isFinal"] == "true") then
		return "var f = function(" .. table.concat(parameters, ", ") .. ") { var $_template_result = '" .. table.concat(data, "") .. "'; return $_template_result; };"
	else
		return "'" .. table.concat(data, "") .. "'"
	end
end



-- получить E_Expr в виде строки
function E_Expr(data)
	return table.concat(data, "")
end



-- получить E_Print в виде строки
function E_Print(data)
	return "'+(" .. data .. ")+'"
end


-- подключение подшаблона
function E_Include(result, variables)
	--todo fixit
	local args = string.match(result, "function%(([^)]+)%)")
	local pass = { }
	local vars = {}
	
	args = args:gsub("%s", "")
	args = split(args, ",");
	for i,line in pairs(variables) do
		vars[T_Var(i)] = variables[i];
	end
	for i,line in pairs(args) do
		table.insert(pass, vars[args[i]])
	end
	return "'+(function() { " .. result .. " f(" .. table.concat(pass, ", ") .. "); })()+'"
end


-- получить E_Each в виде строки
function E_Each(data)
	return "'+(function() { var $_template_each = ''; $.each(" .. data["var"] .. ", function(" .. data["k"] .. ", " .. data["v"] .. ") { $_template_each += " .. data["body"] .. "; }); return $_template_each; })()+'"
end;


-- получить E_Switch в виде строки
function E_Switch(data)
	local result = "'+(function() { "
	
	for i,line in pairs(data) do
		if (i == 1) then
			result = result .. "switch (" .. data[i] .. ") { "
		else
			result = result .. data[i]
		end
	end
	return result .. "}; })()+'"
end



-- получить E_Case в виде строки
function E_Case(data)
	return "case " .. data["expr"] .. ": return (" .. data["body"] .. "); break; "
end

