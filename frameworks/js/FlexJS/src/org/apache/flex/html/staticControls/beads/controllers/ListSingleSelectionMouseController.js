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

goog.provide('org.apache.flex.html.staticControls.beads.controllers.ListSingleSelectionMouseController');

goog.require('org.apache.flex.html.staticControls.beads.ListView');
goog.require('org.apache.flex.html.staticControls.beads.models.ArraySelectionModel');


/**
 * @constructor
 */
org.apache.flex.html.staticControls.beads.controllers.
ListSingleSelectionMouseController = function() {
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.controllers.
 *        ListSingleSelectionMouseController}
 * @param {object} value The strand for this component.
 */
org.apache.flex.html.staticControls.beads.controllers.
ListSingleSelectionMouseController.prototype.set_strand = function(value) {
  this.strand_ = value;

  this.model = value.getBeadByType(
         org.apache.flex.html.staticControls.beads.models.ArraySelectionModel);
  this.listView = value.getBeadByType(
        org.apache.flex.html.staticControls.beads.ListView);

  this.dataGroup = this.listView.get_dataGroup();
  this.dataGroup.addEventListener('selected',
    goog.bind(this.selectedHandler, this));
};


/**
 * @expose
 * @this {org.apache.flex.html.staticControls.beads.controllers.
 *        ListSingleSelectionMouseController}
 * @param {object} event The event that triggered the selection.
 */
org.apache.flex.html.staticControls.beads.controllers.
ListSingleSelectionMouseController.prototype.selectedHandler = function(event) {

  var index = event.target.get_index();
  this.model.set_selectedIndex(index);

  var newEvent = new org.apache.flex.events.Event('change');
  this.strand_.dispatchEvent(newEvent);
};