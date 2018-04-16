/*
 * MIT License
 *
 * Copyright (c) 2018 Vanat 
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

using Gee;

namespace Vanat.Library.Collections {

    /**
     * 
     */
    private class KeySet<K,V> : GLib.Object, Gee.Traversable<K>, Gee.Iterable<K>, Gee.Collection<K>, Set<K> {

        /**
         * 
         */
        private LinkedHashMap<K,V> _map;

        /**
         * 
         */
        public int size {
            get { 
                return _map.size; 
            }
        }

        /**
         * 
         */
        public bool read_only {
            get { 
                return true;
            }
        }

        /**
         * 
         */
        public LinkedHashMap<K,V> map {
            set { 
                _map = value; 
            }
        }

        /**
         * 
         */
        public new Collection<K> read_only_view {
            owned get { 
                return this; 
            }
        }

        /**
         * [KeySet description]
         * @param {[type]} LinkedHashMap map [description]
         */
        public KeySet (LinkedHashMap map) {
            this.map = map;
        }

        /*
         * [get_element_type description]
         * @return {[type]} [description]
         * /
        public Type get_element_type () {
            return typeof (K);
        }*/

        /**
         * [iterator description]
         * @return {[type]} [description]
         */
        public Iterator<K> iterator () {
            return new KeyIterator<K,V> (_map);
        }

        /**
         * [add description]
         * @param {[type]} K key [description]
         */
        public bool add (K key) {
            assert_not_reached ();
        }

        /**
         * [clear description]
         * @return {[type]} [description]
         */
        public void clear () {
            assert_not_reached ();
        }

        /**
         * [remove description]
         * @param  {[type]} K key           [description]
         * @return {[type]}   [description]
         */
        public bool remove (K key) {
            assert_not_reached ();
        }

        /**
         * [contains description]
         * @param  {[type]} K key           [description]
         * @return {[type]}   [description]
         */
        public bool contains (K key) {
            return _map.contains (key);
        }

        /**
         * 
         */
        public bool @foreach (ForallFunc<K> f) {
            return true;
        }        
    }
}
