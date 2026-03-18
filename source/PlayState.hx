package;

import flixel.FlxSprite;
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

	public var player:FlxSprite;

	override public function create()
	{
		super.create();

		player = new FlxSprite();
		player.loadGraphic('assets/images/dude.png', true, 64, 64);
		player.animation.add('runnin', [0, 1], 6);
		player.animation.add('jump', [2, 3], 6, false);
		add(player);

		player.screenCenter();
		player.x *= 0.5;

		staminaBar = new FlxBar(0, 0, LEFT_TO_RIGHT, Math.round(FlxG.width * 0.9), Math.round(FlxG.height * 0.05), this, 'stamina', 0, STAMINA_MAX, false);
		staminaBar.createFilledBar(FlxColor.RED, FlxColor.LIME, false, FlxColor.BLACK, 1);
		add(staminaBar);

		staminaBar.screenCenter();
		staminaBar.y = FlxG.height * 0.9;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		final spriting:Bool = FlxG.keys.pressed.SHIFT;
		final moving:Bool = FlxG.keys.anyPressed([W, A, S, D, LEFT, DOWN, UP, RIGHT]);

		if (moving)
		{
			if (spriting)
				stamina -= 1 / 10;
			else
				stamina -= 1 / 64;
		}
		else
		{
			stamina += 8 / 100;
		}

		if (stamina > STAMINA_MAX)
			stamina = STAMINA_MAX;

		if (stamina < 0)
			stamina = 0;

		if (player.animation.name == 'runnin')
		{
			var target = 1.0;

			if (moving)
				if (spriting)
					target += (stamina / STAMINA_MAX) * 4;
				else
					target += (stamina / STAMINA_MAX) * 2;
			else
				target += (stamina / STAMINA_MAX) * 0.5;

			player.animation.timeScale = FlxMath.lerp(player.animation.timeScale, target, 1 / 32);
		}
		else
			player.animation.timeScale = 1.0;

		player.animation.play('runnin');
	}
}
