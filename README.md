# Генератор кода

<h3>Зависимости:</h3>
* flex
* bison
* liblua5.2-dev 

<h3>Синтаксис</h3>
Судя из названия - основноя задача генерить код (используя некий язык "шаблонирования").

* var: переменная
* const: константа
```
<var[name]>
<var[name->subname]>
<var[name].methodName().anotherMethodName("arg", 100, <var[another]>)>
<const[name].methodName()>
```

* set: объявление переменной
```
<set name = (100 + 1) * 2>
<set name = "text">
<set name = <var[another]> + 1>
```

* print: вывод
```
<print <var[name]>>
```

* if[-else]
```
<if 1 == 1>TRUE</if>
<if 1 == 1>TRUE<else>FALSE</if>
```

* switch
```
<switch <var[foo]>>
  <case "bar">BAR</case>
  <case "baz">BAZ</case>
</switch>
```

* each
```
<each <var[foo]> as <var[k]> <var[v]>>ITERATION</each>
```

* include: включение в текущий шаблон другого шаблона
```
<include name="/tmp/tpl.txt" input=<var[foo]> argName=<var[somename]> anotherArgName="text" andArgName=10>
```

* settings-param: настройки шаблона
```
<settings>
  <param name=<var[input]>>
  <param name=<var[somevar]>>
</settings>
```
