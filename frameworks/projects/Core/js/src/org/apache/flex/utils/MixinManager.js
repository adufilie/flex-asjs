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

goog.provide('org_apache_flex_utils_MixinManager');



/**
 * @constructor
 * @implements {org_apache_flex_core_IBead}
 * Initialize mixins.
 * Compiler may not be generating list of mixins right now.
 */
org_apache_flex_utils_MixinManager = function() {
};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org_apache_flex_utils_MixinManager.prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'MixinManager',
                qName: 'org_apache_flex_utils_MixinManager'}],
     interfaces: [org_apache_flex_core_IBead]};


Object.defineProperties(org_apache_flex_utils_MixinManager.prototype, {
    /** @expose */
    strand: {
        /** @this {org_apache_flex_utils_MixinManager} */
        set: function(value) {
            this.strand_ = value;

            if (value) {
              if (typeof(value.info) == 'function') {
                var mixins = value.info()['mixins'];
                if (mixins) {
                  var n = mixins.length;
                  for (var i = 0; i < n; i++) {
                    mixins[i].init(value);
                  }
                }
              }
            }
        }
    }
});