--Button

local btn = ccui.Button:create("btn-about-normal.png","btn-about-normal.png")

btn:setContentSize(cc.Size(100,30))
btn:setPosition(cc.p(300,300))
btn:setZoomScale(0.4)
btn:setPressedActionEnabled(true)
btn:addTouchEventListener(function ( event,type )
	--dump(type)
	if type = 2 then
		print("clicked")
	end
end)

self:addChild(btn)


--触摸

local function touchbegan( location, event )
	print("这是一种通用的触摸")
	local p = location:getLocation()
    print(p.x .. p.y)
    return true
end

local listener = cc.EventListenerTouchOneByOne:create()

local dispatcher = cc.Director:getInstance():getEventDispatcher()

listener:registerScriptHandler(touchbegan, cc.Handle.EVENT_TOUCH_BEGAN)

dispatcher:addEventListenerWithSceneGraphPriority(listener, self)


--先要新建一个类EXNode

local EXNode = class("EXNode", function (  )
	return display.newNode()
end)

function EXNode:ctor(  )
	--该句为EXNode类添加了扩展的事件处理方法，现在我们可以使用EventProxy中的函数了，
	--通过这些函数我们可以让EXNode接收到自定义的消息然后进行处理
	cc.GameObject.extend(self):addComponent("components.behavior.EventProtocol")
		:exportMethods()
	cc.ui.UIPushButton.new({normal =" "})
	:align(display.CENTER, display.cx, display.cy)
	:onButtonClicked(function (  )
		self:getChildEvent()
	end)
	:addTo(self)
end

function EXNode:getChildEvent(  )
	self:dispatchEvent({name = "MY_NEWS"})
end

function EXNode:onEnter(  )
	self:onTouchEnabled(true)
end

function EXNode:onExit(  )
	self:removeAllEventListeners()
end

return EXNode

--使用方法

function MainScene:ctor(  )
	cc.ui.cc.ui.UILabel.new({UILabelType = 2,text = "Hello", size = 64})
	:align(display.CENTER, display.cx, display.cy)
	:addTo(self)

	self:exNode = EXNode.new()
	self.exNode:addEventListener("MY_NEWS", handler(self, self.onMynews))
	self:addChild(self.exNode)
end

function MainScene:onMynews(  )
	print("INFO","父Node知道了子Node发过来的消息")
end