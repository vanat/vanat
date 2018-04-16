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
    private class ValueCollection<K,V> : GLib.Object, Gee.Traversable<K>, Gee.Iterable<K>, Collection<V> {

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
        public new Collection<V> read_only_view {
            owned get { 
                return this; 
            }
        }

        /**
         * [foreach description]
         * @param  {[type]} ForallFunc<K> f             [description]
         * @return {[type]}               [description]
         */
        public bool @foreach (ForallFunc<K> f) {
            return true;
        }        

        /**
         * [ValueCollection description]
         * @param {[type]} LinkedHashMap map [description]
         */
        public ValueCollection (LinkedHashMap map) {
            this.map = map;
        }

        /*
         * [get_element_type description]
         * @return {[type]} [description]
         * /
        public Type get_element_type () {
            return typeof (V);
        }*/

        /**
         * [iterator description]
         * @return {[type]} [description]
         */
        public Gee.Iterator<K> iterator () {
            return new ValueIterator<K,V> (_map);
        }

        
        /**
         * [add description]
         * @param {[type]} V value [description]
         */
        public bool add (V value) {
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
         * @param  {[type]} V value         [description]
         * @return {[type]}   [description]
         */
        public bool remove (V value) {
            assert_not_reached ();
        }

        /**
         * [contains description]
         * @param  {[type]} V value         [description]
         * @return {[type]}   [description]
         */
        public bool contains (V value) {
            Iterator<V> it = iterator ();
            while (it.next ()) {
                if (_map.value_equal_func (it.get (), value)) {
                    return true;
                }
            }
            return false;
        }
    }
}
