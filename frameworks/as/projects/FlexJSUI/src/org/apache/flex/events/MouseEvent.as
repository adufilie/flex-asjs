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
package org.apache.flex.events
{
	import flash.events.MouseEvent;
	
	/**
	 *  Mouse events
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
	 */
	public class MouseEvent extends flash.events.MouseEvent
	{
		public static const MOUSE_DOWN:String = "mouseDown_";
		public static const MOUSE_UP:String = "mouseUp_";
		public static const MOUSE_OUT:String = "mouseOut_";
		public static const MOUSE_OVER:String = "mouseOver_";
		public static const ROLL_OVER:String = "rollOver_";
		public static const ROLL_OUT:String = "rollOut_";

        /**
         *  Constructor.
         *  
         *  @param type The name of the event.
         *  @param bubbles Whether the event bubbles.
         *  @param cancelable Whether the event can be canceled.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function MouseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}