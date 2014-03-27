/**
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

goog.provide('org.apache.flex.html.NumericStepper');

goog.require('org.apache.flex.core.UIBase');
goog.require('org.apache.flex.html.Spinner');
goog.require('org.apache.flex.html.TextInput');
goog.require('org.apache.flex.html.beads.models.RangeModel');



/**
 * @constructor
 * @extends {org.apache.flex.core.UIBase}
 */
org.apache.flex.html.NumericStepper = function() {
  this.model =
      new org.apache.flex.html.beads.models.RangeModel();
  goog.base(this);
};
goog.inherits(org.apache.flex.html.NumericStepper,
    org.apache.flex.core.UIBase);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.apache.flex.html.NumericStepper.prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'NumericStepper',
                qName: 'org.apache.flex.html.NumericStepper' }] };


/**
 * @override
 */
org.apache.flex.html.NumericStepper.prototype.createElement =
    function() {
  this.element = document.createElement('div');
  this.positioner = this.element;

  this.input = new org.apache.flex.html.TextInput();
  this.addElement(this.input);
  this.input.positioner.style.display = 'inline-block';

  this.spinner = new org.apache.flex.html.Spinner();
  this.addElement(this.spinner);
  this.spinner.positioner.style.display = 'inline-block';
  goog.events.listen(this.spinner, 'valueChanged',
      goog.bind(this.spinnerChange, this));

  this.element.flexjs_wrapper = this;
  this.set_className('NumericStepper');

  this.input.set_text(String(this.spinner.get_value()));

  return this.element;
};


/**
 * @param {Object} event The input event.
 */
org.apache.flex.html.NumericStepper.prototype.spinnerChange =
    function(event)
    {
  var newValue = this.spinner.get_value();
  this.set_value(newValue);
  this.input.set_text(String(this.spinner.get_value()));
  this.dispatchEvent(new org.apache.flex.events.Event('valueChanged'));
};


/**
 * @expose
 * @return {Number} The current minimum value.
 */
org.apache.flex.html.NumericStepper.prototype.get_minimum =
    function() {
  return this.model.get_minimum();
};


/**
 * @expose
 * @param {Number} value The new minimum value.
 */
org.apache.flex.html.NumericStepper.prototype.set_minimum =
    function(value) {
  this.model.set_minimum(value);
};


/**
 * @expose
 * @return {Number} The current maximum value.
 */
org.apache.flex.html.NumericStepper.prototype.get_maximum =
    function() {
  return this.model.get_maximum();
};


/**
 * @expose
 * @param {Number} value The new maximum value.
 */
org.apache.flex.html.NumericStepper.prototype.set_maximum =
    function(value) {
  this.model.set_maximum(value);
};


/**
 * @expose
 * @return {Number} The current value.
 */
org.apache.flex.html.NumericStepper.prototype.get_value =
    function() {
  return this.model.get_value();
};


/**
 * @expose
 * @param {Number} newValue The new value.
 */
org.apache.flex.html.NumericStepper.prototype.set_value =
    function(newValue) {
  this.model.set_value(newValue);
};


/**
 * @expose
 * @return {Number} The current snapInterval value.
 */
org.apache.flex.html.NumericStepper.prototype.get_snapInterval =
    function() {
  return this.model.get_snapInterval();
};


/**
 * @expose
 * @param {Number} value The new snapInterval value.
 */
org.apache.flex.html.NumericStepper.prototype.set_snapInterval =
    function(value) {
  this.model.set_snapInterval(value);
};


/**
 * @expose
 * @return {Number} The current stepSize value.
 */
org.apache.flex.html.NumericStepper.prototype.get_stepSize =
    function() {
  return this.model.get_stepSize();
};


/**
 * @expose
 * @param {Number} value The new stepSize value.
 */
org.apache.flex.html.NumericStepper.prototype.set_stepSize =
    function(value) {
  this.model.set_stepSize(value);
};
