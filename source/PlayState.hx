package;

import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var stamina:Float = 1;
	public var staminaBar:FlxBar;

	override public function create()
	{
		super.create();

		staminaBar = new FlxBar(0, 0, LEFT_TO_RIGHT, Math.round(FlxG.width * 0.9), Math.round(FlxG.height * 0.1), this, 'stamina', 0, 1, false);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		final spriting:Bool = FlxG.keys.pressed.SHIFT;
		final moving:Bool = FlxG.keys.anyPressed([W, A, S, D, LEFT, DOWN, UP, RIGHT]);

		if (!moving)
		{
			if (spriting)
				stamina -= .1;
		}
		else
		{
			stamina += .025;
		}
	}
}
