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



class Design_9_9_upgradebuttons extends ActorScript
{
	public var _cost:Float;
	public var _level:Float;
	public var _costadditive:Float;
	public var _costmultiplicative:Float;
	public var _costexponential:Float;
	public var _bonuscps:Float;
	public var _bonusmulti:Float;
	public var _defaultmulti:Float;
	
	/* =========================== On Actor =========================== */
	public function _event_buttonclicked(mouseState:Int):Void
	{
		if(wrapper.enabled && 3 == mouseState)
		{
			if(((Engine.engine.getGameAttribute("Cash") : Float) >= _cost))
			{
				_level = (_level + 1);
				_bonusmulti = Math.pow(_defaultmulti, _level);
				Engine.engine.setGameAttribute("Cash", ((Engine.engine.getGameAttribute("Cash") : Float) - _cost));
				_cost = Math.pow(((_cost + _costadditive) * _costmultiplicative), _costexponential);
				Engine.engine.setGameAttribute("cashpersec", (((Engine.engine.getGameAttribute("cashpersec") : Float) + _bonuscps) * _bonusmulti));
			}
		}
	}
	/* ======================== When Updating ========================= */
	public function _event_Updating(elapsedTime:Float):Void
	{
		if(wrapper.enabled && true)
		{
			if((_cost > (Engine.engine.getGameAttribute("Cash") : Float)))
			{
				actor.setAnimation("expens");
			}
			else
			{
				actor.setAnimation("afford");
			}
		}
	}
	/* ========================= When Drawing ========================= */
	public function _event_drawcost(g:G, x:Float, y:Float):Void
	{
		if(wrapper.enabled && true)
		{
			g.drawString("" + Math.floor(_cost), 65, 56);
			g.drawString("" + _level, 9, 39);
		}
	}
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("cost", "_cost");
		_cost = 0.0;
		nameMap.set("level", "_level");
		_level = 0.0;
		nameMap.set("cost additive", "_costadditive");
		_costadditive = 0.0;
		nameMap.set("cost multiplicative", "_costmultiplicative");
		_costmultiplicative = 1.0;
		nameMap.set("cost exponential", "_costexponential");
		_costexponential = 1.0;
		nameMap.set("bonus cps", "_bonuscps");
		_bonuscps = 0.0;
		nameMap.set("bonus multi", "_bonusmulti");
		_bonusmulti = 1.0;
		nameMap.set("default multi", "_defaultmulti");
		_defaultmulti = 1.0;
		
	}
	
	override public function init()
	{
		
		
		addListener(actor.whenMousedOver, _event_buttonclicked);
		addListener(actor.whenUpdated, _event_Updating);
		addListener(actor.whenDrawing, _event_drawcost);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}