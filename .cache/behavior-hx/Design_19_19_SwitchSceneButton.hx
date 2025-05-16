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



class Design_19_19_SwitchSceneButton extends ActorScript
{
	public var _NormalAnimation:String;
	public var _PressedAnimation:String;
	public var _NextScene:Scene;
	public var _OutTime:Float;
	public var _InTime:Float;
	public var _TransitionStyle:String;
	public var _needscloseplayer:Bool;
	
	/* =========================== On Actor =========================== */
	public function _event_OnActor(mouseState:Int):Void
	{
		if(wrapper.enabled && 3 == mouseState)
		{
			actor.setAnimation(_PressedAnimation);
			if(_needscloseplayer)
			{
				Engine.engine.setGameAttribute("on journey", true);
				Engine.engine.setGameAttribute("mouse_x", getMousePressedX());
			}
			else
			{
				_customEvent_SwitchScene();
				Engine.engine.setGameAttribute("player at portal", false);
			}
		}
	}
	/* ======================== When Updating ========================= */
	public function _event_Updating(elapsedTime:Float):Void
	{
		if(wrapper.enabled && true)
		{
			if((Engine.engine.getGameAttribute("player at portal") : Bool))
			{
				_customEvent_SwitchScene();
				Engine.engine.setGameAttribute("player at portal", false);
			}
			if(!((Engine.engine.getGameAttribute("on journey") : Bool)))
			{
				actor.setAnimation(_NormalAnimation);
			}
		}
	}
	/* ========================= Custom Event ========================= */
	public function _customEvent_SwitchScene():Void
	{
		if(((hasValue(_NextScene)) && !(isTransitioning())))
		{
			if((_TransitionStyle == "Fade"))
			{
				switchScene(_NextScene.getID(), createFadeOut(_OutTime, Utils.getColorRGB(0, 0, 0)), createFadeIn(_InTime, Utils.getColorRGB(0, 0, 0)));
			}
			else if((_TransitionStyle == "Blinds"))
			{
				switchScene(_NextScene.getID(), createBlindsOut(_OutTime, Utils.getColorRGB(0, 0, 0)), createBlindsIn(_InTime, Utils.getColorRGB(0, 0, 0)));
			}
			else if((_TransitionStyle == "Bubbles"))
			{
				switchScene(_NextScene.getID(), createBubblesOut(_OutTime, Utils.getColorRGB(0, 0, 0)), createBubblesIn(_InTime, Utils.getColorRGB(0, 0, 0)));
			}
			else if((_TransitionStyle == "Spotlight"))
			{
				switchScene(_NextScene.getID(), createCircleOut(_OutTime, Utils.getColorRGB(0, 0, 0)), createCircleIn(_InTime, Utils.getColorRGB(0, 0, 0)));
			}
			else if((_TransitionStyle == "Blur"))
			{
				switchScene(_NextScene.getID(), createPixelizeOut(_OutTime, Utils.getColorRGB(0, 0, 0)), createPixelizeIn(_InTime, Utils.getColorRGB(0, 0, 0)));
			}
			else if((_TransitionStyle == "Box"))
			{
				switchScene(_NextScene.getID(), createRectangleOut(_OutTime, Utils.getColorRGB(0, 0, 0)), createRectangleIn(_InTime, Utils.getColorRGB(0, 0, 0)));
			}
			else if((_TransitionStyle == "Crossfade"))
			{
				switchScene(_NextScene.getID(), null, createCrossfadeTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Up"))
			{
				switchScene(_NextScene.getID(), null, createSlideUpTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Down"))
			{
				switchScene(_NextScene.getID(), null, createSlideDownTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Left"))
			{
				switchScene(_NextScene.getID(), null, createSlideLeftTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Right"))
			{
				switchScene(_NextScene.getID(), null, createSlideRightTransition(_OutTime));
			}
		}
		Engine.engine.setGameAttribute("on journey", false);
		Engine.engine.setGameAttribute("mouse_x", 0);
	}
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Normal Animation", "_NormalAnimation");
		_NormalAnimation = "";
		nameMap.set("Pressed Animation", "_PressedAnimation");
		_PressedAnimation = "";
		nameMap.set("Next Scene", "_NextScene");
		nameMap.set("Out Time", "_OutTime");
		_OutTime = 0.5;
		nameMap.set("In Time", "_InTime");
		_InTime = 0.5;
		nameMap.set("Transition Style", "_TransitionStyle");
		_TransitionStyle = "";
		nameMap.set("needs close player", "_needscloseplayer");
		_needscloseplayer = false;
		
	}
	
	override public function init()
	{
		
		
		addListener(actor.whenMousedOver, _event_OnActor);
		addListener(actor.whenUpdated, _event_Updating);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}