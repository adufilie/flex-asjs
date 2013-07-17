////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.html.staticControls.beads.controllers
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.apache.flex.core.IBead;
	import org.apache.flex.core.IBeadController;
	import org.apache.flex.core.ISliderModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.html.staticControls.beads.ISliderView;
	
	public class SliderMouseController implements IBead, IBeadController
	{
		public function SliderMouseController()
		{
			trace("SliderMouseController");
		}
		
		private var sliderModel:ISliderModel;
		
		private var _strand:IStrand;
		public function set strand(value:IStrand):void
		{
			_strand = value;
			
			sliderModel = value.getBeadByType(ISliderModel) as ISliderModel;
			
			var sliderView:ISliderView = value.getBeadByType(ISliderView) as ISliderView;
			sliderView.thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDownHandler);
			
			// add handler to detect click on track
			sliderView.track.addEventListener(MouseEvent.CLICK, trackClickHandler, false, 99999);
		}
		
		protected function snap(value:Number):Number
		{
			var si:Number = sliderModel.snapInterval;
			var n:Number = Math.round((value - sliderModel.minimum) / si) * si + sliderModel.minimum;
			if (value > 0)
			{
				if (value - n < n + si - value)
					return n;
				return n + si;
				
			}
			if (value - n > n + si - value)
				return n + si;
			return n;
		}
		
		private function thumbDownHandler( event:MouseEvent ) : void
		{
			UIBase(_strand).stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMoveHandler);
			UIBase(_strand).stage.addEventListener(MouseEvent.MOUSE_UP, thumbUpHandler);
			
			var sliderView:ISliderView = _strand.getBeadByType(ISliderView) as ISliderView;
			
			origin = new Point(event.stageX, event.stageY);
			thumb = new Point(sliderView.thumb.x,sliderView.thumb.y);
		}
		
		private function thumbUpHandler( event:MouseEvent ) : void
		{
			UIBase(_strand).stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMoveHandler);
			UIBase(_strand).stage.removeEventListener(MouseEvent.MOUSE_UP, thumbUpHandler);
		}
		
		private var origin:Point;
		private var thumb:Point;
		
		private function thumbMoveHandler( event:MouseEvent ) : void
		{
			var sliderView:ISliderView = _strand.getBeadByType(ISliderView) as ISliderView;
			
			var deltaX:Number = event.stageX - origin.x;
			var thumbW:Number = sliderView.thumb.width/2;
			var newX:Number = thumb.x + deltaX;
			
			var p:Number = newX/UIBase(_strand).width;
			var n:Number = p*(sliderModel.maximum - sliderModel.minimum) + sliderModel.minimum;
			n = snap(n);
			if( n < sliderModel.minimum ) n = sliderModel.minimum;
			else if( n > sliderModel.maximum ) n = sliderModel.maximum;
			
			p = (n-sliderModel.minimum)/(sliderModel.maximum-sliderModel.minimum);
			newX = p*(UIBase(_strand).width);
			
			sliderView.thumb.x = newX - sliderView.thumb.width/2;
			
			sliderModel.value = n;
		}
		
		private function trackClickHandler( event:MouseEvent ) : void
		{
			event.stopImmediatePropagation();
			
			var sliderView:ISliderView = _strand.getBeadByType(ISliderView) as ISliderView;
			
			var xloc:Number = event.localX;
			var p:Number = xloc/UIBase(_strand).width;
			var n:Number = p*(sliderModel.maximum - sliderModel.minimum) + sliderModel.minimum;
			n = snap(n);
			if( n < sliderModel.minimum ) n = sliderModel.minimum;
			else if( n > sliderModel.maximum ) n = sliderModel.maximum;
			
			p = (n-sliderModel.minimum)/(sliderModel.maximum-sliderModel.minimum);
			xloc = p*(UIBase(_strand).width);
			sliderView.thumb.x = xloc - sliderView.thumb.width/2;
			
			sliderModel.value = n;
		}
	}
}