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
    private class MapIterator<K,V> : GLib.Object, Gee.MapIterator<K, V> {

        /**
         * [_index description]
         * @type {Number}
         */
        private int _index = -1;

        /**
         * concurrent modification protection
         */
        private int _stamp;

        /**
         * 
         */
        private weak Node<K,V> _next;

        /**
         * 
         */
        private weak Node<K,V> _node;

        /**
         * 
         */
        private LinkedHashMap<K,V> _map;

        /**
         * 
         */
        public bool valid {
            get {
                return _node != null;
            }
        }

        /**
         * Metodo abstract do Gee.Iterator
         */
        public bool read_only { 
            get { 
                return true; 
            }
        }        

        /**
         * 
         */
        public bool mutable { 
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
                _stamp = _map.stamp;
            }
        }

        /**
         * [MapIterator description]
         * @param {[type]} LinkedHashMap map [description]
         */
        public MapIterator (LinkedHashMap map) {
            this.map = map;
        }

        /**
         * [next description]
         * @return {Function} [description]
         */
        public bool next () {
            if (_node != null) {
                _node = _node.next;
            }
            while (_node == null && _index + 1 < _map.array_size) {
                _index++;
                _node = _map.nodes[_index];
            }
            return (_node != null);
        }

        /**
         * [get_key description]
         * @return {[type]} [description]
         */
        public new K? get_key () {
            assert (_stamp == _map.stamp);
            assert (_node != null);
            return _node.key;
        }

        /**
         * [get_value description]
         * @return {[type]} [description]
         */
        public new V? get_value () {
            assert (_stamp == _map.stamp);
            assert (_node != null);
            return _node.value;
        }

        /**
         * [unset description]
         * @return {[type]} [description]
         */
        public void unset () {

        }

        /**
         * [set_value description]
         * @param {[type]} V value [description]
         */
        public void set_value (V value) {

        }

        /**
         * [has_next description]
         * @return {Boolean} [description]
         */
        public bool has_next () {
            assert (_stamp == _map.stamp);
            if (_next == null) {
                _next = _node;
                if (_next != null) {
                    _next = _next.next;
                }
                while (_next == null && _index + 1 < _map.array_size) {
                    _index++;
                    _next = _map.nodes[_index];
                }
            }
            return (_next != null);
        }
    }
}
