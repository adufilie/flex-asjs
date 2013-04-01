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
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import org.apache.flex.core.IInitModel;
	import org.apache.flex.core.IInitSkin;
	import org.apache.flex.core.ISelectionModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.ValuesManager;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;

	public class DropDownListBead implements IDropDownListBead
	{
		public function DropDownListBead()
		{
            upSprite = new Sprite();
            downSprite = new Sprite();
            overSprite = new Sprite();
			upTextField = new TextField();
			downTextField = new TextField();
			overTextField = new TextField();
            upSprite.addChild(upTextField);
            overSprite.addChild(overTextField);
            downSprite.addChild(downTextField);
			upTextField.border = true;
			downTextField.border = true;
			overTextField.border = true;
			upTextField.background = true;
			downTextField.background = true;
			overTextField.background = true;
			upTextField.borderColor = 0;
			downTextField.borderColor = 0;
			overTextField.borderColor = 0;
			upTextField.backgroundColor = 0xCCCCCC;
			downTextField.backgroundColor = 0x808080;
			overTextField.backgroundColor = 0xFFCCCC;
			upTextField.selectable = false;
			upTextField.type = TextFieldType.DYNAMIC;
			downTextField.selectable = false;
			downTextField.type = TextFieldType.DYNAMIC;
			overTextField.selectable = false;
			overTextField.type = TextFieldType.DYNAMIC;
			//upTextField.autoSize = "left";
			//downTextField.autoSize = "left";
			//overTextField.autoSize = "left";
            
            upArrows = new Shape();
            overArrows = new Shape();
            downArrows = new Shape();
            upSprite.addChild(upArrows);
			overSprite.addChild(overArrows);
			downSprite.addChild(downArrows);
            drawArrows(upArrows, 0xCCCCCC);
            drawArrows(overArrows, 0xFFCCCC);
            drawArrows(downArrows, 0x808080);

		}

        private function drawArrows(shape:Shape, color:uint):void
        {
            var g:Graphics = shape.graphics;
            g.beginFill(color);
            g.drawRect(0, 0, 16, 16);
            g.endFill();
            g.beginFill(0);
            g.moveTo(8, 2);
            g.lineTo(12, 6);
            g.lineTo(4, 6);
            g.lineTo(8, 2);
            g.endFill();
            g.beginFill(0);
            g.moveTo(8, 14);
            g.lineTo(12, 10);
            g.lineTo(4, 10);
            g.lineTo(8, 14);
            g.endFill();
            g.lineStyle(1, 0);
            g.drawRect(0, 0, 16, 16);
        }
        
		private var selectionModel:ISelectionModel;
		
		private var _strand:IStrand;
		
		private var shape:Shape;
		
		public function set strand(value:IStrand):void
		{
			_strand = value;
            selectionModel = value.getBeadByType(ISelectionModel) as ISelectionModel;
            selectionModel.addEventListener("selectedIndexChanged", selectionChangeHandler);
			shape = new Shape();
			shape.graphics.beginFill(0xCCCCCC);
			shape.graphics.drawRect(0, 0, 10, 10);
			shape.graphics.endFill();
			SimpleButton(value).upState = upSprite;
			SimpleButton(value).downState = downSprite;
			SimpleButton(value).overState = overSprite;
			SimpleButton(value).hitTestState = shape;
			if (selectionModel.selectedIndex !== -1)
				text = selectionModel.selectedItem.toString();
            IEventDispatcher(value).addEventListener("heightChanged", changeHandler);
            IEventDispatcher(value).addEventListener("widthChanged", changeHandler);
			changeHandler(null);
		}
		
		private function selectionChangeHandler(event:Event):void
		{
			text = selectionModel.selectedItem.toString();
		}
		
        private function changeHandler(event:Event):void
        {
            var ww:Number = DisplayObject(_strand).width;
            var hh:Number = DisplayObject(_strand).height;
            upArrows.x = ww - upArrows.width;            
            overArrows.x = ww - overArrows.width;            
            downArrows.x = ww - downArrows.width;
			upTextField.width = upArrows.x;
			downTextField.width = downArrows.x;
			overTextField.width = overArrows.x;
			upTextField.height = hh;
			downTextField.height = hh;
			overTextField.height = hh;
			shape.graphics.clear();
			shape.graphics.beginFill(0xCCCCCC);
			shape.graphics.drawRect(0, 0, ww, hh);
			shape.graphics.endFill();
        }
        
		private var upTextField:TextField;
		private var downTextField:TextField;
		private var overTextField:TextField;
        private var upSprite:Sprite;
        private var downSprite:Sprite;
        private var overSprite:Sprite;
        private var upArrows:Shape;
        private var downArrows:Shape;
        private var overArrows:Shape;
		
		public function get text():String
		{
			return upTextField.text;
		}
        
		public function set text(value:String):void
		{
            var ww:Number = DisplayObject(_strand).width;
            var hh:Number = DisplayObject(_strand).height;
			upTextField.text = value;
			downTextField.text = value;
			overTextField.text = value;
			
		}
		
        private var _popUp:IStrand;
        public function get popUp():IStrand
        {
            return _popUp;
        }
        
        private var _popUpVisible:Boolean;
        
        public function get popUpVisible():Boolean
        {
            return _popUpVisible;
        }
        
        public function set popUpVisible(value:Boolean):void
        {
            if (value != _popUpVisible)
            {
                _popUpVisible = value;
                if (value)
                {
                    if (!_popUp)
                    {
                        var popUpClass:Class = ValuesManager.valuesImpl.getValue(_strand, "iPopUp") as Class;
                        _popUp = new popUpClass() as IStrand;
                    }
					var root:Object = DisplayObject(_strand).root;
					var host:DisplayObjectContainer = DisplayObject(_strand).parent;
					while (host.parent != root)
						host = host.parent;
                    host.addChild(_popUp as DisplayObject);
					if (_popUp is IInitModel)
						IInitModel(_popUp).initModel();
					if (_popUp is IInitSkin)
						IInitSkin(_popUp).initSkin();
                }
                else
                {
                    DisplayObject(_popUp).parent.removeChild(_popUp as DisplayObject);                    
                }
            }
        }
        
	}
}