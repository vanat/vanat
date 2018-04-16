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
     * The {@code LinkedHashMap} class
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class LinkedHashMap<K,V> : GLib.Object, Gee.Traversable<K>, Gee.Iterable<K>, Gee.Map<K,V> {

        /**
         * [MIN_SIZE description]
         * @type {Number}
         */
        private const int MIN_SIZE = 11;

        /**
         * [MAX_SIZE description]
         * @type {Number}
         */
        private const int MAX_SIZE = 13845163;


        /**
         * concurrent modification protection
         */
        private int _stamp = 0;

        /**
         * 
         */
        private int _array_size;

        /**
         * 
         */
        private int _nnodes;

        /**
         * 
         */
        private Set<K> _set;

        /**
         * 
         */
        private Set<Gee.Map.Entry<K,V>> _entries;

        /**
         * 
         */
        private Collection<V> _values;

        /**
         * 
         */
        private Node<K,V>[] _nodes;

        /**
         * 
         */
        private HashFunc<K> _key_hash_func;

        /**
         * 
         */
        private EqualFunc<K> _key_equal_func;

        /**
         * 
         */
        private EqualFunc<V> _value_equal_func;

        /**
         * The read-only view of the entries of this map.
         */
        public Set<Gee.Map.Entry<K,V>> entries {
            owned get { 
                return _entries; 
            }
        }   
        
        /**
         * The read-only view of the keys of this map.
         */
        public Set<K> keys{
            owned get { 
                return _set; 
            }
        }   
        /**
         * Specifies whether this collection can change - i.e. wheather set, remove etc. are legal operations.
         */
        public bool read_only {
            get { 
                return true; 
            }
        }   
        /**
         * The read-only view of the values of this map.
         */
        public Collection<V> values {
            owned get { 
                return _values; 
            }
        }   

        /**
         * The read-only view this map.
         */
        public Map<K,V> read_only_view { 
            owned get { 
                return this; 
            } 
        }

        /**
         * 
         */
        public int array_size {
            get { 
                return _array_size; 
            }
        }  

        /**
         * 
         */
        public Node<K,V>[] nodes {
            get { 
                return _nodes; 
            }
        }  

        /**
         * 
         */
        public int stamp {
            get { 
                return _stamp; 
            }
        }  

        /**
         * 
         */
        public int size {
            get { 
                return _nnodes; 
            }
        }

        /**
         * 
         */
        public HashFunc<K> key_hash_func {
            set { 
                _key_hash_func = value; 
            }
        }

        /**
         * 
         */
        public EqualFunc<K> key_equal_func {
            set { 
                _key_equal_func = value; 
            }
        }

        /**
         * 
         */
        public EqualFunc<V> value_equal_func {
            set { 
                _value_equal_func = value; 
            }
            
            get { 
                return _value_equal_func; 
            }
        }

        /**
         * [LinkedHashMap description]
         * @param {[type]} HashFunc<K>  key_hash_func    [description]
         * @param {[type]} EqualFunc<K> key_equal_func   [description]
         * @param {[type]} EqualFunc<V> value_equal_func [description]
         */
        public LinkedHashMap (HashFunc<K> key_hash_func = GLib.direct_hash, EqualFunc<K> key_equal_func = GLib.direct_equal, EqualFunc<V> value_equal_func = GLib.direct_equal) {
            this.key_hash_func = key_hash_func;
            this.key_equal_func = key_equal_func;
            this.value_equal_func = value_equal_func;
            _array_size = MIN_SIZE;
            _nodes = new Node<K,V>[_array_size];
        }

        /**
         * [LinkedHashMap description]
         */
        ~LinkedHashMap () {
            clear ();
        }

        /**
         * [unset description]
         * @param  {[type]} K   key           [description]
         * @param  {[type]} out V             value         [description]
         * @return {[type]}     [description]
         */
        public bool unset (K key, out V value = null) {
            return true;
        }
        
        /**
         * [has_key description]
         * @param  {[type]}  K key           [description]
         * @return {Boolean}   [description]
         */
        public bool has_key (K key) {
         return true;   
        }

        /**
         * [has description]
         * @param  {[type]}  K key           [description]
         * @param  {[type]}  V value         [description]
         * @return {Boolean}   [description]
         */
        public bool has (K key, V value){
         return true;   
        }

        /**
         * [iterator description]
         * @return {[type]} [description]
         */
        public Iterator<K> iterator () {
            return new KeyIterator<K,V> (this);
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
         * [get_keys description]
         * @return {[type]} [description]
         */
        public  Set<K> get_keys () {
            return new KeySet<K,V> (this);
        }

        /**
         * [get_values description]
         * @return {[type]} [description]
         */
        public Collection<V> get_values () {
            return new ValueCollection<K,V> (this);
        }

        /**
         * [map_iterator description]
         * @return {[type]} [description]
         */
        public Gee.MapIterator<K,V> map_iterator () {
            return new MapIterator<K,V> (this);
        }

        /**
         * [contains description]
         * @param  {[type]} K key           [description]
         * @return {[type]}   [description]
         */
        public bool contains (K key) {
            Node<K,V>** node = lookup_node (key);
            return (*node != null);
        }

        /**
         * [get description]
         * @param  {[type]} K key           [description]
         * @return {[type]}   [description]
         */
        public new V? get (K key) {
            Node<K,V>* node = (*lookup_node (key));
            if (node != null) {
                return node->value;
            } else {
                return null;
            }
        }

        /**
         * [set description]
         * @param {[type]} K key   [description]
         * @param {[type]} V value [description]
         */
        public new void set (K key, V value) {
            Node<K,V>** node = lookup_node (key);
            if (*node != null) {
                (*node)->value = value;
            } else {
                uint hash_value = _key_hash_func (key);
                *node = new Node<K,V> (key, value, hash_value);
                _nnodes++;
                resize ();
            }
            _stamp++;
        }

        /**
         * [remove description]
         * @param  {[type]} K key           [description]
         * @return {[type]}   [description]
         */
        public bool remove (K key) {
            Node<K,V>** node = lookup_node (key);
            if (*node != null) {
                Node<K,V> next = (owned) (*node)->next;

                (*node)->key = null;
                (*node)->value = null;
                delete *node;

                *node = (owned) next;

                _nnodes--;
                resize ();
                _stamp++;
                return true;
            }
            return false;
        }

        /**
         * [clear description]
         * @return {[type]} [description]
         */
        public void clear () {
            for (int i = 0; i < _array_size; i++) {
                Node<K,V> node = (owned) _nodes[i];
                while (node != null) {
                    Node next = (owned) node.next;
                    node.key = null;
                    node.value = null;
                    node = (owned) next;
                }
            }
            _nnodes = 0;
            resize ();
        }

        /**
         * [resize description]
         * @return {[type]} [description]
         */
        private void resize () {
            if ((_array_size >= 3 * _nnodes && _array_size >= MIN_SIZE) ||
                (3 * _array_size <= _nnodes && _array_size < MAX_SIZE)) {
                int new_array_size = (int) SpacedPrimes.closest (_nnodes);
                new_array_size = new_array_size.clamp (MIN_SIZE, MAX_SIZE);

                Node<K,V>[] new_nodes = new Node<K,V>[new_array_size];

                for (int i = 0; i < _array_size; i++) {
                    Node<K,V> node;
                    Node<K,V> next = null;
                    for (node = (owned) _nodes[i]; node != null; node = (owned) next) {
                        next = (owned) node.next;
                        uint hash_val = node.key_hash % new_array_size;
                        node.next = (owned) new_nodes[hash_val];
                        new_nodes[hash_val] = (owned) node;
                    }
                }
                _nodes = (owned) new_nodes;
                _array_size = new_array_size;
            }
        }

        /**
         * [lookup_node description]
         * @param  {[type]} K key           [description]
         * @return {[type]}   [description]
         */
        private Node<K,V>** lookup_node (K key) {
            uint hash_value = _key_hash_func (key);
            Node<K,V>** node = &_nodes[hash_value % _array_size];
            while ((*node) != null && (hash_value != (*node)->key_hash || !_key_equal_func ((*node)->key, key))) {
                node = &((*node)->next);
            }
            return node;
        }
    }
}
