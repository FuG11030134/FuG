--print("Hello".."World")
--[[
1.注释：
	单行注释：--
	多行注释：--[[ --]]
--]]





--[[
2.全局变量:
	不需要声明，给一个变量直接赋值后即创建该全局变量
	将全局变量的值赋为 nil 即删除该全局变量
--]]
print(b)
b = 10
print(b)
b = nil
print(b)





--[[
3.Lua 保留字
	and break do else elseif end false for function if
	in local nil not or repeat return then true until while
--]]





--4.类型和值
print("Hello World")	-->string
print(type(10.4*3))		-->number
print(type(print))		-->function
print(type(type))		-->function
print(type(true))		-->boolean
print(type(nil))		-->nil
print(type(type(x)))	-->string
a = print
a(type(a))	-->function

	--[[
	4.1 Boolean 类型
		Lua 中的所有值都可以作为条件
		在控制结构的条件中除了 false 和 nil 为假，其他都为真，0和空串也为真

	4.2 Number 类型---------实数

	4.3 String 类型
		4.3.1 Lua 中的字符串不可以修改
			a = "one string"
			b = string.gsub(a, "one", "another")	
			print(a)
			print(b)	---------->another string
		4.3.2 转义序列
			\a
			\b 	后退
			\f  换页
			\n  换行
			\r  回车
			\t  制表
			\v
			\\ 
			\"	
			\'
			\[
			\]

	4.4 类型转换
		Lua 会自动在 string 和 number 之间自动进行类型转换
			当一个字符串使用算数操作符时，string 就会被转换成数字
			当 Lua 期望一个 string 而碰到数字时，会将数字转成 string
		string 和 number 的比较
			10 == "10"	--false
			tostring(10) == "10"	--true
			可以使用 tonumber() 函数将 string 转换成 number，如果 string 不是正确的数字则返回 nil
			可以使用 tostring() 函数将 number 转换成 string
    --]]




--5.运算符
	--[[
		5.1 关系运算符
			<	>	<=	>=	==	~=
		5.2 逻辑运算符
			and		or		not
			false 和 nil 是假，其他都为真
			a and b 	--如果 a 为 false，则返回 a，否则返回 b
			a or b 		--如果 a 为 true，则返回 a，否则返回 b
		5.3 运算符优先级(高->低)
			^
			not	-(负号)
			*  /
			+  -
			..
			<  >  <=  >=  ~=  ==
			and
			or
	--]]



--6.语句
	--[[
		6.1 赋值语句
			a,b = 10, 2*x	<---->	a = 10; b = 2*x
			a,b = 10	<---->	a = 10; b = nil
			a[i], a[j] = a[j], a[i]		--交换2个变量的值
		6.2 局部变量
			用 local 创建一个局部变量，局部变量只在被声明的代码块中有效
			代码块:	一个控制结构或者一个函数体，或者一个 chunk(变量被声明的那个文件或者文本串)
		6.3 控制语句
			(1)
			if ... then
				...
			end
			(2)
			if ... then
				...
			elseif ... then
					...
			.
			.
			.
			else
				...
			end
			(3)
			for var=exp1,exp2,exp3 do	------->"for(var=exp1, var<=exp2, var+=exp3)"
				...
			end
			exp3可省略，默认为1
	--]]
	


--7.函数
	--[[
		function function_name( ... )
		-- body
		end
	--]]



--8.Lua table
	day = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
	print(day[1])		------>Sunday,索引下标从1开始
	a = {x=1, y=5}
	print(a.y)	-------->5
	Config = {hello="Hello Lua", age = 50}
	Config.words = "Hello World"
	Config.number = 100
	print(Config.words)	--------->Hello World

	arr={1,2,3,4,"Hello"}
	for key,var in pairs(arr) do	--遍历
		print(key,var)
	end

	arr={}
	for var=1,10 do
		table.insert(arr, 1, var)
	end
	for key,var in pairs(arr) do
		print(key,var)
	end
	print(table.maxn(arr))	--table的大小



--9.面向对象
	--9.1 复制表的形式实现面向对象
	--[[
	People = {}
	People.sayHi = function(self)	-- function People.sayHi()
		print("People say Hi!"..self.name)
	end

	function clone(tab)	--克隆函数
		local ins = {}
		for k,v in pairs(tab) do
			ins[k] = v
		end
		return ins
	end

	function copy( dist, tab )	--拷贝函数
		for k,v in pairs(tab) do
			dist[k] = v
		end
	end

	People.new = function( name )	--构造函数
		local self = clone(People)
		self.name = name
		return self
	end

	local p = People.new("ZhangSan")
	p:sayHi()  -- p.sayHi(p)	-->People say Hi!ZhangSan

	Man = {}
	Man.new = function ( name )
		local self = People.new(name)
		copy(self, Man)	--通过拷贝函数将 Man 里面的所有键值对赋给 self，而 Man 里面所有的键值对就是函数的定义，所以这里相当于继承
		return self
	end
	Man.sayHello = function ()
		print("Man say Hello")
	end
	-- Man.sayHi = function(self)	--重写继承过来的方法
	-- 	print("Man sayHi "..self.name)
	-- end

	local m = Man.new("Lisi")
	m:sayHello()	-->Man say Hello
	m:sayHi()	--继承过来的方法-->People say Hi!Lisi

	--]]

	--9.2 函数闭包的形式实现面向对象-------相对于复制表的形式运行速度慢一点点
		function People( name )
			local self = {}
			local function init()	--创建一个局部构造函数初始化 People 的对象，相当于一个私有函数
				self.name = name
			end
			self.sayHi = function()
				print("Hello "..self.name)
			end
			init()
			return self
		end

		local p = People("ZhangSan")
		p:sayHi()	-->Hello ZhangSan

		function Man( name )
			local  self = People(name)	--继承
			-- local function init()
			-- 	-- body
			-- end = 1
			self.sayHello = function()
				print("Hi "..self.name)
			end
			return self
		end

		local m = Man("LiSi")
		m:sayHello()
		m:sayHi()

 