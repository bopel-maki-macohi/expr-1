import flixel.FlxG;
import flixel.FlxSprite;

class Obstacle extends FlxSprite
{
	public static final OBSTACLE_COUNT:Int = 4;

	override public function new()
	{
		super();

		final item = FlxG.random.int(1, OBSTACLE_COUNT);
		loadGraphic('assets/images/obstacles/obstacle_$item.png');
	}
}
