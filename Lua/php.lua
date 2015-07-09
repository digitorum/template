local helpers = require "Lua.Includes.helpers"
local commons = require "Lua.Includes.common"



-- предопределенные константы
_G["cg_constants"] = {
	["SELFNAME"]="\"tempate\""
}



-- предопределенные методы
_G["cg_methods"] = {
	["ucase"]="strtoupper",
	["lcase"]="strtolower",
	["substr"]="substr"
}



-- обработать символ смены строки
function processNewLines(data)
	return data;
end



-- объявление переменной
function E_Set(data)
	return "'; " .. data.name .. "=" .. data.value .. "; $_template_result .= '"
end



-- получить E_If в виде строки
function E_If(data)
	local result = "";
	
	result = "'.((" .. data.expr .. ")?(" .. data.statement .. "):"
	if not (data.elsestatement == "") then
		result = result .. "(" .. data.elsestatement .. ")"
	else
		result = result .. "('')"
	end
	result = result .. ").'"
	return result
end



-- получить E_Main в виде строки
function E_Main(data, options)
	local parameters = helpers.split(options["parameters"], ",")
	
	if(options["isFinal"] == "true") then
		return "<?php $f = function(" .. table.concat(parameters, ", ") .. ") { $_template_result = '" .. table.concat(data, "") .. "'; return $_template_result; }; ?>"
	else
		return "'" .. table.concat(data, "") .. "'"
	end
end



-- получить E_Print в виде строки
function E_Print(data)
	return "'.(" .. data .. ").'"
end



-- подключение подшаблона
function E_Include(result, variables)
	--todo fixit
	local args = string.match(result, "function%(([^)]+)%)")
	local pass = { }
	local vars = {}
	local line
	local i
	
	args = args:gsub("%s", "")
	args = helpers.split(args, ",");
	for i,line in pairs(variables) do
		vars[T_Var(i)] = variables[i];
	end
	for i,line in pairs(args) do
		table.insert(pass, vars[args[i]])
	end
	result = result:gsub("^<%?php ", "")
	result = result:gsub(" %?>$", "")
	return "'.call_user_func(function() { " .. result .. " return f(" .. table.concat(pass, ", ") .. "); }).'"
end



-- получить E_Each в виде строки
function E_Each(data)
	return "'.call_user_func(function() { var $_template_each = ''; foreach(" .. data["var"] .. " as " .. data["k"] .. " => " .. data["v"] .. ") { $_template_each .= " .. data["body"] .. "; } return $_template_each; }).'"
end;



-- получить E_Switch в виде строки
function E_Switch(data)
	local result = "'.call_user_func(function() { "
	local line
	local i
	
	for i,line in pairs(data) do
		if (i == 1) then
			result = result .. "switch (" .. data[i] .. ") { "
		else
			result = result .. data[i]
		end
	end
	return result .. "}; }).'"
end



-- получить E_Case в виде строки
function E_Case(data)
	return "case " .. data["expr"] .. ": return (" .. data["body"] .. "); break; "
end