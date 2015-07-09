local helpers = require "Lua.Includes.helpers"



-- формирование имени переменной
function T_Var(name)
	local tbl = helpers.split(name, "->")
	local result = ""
	local line
	local i
	
	if(helpers.count_table_items(tbl) == 1) then
		return "$" .. tbl[1];
	end
	for i,line in pairs(tbl) do
		if(i == 1) then
			result = "$" .. line .. "['"
		else 
			if(i == 2) then
				result = result .. line
			else
				result = result .. "']['" .. line
			end
		end
	end
	return result .. "']"
end



-- получить имя константы
function T_Const(name)
	if _G["cg_constants"][name] ~= nil then
		return _G["cg_constants"][name];
	end;
	return "nil"
end



-- получить число
function T_Numeric(data)
	return data;
end



-- получить текст
function T_Text(data)
	return processNewLines(data):gsub("'", "\\'")
end



-- получить имя метода
function getMethodName(method)
	if _G["cg_methods"][method] ~= nil then
		return _G["cg_methods"][method];
	end;
	return "nil"
end



-- накастать метод(ы) на переменную/константу
function castMethod(params)
	local result = ""
	local line
	local i
	
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



-- получить E_Expr в виде строки
function E_Expr(data)
	return table.concat(data, "")
end