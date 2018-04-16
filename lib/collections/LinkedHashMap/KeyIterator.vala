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
    protected class KeyIterator<K,V> : GLib.Object, Gee.Iterator<K>, Gee.Traversable<K> {

        /**
         * concurrent modification protection
         */
        private int _stamp;

        /**
         * 
         */
        private LinkedHashMap<K,V> _map;

        /**
         * 
         */
        private int _index = -1;

        /**
         * 
         */
        private weak Node<K,V> _node;

        /**
         * 
         */
        private weak Node<K,V> _next;

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
        public bool valid {
            get { 
                return _node != null; 
            }
        }

        /**
         * Metodo abstract do Gee.Traversable
         * @param  {[type]} ForallFunc<G> f             [description]
         * @return {[type]}               [description]
         */
        public bool @foreach (ForallFunc<K> f) {
            return true;
        }

        /**
         * [KeyIterator description]
         * @param {[type]} LinkedHashMap map [description]
         */
        public KeyIterator (LinkedHashMap map) {
            this.map = map;
        }

        /**
         * [next description]
         * @return {Function} [description]
         */
        public bool next () {
            assert (_stamp == _map.stamp);
            if (!has_next ()) {
                return false;
            }
            _node = _next;
            _next = null;
            return (_node != null);
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

        /**
         * [get description]
         * @return {[type]} [description]
         */
        public new K? get () {
            assert (_stamp == _map.stamp);
            assert (_node != null);
            return _node.key;
        }

        /**
         * [remove description]
         * @return {[type]} [description]
         */
        public void remove () {
            assert_not_reached ();
        }
    }
}
