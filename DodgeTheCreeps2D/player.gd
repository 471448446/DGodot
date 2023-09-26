extends Area2D

# 自定义信号，这里希望检查player被撞击
# 这定义了一个叫作“hit”的自定义信号，当玩家与敌人碰撞时，我们会让他发出这个信号
signal hit

# https://docs.godotengine.org/zh_CN/4.x/getting_started/first_2d_game/03.coding_the_player.html

#在第一个变量 speed 上使用 export 关键字，这样我们就可以在“检查器”中设置其值。666
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	# 获取窗口大小
	screen_size = get_viewport_rect().size
	print("screenSize:")
	print(screen_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#pass
	#==============检测按键方向
	# 我们首先将 velocity 设置为 (0, 0)——默认情况下玩家不应该移动。
	# 然后我们检查每个输入并从 velocity 中进行加/减以获得总方向。
	# 例如，如果您同时按住 右 和 下，则生成的 velocity 向量将为 (1, 1)。
	# 此时，由于我们同时向水平和垂直两个方向进行移动，玩家斜向移动的速度将会比水平移动要更快。
	
	# 只要对速度进行归一化就可以防止这种情况，也就是将速度的长度设置为 1，然后乘以想要的速度。这样就不会有过快的斜向运动了。
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if  velocity.length() > 0:
		velocity = velocity.normalized() * speed
		# $是获取节点的操作符，等价于 get_node("AnimatedSprite2D").play()
		# 因为AnimatedSprite2D是Player的子节点，所以可以这样使用
		$AnimatedSprite2D.play()
	else: 
		$AnimatedSprite2D.stop()
	# 现在我们有了一个运动方向，我们可以更新玩家的位置了。
	position += velocity * delta
	# 我们也可以使用 clamp() 来防止它离开屏幕。 clamp 一个值意味着将其限制在给定范围内
	position = position.clamp(Vector2.ZERO,screen_size)
	
	
func _on_body_entered(body):
	hide() # 被击中就消失
	hit.emit() # 发送击中信号
	$CollisionShape2D.set_deferred("disabled",true) #我们需要禁用玩家的碰撞检测，确保我们不会多次触发 hit 信号。
	
# 用于在开始新游戏时调用来重置玩家
func start(pos):
	position = pos
	show() # 之前消失了，现在显示
	$CollisionShape2D.disabled = false #另外一种
