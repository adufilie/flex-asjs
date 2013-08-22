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
package org.apache.flex.html.staticControls.beads
{
	import flash.display.DisplayObject;
	
	import org.apache.flex.core.IBeadLayout;
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.IScrollBarModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.Strand;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.core.ValuesManager;
	import org.apache.flex.html.staticControls.Button;
	import org.apache.flex.html.staticControls.beads.controllers.ButtonAutoRepeatController;

	public class ScrollBarView extends Strand implements IBeadView, IStrand, IScrollBarView
	{
		public function ScrollBarView()
		{
		}
		
		public function get scrollBarModel():IScrollBarModel
		{
			return sbModel;
		}
		
		private var sbModel:IScrollBarModel;
		
		private var _strand:IStrand;
		
		public function get strand():IStrand
		{
			return _strand;
		}
		public function set strand(value:IStrand):void
		{
			_strand = value;
			sbModel = value.getBeadByType(IScrollBarModel) as IScrollBarModel;
            
            // TODO: (aharui) put in values impl
			_increment = new Button();
			Button(_increment).addBead(new DownArrowButtonView());
            Button(_increment).addBead(new ButtonAutoRepeatController());
			_decrement = new Button();
			Button(_decrement).addBead(new UpArrowButtonView());
            Button(_decrement).addBead(new ButtonAutoRepeatController());
			_track = new Button();				
			Button(_track).addBead(new VScrollBarTrackView());
			_thumb = new Button();				
			Button(_thumb).addBead(new VScrollBarThumbView());
            
            UIBase(value).addChild(_decrement);
            UIBase(value).addChild(_increment);
            UIBase(value).addChild(_track);
            UIBase(value).addChild(_thumb);
            
            if( getBeadByType(IBeadLayout) == null ) {
                var layout:IBeadLayout = new (ValuesManager.valuesImpl.getValue(_strand, "iBeadLayout")) as IBeadLayout;
                addBead(layout);
            }
            
		}
						
		private var _decrement:DisplayObject;
		private var _increment:DisplayObject;
		private var _track:DisplayObject;
		private var _thumb:DisplayObject;
		
		public function get decrement():DisplayObject
		{
			return _decrement;
		}
		public function get increment():DisplayObject
		{
			return _increment;
		}
		public function get track():DisplayObject
		{
			return _track;
		}
		public function get thumb():DisplayObject
		{
			return _thumb;
		}
		
	}
}