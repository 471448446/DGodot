extends Sprite2D
#每个 GDScript 文件都是一个隐含的类。extends 关键字定义了这个脚本所继承或扩展的类。这里它是 Sprite，意味着我们的脚本将获得 Sprite 节点的所有属性和函数，包括它继承的 Node2D、CanvasItem、Node 等类。
#在GDScript中，如果你省略了带有 extends 关键字的一行，你的类将隐式扩展 Reference，Godot使用它来管理你的应用程序的内存。

#成员变量位于脚本的顶部，在“extends”之后、函数之前。附加了此脚本的每个节点实例都将具有自己的 speed 和 angular_speed 属性副本。
var speed = 400
var angle_speed = PI

func _init():
	print("Hello,World")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Godot将在每一帧调用该函数，并传递给它一个名为 delta 的参数，即从上一帧开始经过的时间
func _process(delta):
	# 旋转 rotation 是2D图形的一个属性
	rotation += angle_speed*delta
	# 移动
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
