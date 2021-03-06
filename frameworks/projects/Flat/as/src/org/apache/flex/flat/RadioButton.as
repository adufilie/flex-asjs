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
package org.apache.flex.flat
{
    COMPILE::AS3
    {
        import org.apache.flex.html.RadioButton;            
    }
    COMPILE::JS
    {
        import org.apache.flex.core.UIBase;
        import org.apache.flex.core.WrappedHTMLElement;
    }
    
    /**
     *  The RadioButton class provides a FlatUI-like appearance for
     *  a RadioButton.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */
    COMPILE::AS3
	public class RadioButton extends org.apache.flex.html.RadioButton
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function RadioButton()
		{
			super();
		}
	}
    
    COMPILE::JS
    public class RadioButton extends UIBase
    {
        /**
         * Provides unique name
         */
        public static var radioCounter:int = 0;
        
        private var input:HTMLInputElement;
        private var radio:HTMLSpanElement;
        private var textNode:Text;
        private var labelFor:HTMLLabelElement;
        
        /**
         * @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
         * @flexjsignorecoercion HTMLInputElement
         * @flexjsignorecoercion HTMLSpanElement
         * @flexjsignorecoercion HTMLLabelElement
         */
        override protected function createElement():WrappedHTMLElement
        {
            // hide this eleement
            input = document.createElement('input') as HTMLInputElement;
            input.type = 'radio';
            input.className = 'radio-input';
            input.id = '_radio_' + radioCounter++;
            input.addEventListener('change', selectionChangeHandler, false);
            
            radio = document.createElement('span') as HTMLSpanElement;
            radio.className = 'radio-icon';
            radio.addEventListener('mouseover', mouseOverHandler, false);
            radio.addEventListener('mouseout', mouseOutHandler, false);
            
            textNode = document.createTextNode('radio button') as Text;
            
            labelFor = document.createElement('label') as HTMLLabelElement;
            labelFor.appendChild(input);
            labelFor.appendChild(radio);
            labelFor.appendChild(textNode);
            labelFor.style.position = 'relative';
            
            element = labelFor as WrappedHTMLElement;
            element.className = 'RadioButton';
            typeNames = 'RadioButton';
            
            positioner = element;
            positioner.style.position = 'relative';
            (input as WrappedHTMLElement).flexjs_wrapper = this;
            (radio as WrappedHTMLElement).flexjs_wrapper = this;
            element.flexjs_wrapper = this;
            (textNode as WrappedHTMLElement).flexjs_wrapper = this;
            
            return element;
        }
        
        
        /**
         * @param e The event object.
         */
        private function mouseOverHandler(e:Event):void
        {
            radio.className = 'radio-icon-hover';
        }
        
        
        /**
         * @param e The event object.
         */
        private function mouseOutHandler(e:Event):void
        {
            if (input.checked)
                radio.className = 'radio-icon-checked';
            else
                radio.className = 'radio-icon';
        }
        
        
        /**
         * @param e The event object.
         */
        private function selectionChangeHandler(e:Event):void 
        {
            // this should reset the icons in the non-selected radio
            selectedValue = value;
        }
        
        
        override public function set id(value:String):void
        {
            super.id = value;
            labelFor.id = value;
            input.id = value;
        }
        
        /**
         * @flexjsignorecoercion String
         */
        public function get groupName():String
        {
            return input.name as String;
        }
        
        public function set groupName(value:String):void
        {
            input.name = value;
        }
        
        public function get text():String
        {
            return textNode.nodeValue;
        }
        
        public function set text(value:String):void
        {
            textNode.nodeValue = value;
        }
        
        public function get selected():Boolean
        {
            return input.checked;
        }
        
        public function set selected(value:Boolean):void
        {
            input.checked = value;
            if (input.checked)
                radio.className = 'radio-icon-checked';
            else
                radio.className = 'radio-icon';
        }
        
        public function get value():String
        {
            return input.value;
        }
        
        public function set value(value:String):void
        {
            input.value = value;
        }
        
        /**
         * @flexjsignorecoercion Array 
         * @flexjsignorecoercion String
         */
        public function get selectedValue():Object
        {
            var buttons:Array;
            var groupName:String;
            var i:int;
            var n:int;
            
            groupName = input.name as String;
            buttons = document.getElementsByName(groupName) as Array;
            n = buttons.length;
            
            for (i = 0; i < n; i++) {
                if (buttons[i].checked) {
                    return buttons[i].value;
                }
            }
            return null;            
        }
        
        /**
         * @flexjsignorecoercion Array
         * @flexjsignorecoercion String
         */
        public function set selectedValue(value:Object):void
        {
            var buttons:Array;
            var groupName:String;
            var i:int;
            var n:int;
            
            groupName = input.name as String;
            buttons = document.getElementsByName(groupName) as Array;
            n = buttons.length;
            for (i = 0; i < n; i++) {
                if (buttons[i].value === value) {
                    buttons[i].checked = true;
                    buttons[i].flexjs_wrapper.selected = true;
                }
                else
                    buttons[i].flexjs_wrapper.selected = false;
            }
        }
    }    
}
