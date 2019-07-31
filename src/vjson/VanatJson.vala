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
     * The {@code VanatJson} class
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class VanatJson {

        public string name;
        public string description;
        public string version;
        public string author;
        public Gee.HashMap<string, string> require;

        /**
         * Constructs a new {@code InstallCommand} object 
         * and sets the default exit folder.
         */
        public VanatJson (string value)  throws Error  {

            if (! StringUtil.is_blank (value)) {

                // Json: (Array: [], Object: {})
                string data = value;
                int count_data = data.length;

                if(count_data == 0) {
                    throw new IllegalArgumentException.MESSAGE("Illegal Argument");
                }

                // Parse:
                Json.Parser parser = new Json.Parser ();
                try {
                    parser.load_from_data (data);

                    // Get the root node:
                    unowned Json.Node node = parser.get_root ();

                    // Process (print) the file:
                    process (node);
                } catch (Error e) {
                    GLib.error ("Unable to parse the string: %s\n", e.message);
                }
            } else {
                throw new IllegalArgumentException.MESSAGE("");
            }
        }

        private void process (Json.Node node) throws Error {
            if (node.get_node_type () != Json.NodeType.OBJECT) {
                throw new JsonException.INVALID_FORMAT ("1- Unexpected element type %s", node.type_name ());
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
            }
        }

        private void process_require (Json.Node node) throws Error {
            if (node.get_node_type () != Json.NodeType.OBJECT) {
                throw new JsonException.INVALID_FORMAT ("3- Unexpected element type %s", node.type_name ());
            }

            unowned Json.Object obj = node.get_object ();
                    
            this.require = new Gee.HashMap<string, string>();

            foreach (unowned string name in obj.get_members()) {
                this.require.set(name, obj.get_string_member (name));
            }
        }
    }
}