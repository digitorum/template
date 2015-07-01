-- получить имя константы
function T_Const(name)
	return "$constants['" .. name .. "']";
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
function E_Set(data)
	return "var " .. data.name .. " = " .. data.value .. ";"
end



-- получить E_If в виде строки
function E_If(data)
	local result = "";
	
	result = " if (" .. data.expr .. ") { " .. data.statement .. " } "
	if not (data.elsestatement == "") then
		result = result .. " else { " .. data.elsestatement .. " } "
	end
	return result
end



-- получить E_Main в виде строки
function E_Main(data, options)
	return table.concat(data, "")
	-- todo: complete
	--if(options["isFinal"] == "true") then
	--	return " var f = function() { var result = '" .. table.concat(data, "") .. "' return result; } "
	--else
	--	return "'" .. table.concat(data, "") .. "'"
	--end
end;



-- получить E_Expr в виде строки
function E_Expr(data)
	return table.concat(data, " ")
end



-- получить E_Print в виде строки
function E_Print(data)
	return "print " .. data .. " "
end


-- подключение подшаблона
function E_Include(result, variables)
	local pass = { }
	local args = { }
	
	for i,line in pairs(variables) do
		table.insert(pass, i);
		table.insert(args, variables[i]);
	end
	return "(var f = function(" .. table.concat(pass, ", ") .. "){" .. result .. "}; f(" .. table.concat(args, ", ") .."))"
end


-- получить E_Each в виде строки
function E_Each(data)
	return "foreach " .. data["var"] .. " as " .. data["k"] .. " => " .. data["v"] .. " " .. data["body"] .. " endforeach"
end;