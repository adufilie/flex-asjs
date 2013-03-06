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
package org.apache.flex.html.staticControls.beads.layouts
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	
	import org.apache.flex.core.IBead;
	import org.apache.flex.core.IBorderModel;
	import org.apache.flex.core.IScrollBarModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.html.staticControls.beads.IListBead;
	import org.apache.flex.html.staticControls.supportClasses.Border;
	import org.apache.flex.html.staticControls.supportClasses.ScrollBar;

	public class NonVirtualVerticalScrollingLayout implements IBead
	{
		public function NonVirtualVerticalScrollingLayout()
		{
		}
		
		public var dataGroup:DisplayObjectContainer;
        
        private var border:Border;		
        private var borderModel:IBorderModel
        private var vScrollBar:ScrollBar;		
		private var listBead:IListBead;

		private var _strand:IStrand;
		
		public function set strand(value:IStrand):void
		{
			_strand = value;
			listBead = value as IListBead;
			dataGroup = listBead.dataGroup as DisplayObjectContainer;
            border = listBead.border;
            borderModel = border.model as IBorderModel;
			IEventDispatcher(listBead.strand).addEventListener("heightChanged", changeHandler);
			IEventDispatcher(listBead.strand).addEventListener("widthChanged", changeHandler);
			changeHandler(null);
		}
	
		private function changeHandler(event:Event):void
		{            
            var ww:Number = DisplayObject(listBead.strand).width;
            var hh:Number = DisplayObject(listBead.strand).height;
            border.width = ww;
            border.height = hh;
           
			dataGroup.width = ww - borderModel.offsets.left - borderModel.offsets.right;
			dataGroup.height = hh - borderModel.offsets.top - borderModel.offsets.bottom;
            dataGroup.x = borderModel.offsets.left;
            dataGroup.y = borderModel.offsets.top;
			
			var n:int = dataGroup.numChildren;
			var yy:Number = 0;
			for (var i:int = 0; i < n; i++)
			{
				var ir:DisplayObject = dataGroup.getChildAt(i);
				ir.y = yy;
				ir.width = dataGroup.width;
				yy += ir.height;			
			}
			if (yy > dataGroup.height)
			{
                vScrollBar = listBead.vScrollBar;
				dataGroup.width -= vScrollBar.width;
				IScrollBarModel(vScrollBar.model).maximum = yy;
				IScrollBarModel(vScrollBar.model).pageSize = dataGroup.height;
				IScrollBarModel(vScrollBar.model).pageStepSize = dataGroup.height;
				vScrollBar.visible = true;
				vScrollBar.height = dataGroup.height;
				vScrollBar.y = dataGroup.y;
				vScrollBar.x = dataGroup.width;
                var vpos:Number = IScrollBarModel(vScrollBar.model).value;
                dataGroup.scrollRect = new Rectangle(0, vpos, dataGroup.width, vpos + dataGroup.height);
                vScrollBar.addEventListener("scroll", scrollHandler);
			}
			else if (vScrollBar)
				vScrollBar.visible = false;
		}

        private function scrollHandler(event:Event):void
        {
            var vpos:Number = IScrollBarModel(vScrollBar.model).value;
            dataGroup.scrollRect = new Rectangle(0, vpos, dataGroup.width, vpos + dataGroup.height);
        }
	}
}