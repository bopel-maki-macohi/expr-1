package;

import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.FlxState;

class PlayState extends FlxState
{
	public final STAMINA_MAX:Float = 100.0;

	public var stamina:Float = 1;
	public var staminaBar:FlxBar;

	override public function create()
	{
		super.create();

		staminaBar = new FlxBar(0, 0, LEFT_TO_RIGHT, Math.round(FlxG.width * 0.9), Math.round(FlxG.height * 0.05), this, 'stamina', 0, STAMINA_MAX, false);
		staminaBar.createFilledBar(FlxColor.RED, FlxColor.LIME, false, FlxColor.BLACK, 1);
		add(staminaBar);

		staminaBar.screenCenter();
		staminaBar.y = FlxG.height * 0.95;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		final spriting:Bool = FlxG.keys.pressed.SHIFT;
		final moving:Bool = FlxG.keys.anyPressed([W, A, S, D, LEFT, DOWN, UP, RIGHT]);

		if (moving)
		{
			if (spriting)
				stamina -= 0.1;
			else
				stamina -= 0.025;
		}
		else
		{
			stamina += 0.08;
		}

		if (stamina > STAMINA_MAX)
			stamina = STAMINA_MAX;

		if (stamina < 0)
			stamina = 0;
	}
}
