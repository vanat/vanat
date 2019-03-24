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

using Vanat.Collections;
using Vanat.Exceptions;
using Vanat.Utils;
using Json;

namespace Vanat.VJson {

    /**
     * The {@code Installed} class
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class Installed {

        public string name;
        public string description;
        public string version;
        public string author;
        public Gee.HashMap<string, string> require;

        /**
         * Constructs a new {@code InstallCommand} object 
         * and sets the default exit folder.
         */
        public Installed (string value)  throws Error  {

            if (! StringUtil.is_blank (value)) {

                // Json: (Array: [], Object: {})
                string data = value;

                Json.Parser parser = new Json.Parser ();
                try {
                    parser.load_from_data (data);

                    unowned Json.Node node = parser.get_root ();


                    process_role_array (node);
                } catch (Error e) {
                    GLib.error ("Unable to parse the string: %s\n", e.message);
                }
            } else {
                throw new IllegalArgumentException.MESSAGE("");
            }
        }

        private void process_role_array (Json.Node node) throws Error {
            if (node.get_node_type () != Json.NodeType.ARRAY) {
                throw new JsonException.INVALID_FORMAT ("1- Unexpected element type %s", node.type_name ());
            }

            unowned Json.Array array = node.get_array ();
			int i = 1;

			foreach (unowned Json.Node item in array.get_elements ()) {
				process_role (item, i);
				i++;
			}
		}

		private void process_role (Json.Node node, uint number) throws Error {
			/*if (node.get_node_type () != Json.NodeType.OBJECT) {
				throw new MyError.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
			}

            unowned Json.Object obj = node.get_object ();

            foreach (unowned string name in obj.get_members ()) {
                switch (name) {
                    case "name":
                        this.name = obj.get_string_member (name);
                        break;

                    case "description":
                        this.description = obj.get_string_member (name);
                        break;

                    case "version":
                        this.version = obj.get_string_member (name);
                        break;

                    case "author":
                        this.author = obj.get_string_member (name);
                        break;

                    case "require":
                        unowned Json.Node item = obj.get_member (name);
                        process_require (item);
                        break;

                    default:
                        throw new JsonException.INVALID_FORMAT ("2- Unexpected element '%s'", name);
                }
            }*/
        }

        /*private void process_require (Json.Node node) throws Error {
            if (node.get_node_type () != Json.NodeType.OBJECT) {
                throw new JsonException.INVALID_FORMAT ("3- Unexpected element type %s", node.type_name ());
            }

            unowned Json.Object obj = node.get_object ();
                    
            this.require = new Gee.HashMap<string, string>();

            foreach (unowned string name in obj.get_members()) {
                this.require.set(name, obj.get_string_member (name));
            }
        }*/
    }
}