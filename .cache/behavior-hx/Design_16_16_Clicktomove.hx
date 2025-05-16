package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.filters.BitmapFilter;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_16_16_Clicktomove extends ActorScript
{
	public var _speed:Float;
	
	/* ======================== When Updating ========================= */
	public function _event_movingandcameraCopy(elapsedTime:Float):Void
	{
		if(wrapper.enabled && true)
		{
			if((Engine.engine.getGameAttribute("on journey") : Bool))
			{
				actor.setAnimation("Walk");
				if((Math.abs((actor.getXCenter() - (Engine.engine.getGameAttribute("mouse_x") : Float))) > 1))
				{
					if((actor.getXCenter() > (Engine.engine.getGameAttribute("mouse_x") : Float)))
					{
						actor.growTo(-100/100, 100/100, 0.2, Easing.quadOut);
						actor.setXCenter((actor.getXCenter() - _speed));
					}
					else if((actor.getXCenter() < (Engine.engine.getGameAttribute("mouse_x") : Float)))
					{
						actor.growTo(100/100, 100/100, 0.2, Easing.quadOut);
						actor.setXCenter((actor.getXCenter() + _speed));
					}
				}
				else
				{
					actor.setXCenter((Engine.engine.getGameAttribute("mouse_x") : Float));
					Engine.engine.setGameAttribute("on journey", false);
					actor.setAnimation("Idle");
				}
				engine.cameraFollow(actor);
			}
		}
	}
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("speed", "_speed");
		_speed = 1.0;
		
	}
	
	override public function init()
	{
		/* ======================== When Creating ========================= */
		engine.cameraFollow(actor);
		
		addListener(actor.whenUpdated, _event_movingandcameraCopy);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}