/**
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * org.apache.flex.core.ISelectionModel
 *
 * @fileoverview
 *
 * @suppress {checkTypes}
 */

goog.provide('org.apache.flex.core.ISelectionModel');



/**
 * @interface
 * @extends {org.apache.flex.events.IEventDispatcher}
 * @extends {org.apache.flex.core.IBeadModel}
 */
org.apache.flex.core.ISelectionModel = function() {
};


/**
 * @expose
 * @param {Object} value
 */
org.apache.flex.core.ISelectionModel.prototype.set_dataProvider = function(value) {};


/**
 * @expose
 * @return {Object} The dataProvider.
 */
org.apache.flex.core.ISelectionModel.prototype.get_dataProvider = function() {};


/**
 * @expose
 * @param {number} value
 */
org.apache.flex.core.ISelectionModel.prototype.set_selectedIndex = function(value) {};


/**
 * @expose
 * @return {number} The selected index.
 */
org.apache.flex.core.ISelectionModel.prototype.get_selectedIndex = function() {};


/**
 * @expose
 * @param {Object} value
 */
org.apache.flex.core.ISelectionModel.prototype.set_selectedItem = function(value) {};


/**
 * @expose
 * @return {Object} The selected item.
 */
org.apache.flex.core.ISelectionModel.prototype.get_selectedItem = function() {};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.apache.flex.core.ISelectionModel.prototype.FLEXJS_CLASS_INFO =
{ names: [{ name: 'ISelectionModel', qName: 'org.apache.flex.core.ISelectionModel'}],
  interfaces: [org.apache.flex.events.IEventDispatcher, org.apache.flex.core.IBeadModel] };
