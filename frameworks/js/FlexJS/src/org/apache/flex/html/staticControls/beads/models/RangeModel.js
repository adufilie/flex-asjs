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

goog.provide('org.apache.flex.html.staticControls.beads.models.RangeModel');

goog.require('org.apache.flex.events.EventDispatcher');

/**
 * @constructor
 * @extends {org.apache.flex.events.EventDispatcher}
 */
org.apache.flex.html.staticControls.beads.models.RangeModel = function() {
  goog.base(this);

  this.minimum_ = 0;
  this.maximum_ = 100;
  this.value_ = 0;
  this.snapInterval_ = 1;
  this.stepSize_ = 1;
};
goog.inherits(org.apache.flex.html.staticControls.beads.models.RangeModel,
    org.apache.flex.events.EventDispatcher);



/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @param {Object} value The strand.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
set_strand = function(value) {
  this.strand_ = value;
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @return {Number} The current minimum value.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
get_minimum = function() {
  return this.minimum_;
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @param {Number} value The new minimum value.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
set_minimum = function(value) {
  if (this.minimum_ != value) {
      this.minimum_ = value;
      this.dispatchEvent('minimumChange');
  }
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @return {Number} The current maximu value.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
get_maximum = function() {
  return this.maximum_;
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @param {Number} value The new maximum value.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
set_maximum = function(value) {
  if (this.maximum_ != value) {
      this.maximum_ = value;
      this.dispatchEvent('maximumChange');
  }
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @return {Number} The current value.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
get_value = function() {
  return this.value_;
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @param {Number} newValue The new value.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
set_value = function(newValue) {
  if (this.value_ != newValue) {

    // value must lie within the boundaries of minimum & maximum
    // and be on a step interval, so the value is adjusted to 
    // what is coming in.
    newValue = Math.max(this.minimum_, newValue - this.stepSize_);
    newValue = Math.min(this.maximum_, newValue + this.stepSize_);
    this.value_ = this.snap(newValue);

    this.dispatchEvent('valueChange');
  }
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @return {Number} The current snapInterval value.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
get_snapInterval = function() {
  return this.snapInterval_;
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @param {Number} value The new snapInterval value.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
set_snapInterval = function(value) {
  if (this.snapInterval_ != value) {
      this.snapInterval_ = value;
      this.dispatchEvent('snapIntervalChange');
  }
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @return {Number} The current stepSize value.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
get_stepSize = function() {
  return this.stepSize_;
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @param {Number} value The new stepSize value.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
set_stepSize = function(value) {
  if (this.stepSize_ != value) {
      this.stepSize_ = value;
      this.dispatchEvent('stepSizeChange');
  }
};

/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.models.RangeModel}
 * @param {Number} value The candidate number.
 * @return {Number} Adjusted value.
 */
org.apache.flex.html.staticControls.beads.models.RangeModel.prototype.
snap = function(value) {
  var si = this.snapInterval_;
  var n = Math.round((value - this.minimum_) / si) *
                 si + this.minimum_;
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
