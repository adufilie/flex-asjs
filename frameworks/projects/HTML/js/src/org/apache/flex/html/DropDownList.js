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

goog.provide('org_apache_flex_html_DropDownList');

goog.require('org_apache_flex_core_ListBase');
goog.require('org_apache_flex_html_beads_models_ArraySelectionModel');



/**
 * @constructor
 * @extends {org_apache_flex_core_ListBase}
 */
org_apache_flex_html_DropDownList = function() {
  org_apache_flex_html_DropDownList.base(this, 'constructor');
  this.model = new org_apache_flex_html_beads_models_ArraySelectionModel();
};
goog.inherits(org_apache_flex_html_DropDownList,
    org_apache_flex_core_ListBase);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org_apache_flex_html_DropDownList.prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'DropDownList',
                qName: 'org_apache_flex_html_DropDownList'}] };


/**
 * @override
 */
org_apache_flex_html_DropDownList.prototype.
    createElement = function() {
  this.element = document.createElement('select');
  this.element.size = 1;
  goog.events.listen(this.element, 'change',
      goog.bind(this.changeHandler, this));
  this.positioner = this.element;

  this.element.flexjs_wrapper = this;

  return this.element;
};


Object.defineProperties(org_apache_flex_html_DropDownList.prototype, {
    /** @expose */
    dataProvider: {
        /** @this {org_apache_flex_html_DropDownList} */
        set: function(value) {
            var dp, i, n, opt;

            this.model.dataProvider = value;

            dp = this.element.options;
            n = dp.length;
            for (i = 0; i < n; i++) {
              dp.remove(0);
            }

            n = value.length;
            for (i = 0; i < n; i++) {
              opt = document.createElement('option');
              opt.text = value[i];
              dp.add(opt);
            }
        }
    },
    /** @expose */
    selectedIndex: {
        // TODO: (aharui) copied from ListBase because you
        // can't just override the setter in a defineProps
        // structure.
        /** @this {org_apache_flex_html_DropDownList} */
        get: function() {
            return this.model.selectedIndex;
        },
        /** @this {org_apache_flex_html_DropDownList} */
        set: function(value) {
            this.model.selectedIndex = value;
            this.element.selectedIndex = value;
        }
    },
    /** @expose */
    selectedItem: {
        // TODO: (aharui) copied from ListBase because you
        // can't just override the setter in a defineProps
        // structure.
        /** @this {org_apache_flex_html_DropDownList} */
        get: function() {
            return this.model.selectedItem;
        },
        /** @this {org_apache_flex_html_DropDownList} */
        set: function(value) {
            this.model.selectedItem = value;
            this.element.selectedIndex = this.selectedIndex;
        }
    }
});


/**
 * @protected
 */
org_apache_flex_html_DropDownList.prototype.changeHandler =
    function() {
  this.model.selectedIndex = this.element.selectedIndex;
  this.dispatchEvent('change');
};