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
package org.apache.flex.core
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    
    import org.apache.flex.utils.MXMLDataInterpreter;
    
    //--------------------------------------
    //  Events
    //--------------------------------------
    
    /**
     *  Dispatched at startup.
     */
    [Event(name="initialize", type="flash.events.Event")]
    
    public class Application extends Sprite implements IStrand
    {
        public function Application()
        {
            super();
			if (stage)
			{
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			
            loaderInfo.addEventListener(Event.INIT, initHandler);
        }

        private function initHandler(event:Event):void
        {
	        MXMLDataInterpreter.generateMXMLProperties(this, MXMLProperties);

            ValuesManager.valuesImpl = valuesImpl;

            dispatchEvent(new Event("initialize"));

    	    initialView.addToParent(this);
    	    initialView.initUI(model);
    	    dispatchEvent(new Event("viewChanged"));
        }

        public var valuesImpl:IValuesImpl;

        public var initialView:ViewBase;

        public var model:Object;

        public var controller:Object;

        public function get MXMLDescriptor():Array
        {
            return null;
        }

    	public function get MXMLProperties():Array
        {
            return null;
        }
        
        // beads declared in MXML are added to the strand.
        // from AS, just call addBead()
        public var beads:Array;
        
        private var _beads:Vector.<IBead>;
        public function addBead(bead:IBead):void
        {
            if (!_beads)
                _beads = new Vector.<IBead>;
            _beads.push(bead);
            bead.strand = this;
        }
        
        public function getBeadByType(classOrInterface:Class):IBead
        {
            for each (var bead:IBead in _beads)
            {
                if (bead is classOrInterface)
                    return bead;
            }
            return null;
        }
        
        public function removeBead(value:IBead):IBead	
        {
            var n:int = _beads.length;
            for (var i:int = 0; i < n; i++)
            {
                var bead:IBead = _beads[i];
                if (bead == value)
                {
                    _beads.splice(i, 1);
                    return bead;
                }
            }
            return null;
        }
    }
}