using Godot;
using System;

public partial class PlayerMovement : Node
{
	[Export] public int speed = 400;
	private Vector2 velocity;

	public void GetInput()
	{
		Vector2 inputDirection = Input.GetVector("move_left", "move_right", "move_up", "move_down");
		velocity = inputDirection * speed;
	}

	public override void _PhysicsProcess(double delta)
	{
		GetInput();
		//MoveAndSlide();
	}
}
