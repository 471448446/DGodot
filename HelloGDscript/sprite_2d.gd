extends Sprite2D
#每个 GDScript 文件都是一个隐含的类。extends 关键字定义了这个脚本所继承或扩展的类。这里它是 Sprite，意味着我们的脚本将获得 Sprite 节点的所有属性和函数，包括它继承的 Node2D、CanvasItem、Node 等类。
#在GDScript中，如果你省略了带有 extends 关键字的一行，你的类将隐式扩展 Reference，Godot使用它来管理你的应用程序的内存。

#成员变量位于脚本的顶部，在“extends”之后、函数之前。附加了此脚本的每个节点实例都将具有自己的 speed 和 angular_speed 属性副本。
var speed = 400
var angle_speed = PI

# 这个类被创建的时候
func _init():
	print("Hello,World")

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	# https://ask.godotengine.org/130426/how-do-i-make-a-simple-timer
	var timer = get_node("MyTimer")
	print(timer)
	timer.connect("timeout",Callable(self,"_on_timer_timeout"),CONNECT_DEFERRED)	
	#timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	visible = not visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Godot将在每一帧调用该函数，并传递给它一个名为 delta 的参数，即从上一帧开始经过的时间
func _process(delta):
	#test1(delta)
	#test2(delta)
	test3(delta)

func test3(delta:float):
	# 按钮按下的时候，修改位置
	rotation += angle_speed*delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	
# 尝试建议输入事件
func test2(delta:float):
	#总之，Godot中的每个脚本都代表一个类，并扩展了引擎的一个内置类。
	#在我们sprite的例子中，你的类所继承的节点类型可以让你访问一些属性，如 rotation 和 position 。你还继承了许多函数，但我们在这个例子中没有使用这些函数
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	rotation += angle_speed * direction * delta
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed
	if Input.is_action_pressed("ui_down"):
		velocity = -Vector2.UP.rotated(rotation) * speed
	position += velocity * delta

func test1(delta:float):
	# 基本上是一直的 60帧
	#print(delta)
	# 旋转 rotation 是2D图形的一个属性
	rotation += angle_speed*delta
	# 移动
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	

func _on_button_pressed():
	# 此函数将切换处理，进而切换按下按钮时图标的移动。
	# 启用或警用帧刷新
	set_process(not is_processing())
