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
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import org.apache.flex.core.IBead;
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.core.ValuesManager;
	import org.apache.flex.html.staticControls.Container;
	import org.apache.flex.html.staticControls.ContainerContentArea;
	
	public class ContainerView implements IBeadView
	{
		public function ContainerView()
		{
		}
		
		protected var actualParent:DisplayObjectContainer;
				
		private var _strand:IStrand;
		
		public function set strand(value:IStrand):void
		{
			_strand = value;
			
			var backgroundColor:Object = ValuesManager.valuesImpl.getValue(value, "background-color");
			var backgroundImage:Object = ValuesManager.valuesImpl.getValue(value, "background-image");
			if (backgroundColor != null || backgroundImage != null)
			{
				if (value.getBeadByType(IBackgroundBead) == null)
					value.addBead(new (ValuesManager.valuesImpl.getValue(value, "iBackgroundBead")) as IBead);					
			}
			
			var borderStyle:String;
			var borderStyles:Object = ValuesManager.valuesImpl.getValue(value, "border");
			if (borderStyles is Array)
			{
				borderStyle = borderStyles[1];
			}
			if (borderStyle == null)
			{
				borderStyle = ValuesManager.valuesImpl.getValue(value, "border-style") as String;
			}
			if (borderStyle != null && borderStyle != "none")
			{
				if (value.getBeadByType(IBorderBead) == null)
					value.addBead(new (ValuesManager.valuesImpl.getValue(value, "iBorderBead")) as IBead);	
			}
			
			var paddingLeft:Object;
			var paddingTop:Object;
			var padding:Object = ValuesManager.valuesImpl.getValue(value, "padding");
			if (padding is Array)
			{
				if (padding.length == 1)
					paddingLeft = paddingTop = padding[0];
				else if (padding.length <= 3)
				{
					paddingLeft = padding[1];
					paddingTop = padding[0];
				}
				else if (padding.length == 4)
				{
					paddingLeft = padding[3];
					paddingTop = padding[0];					
				}
			}
			else if (padding == null)
			{
				paddingLeft = ValuesManager.valuesImpl.getValue(value, "padding-left");
				paddingTop = ValuesManager.valuesImpl.getValue(value, "padding-top");
			}
			else
			{
				paddingLeft = paddingTop = padding;
			}
			var pl:Number = Number(paddingLeft);
			var pt:Number = Number(paddingTop);
			if ((!isNaN(pl) && pl > 0 ||
				!isNaN(pt) && pt > 0))
			{
				actualParent = new ContainerContentArea();
				DisplayObjectContainer(value).addChild(actualParent);
				Container(value).setActualParent(actualParent);
				actualParent.x = pl;
				actualParent.y = pt;
			}
			else
			{
				actualParent = value as DisplayObjectContainer;
			}
		}
		
	}
}