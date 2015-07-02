-- возвращаемый "модуль"
local helpers = { };



-- разбить строку по разделителю
function helpers.split(str, sep)
	local result = {}
	local regex = string.format("([^%s]+)", sep)
	local line
	local i
	
	if(str == nill) then
		return result
	end
	for i,line in str:gmatch(regex) do
		table.insert(result, i)
	end
	return result
end



-- посчитать количество элементов в таблице
function helpers.count_table_items(tbl)
	local cnt = 0
	local line
	local i
	
	for i,line in pairs(tbl) do
		cnt = cnt + 1;
	end
	return cnt; 
end



-- возвращаем объект
return helpers;