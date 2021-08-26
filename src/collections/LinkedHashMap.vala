/*
 * MIT License
 *
 * Copyright (c) 2019 Vanat 
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

namespace Vanat.Collections {

    /**
     * @Author: Che Bizarro
     * @link https://github.com/chebizarro
     * @modify Robert San
     */
    public class LinkedHashMap<K,V> : Gee.HashMap<K,V> {

        /**
         * 
         */
        private weak Gee.Set<weak K> _keyset;

        /**
         * 
         */
        private weak Gee.Collection<weak V> _values;

        /**
         * 
         */
        private weak Gee.Set<Entry<K,V>> _entries;

        /**
         * [_keys description]
         * @type {ArrayList}
         */
        internal Gee.ArrayList<weak K> _keys = new Gee.ArrayList<weak K>();


        public new Gee.Set<unowned K> keys {
            owned get {
                Gee.Set<weak K> keys = _keyset;
                if (_keyset == null) {
                    keys = new KeySet<weak K> (_keys);
                    _keyset = keys;
                    keys.add_weak_pointer ((void**) (&_keyset));
                }
                return keys;
            }
        }

        /**
         * 
         */
        public new Gee.Collection<unowned V> values {
            owned get {
                Gee.Collection<weak K> values = _values;
                if (_values == null) {
                    
                    values = new ValueCollection<K,V> (this);
                    _values = values;
                    values.add_weak_pointer ((void**) (&_values));
                }
                return values;
            }
        }

        /**
         * [set description]
         * @param {[type]} K key   [description]
         * @param {[type]} V value [description]
         */
        public new void @set(K key, V value) {
            if (!_keys.contains(key))
            _keys.add(key);
            base.set(key, value);
        }

        /**
         * [unset description]
         * @param  {[type]} K   key           [description]
         * @param  {[type]} out V?            value         [description]
         * @return {[type]}     [description]
         */
        public new void unset(K key, out V? value = null) {
            _keys.remove(key);
            base.unset(key, out value);
        }

        /**
         * [clear description]
         * @return {[type]} [description]
         */
        public new void clear() {
            base.clear();
            _keys.clear();
        }

        /**
         * 
         */
        public new Gee.Set<Entry<K,V>> entries {
            owned get {
                Gee.Set<Entry<K,V>> entries = _entries;
                if (_entries == null) {
                    entries = new EntrySet<K,V> (this);
                    _entries = entries;
                    entries.add_weak_pointer ((void**) (&_entries));
                }
                return entries;
            }
        }

        /**
         * 
         */
        private class KeySet<K> : Gee.AbstractSet<K> {

            /**
             * 
             */
            private weak Gee.ArrayList<K> _keys;

            /**
             * 
             */
            public override int size {
                get { return _keys.size; }
            }

            /**
             * 
             */
            public override bool read_only {
                get { return true; }
            }

            /**
             * [KeySet description]
             * @param {[type]} Gee.ArrayList<K> keys [description]
             */
            public KeySet (Gee.ArrayList<K> keys) {
                _keys = keys;
            }

            /**
             * [iterator description]
             * @return {[type]} [description]
             */
            public override Gee.Iterator<K> iterator () {
                return _keys.iterator();
            }

            /**
             * [add description]
             * @param {[type]} K key [description]
             */
            public override bool add (K key) {
                assert_not_reached ();
            }

            /**
             * [clear description]
             * @return {[type]} [description]
             */
            public override void clear () {
                assert_not_reached ();
            }

            /**
             * [remove description]
             * @param  {[type]} K key           [description]
             * @return {[type]}   [description]
             */
            public override bool remove (K key) {
                assert_not_reached ();
            }

            /**
             * [contains description]
             * @param  {[type]} K key           [description]
             * @return {[type]}   [description]
             */
            public override bool contains (K key) {
                return _keys.contains (key);
            }
        }

        /**
         * 
         */
        private class ValueCollection<K,V> : Gee.AbstractCollection<V> {

            /**
             * 
             */
            private weak LinkedHashMap<K,V> _map;

            /**
             * [ValueCollection description]
             * @param {[type]} LinkedHashMap map [description]
             */
            public ValueCollection (LinkedHashMap map) {
                _map = map;
            }

            /**
             * [iterator description]
             * @return {[type]} [description]
             */
            public override Gee.Iterator<V> iterator () {
                return new ValueIterator<K,V> (_map);
            }

            /**
             * 
             */
            public override int size {
                get { return _map.size; }
            }

            /**
             * 
             */
            public override bool read_only {
                get { return true; }
            }

            /**
             * [add description]
             * @param {[type]} V value [description]
             */
            public override bool add (V value) {
                assert_not_reached ();
            }

            /**
             * [clear description]
             * @return {[type]} [description]
             */
            public override void clear () {
                assert_not_reached ();
            }

            /**
             * [remove description]
             * @param  {[type]} V value         [description]
             * @return {[type]}   [description]
             */
            public override bool remove (V value) {
                assert_not_reached ();
            }

            /**
             * [contains description]
             * @param  {[type]} V value         [description]
             * @return {[type]}   [description]
             */
            public override bool contains (V value) {
                Gee.Iterator<V> it = iterator ();
                while (it.next ()) {
                    if (_map.value_equal_func (it.get (), value)) {
                        return true;
                    }
                }
                return false;
            }
        }

        /**
         * 
         */
        private class ValueIterator<K,V> : GLib.Object, Gee.Traversable<V>, Gee.Iterator<V> {

            /**
             * 
             */
            protected weak LinkedHashMap<K,V> _map;

            /**
             * 
             */
            protected Gee.Iterator<weak K> _keys;

            /**
             * [ValueIterator description]
             * @param {[type]} LinkedHashMap<K,V> map [description]
             */
            public ValueIterator (LinkedHashMap<K,V> map) {
                _map = map;
                _keys = map._keys.iterator();
            }

            /**
             * [next description]
             * @return {Function} [description]
             */
            public bool next () {
                return _keys.next();
            }

            /**
             * [has_next description]
             * @return {Boolean} [description]
             */
            public bool has_next () {
                return _keys.has_next();
            }

            /**
             * 
             */
            public virtual bool read_only {
                get { return true; }
            }

            /**
             * 
             */
            public bool valid {
                get { return _keys.valid; }
            }

            /**
             * [get description]
             * @return {[type]} [description]
             */
            public new V get () {
                return _map.get(_keys.get());
            }

            /**
             * [remove description]
             * @return {[type]} [description]
             */
            public void remove () {
                assert_not_reached ();
            }

            /**
             * [foreach description]
             * @param  {[type]} Gee.ForallFunc<V> f             [description]
             * @return {[type]}                   [description]
             */
            public bool foreach(Gee.ForallFunc<V> f) {
                foreach (K key in _map._keys) {
                    if (!f(_map.get(key))) {
                        return false;
                    }
                }
                return true;
            }
        }

        /**
         * 
         */
        private class EntrySet<K,V> : Gee.AbstractSet<Entry<K, V>> {
            /**
             * 
             */
            private weak LinkedHashMap<K,V> _map;

            /**
             * [EntrySet description]
             * @param {[type]} LinkedHashMap<K,V> map [description]
             */
            public EntrySet (LinkedHashMap<K,V> map) {
                _map = map;
            }

            /**
             * [iterator description]
             * @return {[type]} [description]
             */
            public override Gee.Iterator<Entry<K, V>> iterator () {
                return new EntryIterator<K,V> (_map);
            }

            /**
             * 
             */
            public override int size {
                get { return _map.size; }
            }

            /**
             * 
             */
            public override bool read_only {
                get { return true; }
            }

            /**
             * [add description]
             * @param {[type]} Entry<K, V> entry [description]
             */
            public override bool add (Entry<K, V> entry) {
                assert_not_reached ();
            }

            /**
             * [clear description]
             * @return {[type]} [description]
             */
            public override void clear () {
                assert_not_reached ();
            }

            /**
             * [remove description]
             * @param  {[type]} Entry<K, V>            entry [description]
             * @return {[type]}          [description]
             */
            public override bool remove (Entry<K, V> entry) {
                assert_not_reached ();
            }

            /**
             * [contains description]
             * @param  {[type]} Entry<K, V>            entry [description]
             * @return {[type]}          [description]
             */
            public override bool contains (Entry<K, V> entry) {
                return _map.has (entry.key, entry.value);
            }
        }

        /**
         * 
         */
        private class EntryIterator<K,V> : GLib.Object, Gee.Traversable<Entry<K,V>>, Gee.Iterator<Entry<K,V>> {

            /**
             * 
             */
            protected weak LinkedHashMap<K,V> _map;

            /**
             * 
             */
            protected Gee.Iterator<weak K> _keys;

            /**
             * 
             */
            public virtual bool read_only {
                get { return true; }
            }

            /**
             * 
             */
            public bool valid {
                get { return _keys.valid; }
            }

            /**
             * [EntryIterator description]
             * @param {[type]} LinkedHashMap<K,V> map [description]
             */
            public EntryIterator (LinkedHashMap<K,V> map) {
                _map = map;
                _keys = map._keys.iterator();
            }

            /**
             * [next description]
             * @return {Function} [description]
             */
            public bool next () {
                return _keys.next();
            }

            /**
             * [has_next description]
             * @return {Boolean} [description]
             */
            public bool has_next () {
                return _keys.has_next();
            }

            /**
             * [get description]
             * @return {[type]} [description]
             */
            public new Entry<K,V> get () {
                K* k = _keys.get();
                var ent = new Entry<K,V>(k, _map.get(k));
                return ent;
            }

            /**
             * [remove description]
             * @return {[type]} [description]
             */
            public void remove () {
                assert_not_reached ();
            }

            /**
             * Apply function to each element returned by iterator untill last element or function return false.
             * 
             * @param  {[type]} Gee.ForallFunc<Entry<K,V>> f             [description]
             * @return {[type]}                            [description]
             */
            public bool foreach(Gee.ForallFunc<Entry<K,V>> f) {
                foreach (K key in _map._keys) { 
                    if (!f(new Entry<K,V>(key, _map.get(key)))){
                        return false;
                    }
                }
                return true;
            }
        }

        /**
         * An entry of a map.
         */
        public class Entry<K,V> : Gee.Map.Entry<K,V> {
            /**
             * 
             */
            weak K _key;

            /**
             * 
             */
            weak V _value;

            /**
             * The key of this entry.
             */
            public override K key {
                get { return _key; }
            }

            /**
             * The value of this entry.
             */
            public override V value {
                get { return _value; } 
                set { _value = value; }
            }

            /**
             * true if the setting value is permitted.
             */
            public override bool read_only {
                get { return true; }
            }

            /**
             * [Entry description]
             * @param {[type]} K key   [description]
             * @param {[type]} V value [description]
             */
            public Entry (K key, V value) {
                this._key = key;
                this._value = value;
            }
        }

    }
}
