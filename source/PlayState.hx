package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
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

	public var obstacles:FlxTypedGroup<Obstacle>;

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

		obstacles = new FlxTypedGroup<Obstacle>();
		add(obstacles);

		staminaBar = new FlxBar(0, 0, LEFT_TO_RIGHT, Math.round(FlxG.width * 0.9), Math.round(FlxG.height * 0.05), this, 'stamina', 0, STAMINA_MAX, false);
		staminaBar.createFilledBar(FlxColor.RED, FlxColor.LIME, false, FlxColor.BLACK, 1);
		add(staminaBar);

		staminaBar.screenCenter();
		staminaBar.y = FlxG.height * 0.9;

		new FlxTimer().start(1, function(tmr)
		{
			if (FlxG.random.bool(5))
				if (tmr.time < 4)
					tmr.time *= FlxG.random.float(0.1, 2.5);
				else
					tmr.time *= FlxG.random.float(0.1, 0.9);

			var obstacle:Obstacle = new Obstacle();
			obstacle.setPosition(player.x, player.y);

			obstacle.x *= 8;
			obstacle.y += FlxG.random.float(-230, 245);

			obstacle.velocity.add(-400, -200);
			obstacle.acceleration.add(-800, FlxG.random.float(75, 135));

			FlxTween.tween(obstacle, {alpha: 0}, 1, {
				startDelay: FlxG.random.float(1, 2),
				onUpdate: function(twn)
				{
					if (obstacle.overlaps(player))
					{
						obstacles.members.remove(obstacle);
						obstacle.destroy();
						obstacle = null;

						trace('U GOT HIT');
						twn.cancel();
					}

					if (obstacle == null)
					{
						twn.cancel();
					}
				},
				onComplete: function(twn)
				{
					obstacles.members.remove(obstacle);
					obstacle.destroy();
					obstacle = null;
				},
				ease: FlxEase.sineInOut
			});

			obstacles.add(obstacle);
		}, 0);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		for (obst in obstacles.members)
		{
			if (obst == null)
			{
				obstacles.members.remove(obst);
				continue;
			}

			obst.acceleration.y += FlxG.random.float(2, 10) * 3;
		}

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
