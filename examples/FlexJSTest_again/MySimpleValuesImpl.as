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
package 
{
	import flash.events.IEventDispatcher;
	
	import org.apache.flex.core.SimpleValuesImpl;
	import org.apache.flex.html.staticControls.beads.CheckBoxBead;
	import org.apache.flex.html.staticControls.beads.RadioButtonBead;
	import org.apache.flex.html.staticControls.beads.TextButtonBead;
	import org.apache.flex.html.staticControls.beads.TextFieldBead;
	import org.apache.flex.html.staticControls.beads.TextInputBead;
	import org.apache.flex.html.staticControls.beads.TextInputWithBorderBead;
	import org.apache.flex.html.staticControls.beads.models.ArraySelectionModel;
    import org.apache.flex.html.staticControls.beads.models.TextModel;
	import org.apache.flex.html.staticControls.beads.models.ToggleButtonModel;
	import org.apache.flex.html.staticControls.beads.models.ValueToggleButtonModel;
	
	public class MySimpleValuesImpl extends SimpleValuesImpl
	{
		public function MySimpleValuesImpl()
		{
			values = { 
                ISelectionModel: ArraySelectionModel,
				ITextButtonBead: TextButtonBead,
				ITextBead: TextFieldBead,
				ITextModel: TextModel,
				ITextInputBead: TextInputWithBorderBead,
				IToggleButtonModel: ToggleButtonModel,
				ICheckBoxBead:  CheckBoxBead,
				IValueToggleButtonModel: ValueToggleButtonModel,
				IRadioButtonBead: RadioButtonBead				
			}
		}
		
		
	}
}