import flixel.FlxG;
import flixel.FlxSprite;

class Item extends FlxSprite
{
	public static final ITEM_MAX:Int = 4;

	override public function new()
	{
		super();

		final item = FlxG.random.int(1, ITEM_MAX);
		loadGraphic('assets/images/items_$item.png');
	}
}
