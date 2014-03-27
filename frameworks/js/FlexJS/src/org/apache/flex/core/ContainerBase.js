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

goog.provide('org.apache.flex.core.ContainerBase');

goog.require('org.apache.flex.core.UIBase');



/**
 * @constructor
 * @extends {org.apache.flex.core.UIBase}
 */
org.apache.flex.core.ContainerBase = function() {
  this.mxmlProperties = null;
  goog.base(this);
};
goog.inherits(org.apache.flex.core.ContainerBase,
    org.apache.flex.core.UIBase);


/**
 * @expose
 */
org.apache.flex.core.ContainerBase.prototype.mxmlContent = null;


/**
 * @expose
 * @type {Array}
 */
org.apache.flex.core.ContainerBase.prototype.mxmlProperties = null;


/**
 * @expose
 * @type {Array}
 */
org.apache.flex.core.ContainerBase.prototype.mxmlDescriptor = null;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.apache.flex.core.ContainerBase.prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'ContainerBase',
                qName: 'org.apache.flex.core.ContainerBase'}] };


/**
 * @override
 */
org.apache.flex.core.ContainerBase.prototype.addedToParent = function() {
  org.apache.flex.utils.MXMLDataInterpreter.generateMXMLProperties(this, this.get_MXMLProperties());
  goog.base(this, 'addedToParent');
  org.apache.flex.utils.MXMLDataInterpreter.generateMXMLInstances(this, this, this.get_MXMLDescriptor());

  this.dispatchEvent('initComplete');
  this.dispatchEvent('childrenAdded');
};


/**
 * @expose
 * @return {Array} An array of properties.
 */
org.apache.flex.core.ContainerBase.prototype.get_MXMLProperties = function() {
  return this.mxmlProperties;
};


/**
 * @expose
 * @return {Array} An array of descriptors.
 */
org.apache.flex.core.ContainerBase.prototype.get_MXMLDescriptor = function() {
  return this.mxmlDescriptor;
};


/**
 * @expose
 * @param {Array} data Property name/value pairs for this instance.
 */
org.apache.flex.core.ContainerBase.prototype.generateMXMLAttributes = function(data) {
  this.mxmlProperties = data;
};