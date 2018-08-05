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

using Vanat.Utils;

namespace Vanat.Commands {
    public errordomain MyError {
            INVALID_FORMAT
        }
     
    /**
     * The {@code RequireCommand} class
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class RequireCommand {

        
        /**
         * Constructs a new {@code RequireCommand} object 
         * and sets the default exit folder.
         */
        public RequireCommand (string arg) {
           // if (this.valid_package(arg)) {

                /*File file = File.new_for_uri("vanat.json");
                try {
                    if(file.query_exists() == true){
                        var dis = new DataInputStream (file.read ());
                        string line;
                        // Read lines until end of file (null) is reached
                        while ((line = dis.read_line (null)) != null) {
                            stdout.printf ("%s\n", line);
                        }
                    }
                } catch (Error e) {
                    stderr.printf ("Error: %s\n", e.message);
                }*/


                /*string data = ;

                Json.Parser parser = new Json.Parser ();
                parser.load_from_data (data);

                // Get the root node:
                Json.Node node = parser.get_root ();

                // Process (print) the file:
                process (node);*/
                 
            //} else {
           //     ConsoleUtil.write_custom_color("Ops! package not found.", true, false, "red");
            //}
        }

         /**
         * [valid_package description]
         * // @param  {[type]} string arg           [description]
         * //@return {[type]}        [description]
         * /
        private bool valid_package (string arg) {
            return true;
        }

        public static void process (Json.Node node) throws Error {
            if (node.get_node_type () != Json.NodeType.OBJECT) {
                throw new MyError.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
            }

            unowned Json.Object obj = node.get_object ();

            foreach (unowned string name in obj.get_members ()) {
                switch (name) {
                case "good":
                    unowned Json.Node item = obj.get_member (name);
                    process_good (item);
                    break;

                case "bad":
                    unowned Json.Node item = obj.get_member (name);
                    process_bad (item);
                    break;

                default:
                    throw new MyError.INVALID_FORMAT ("Unexpected element '%s'", name);
                }
            }
        }

        public static void process_role_array (Json.Node node) throws Error {
    if (node.get_node_type () != Json.NodeType.ARRAY) {
        throw new MyError.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
    }

    unowned Json.Array array = node.get_array ();
    int i = 1;

    foreach (unowned Json.Node item in array.get_elements ()) {
        process_role (item, i);
        i++;
    }
}

        public static void process_good (Json.Node node) throws Error {
            stdout.puts ("Good:\n");
            process_role_array (node);
        }

        public static void process_bad (Json.Node node) throws Error {
            stdout.puts ("Bad:\n");
            process_role_array (node);
        }

        public static void process_role (Json.Node node, uint number) throws Error {
            if (node.get_node_type () != Json.NodeType.OBJECT) {
                throw new MyError.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
            }

            // TODO, type check ...
            unowned Json.Object obj = node.get_object ();
            unowned string first = null;
            unowned string last = null;

            foreach (unowned string name in obj.get_members ()) {
                switch (name) {
                case "firstName":
                    unowned Json.Node item = obj.get_member (name);
                    if (item.get_node_type () != Json.NodeType.VALUE) {
                        throw new MyError.INVALID_FORMAT ("Unexpected element type %s", item.type_name ());
                    }

                    first = obj.get_string_member ("firstName");
                    break;

                case "lastName":
                    unowned Json.Node item = obj.get_member (name);
                    if (item.get_node_type () != Json.NodeType.VALUE) {
                        throw new MyError.INVALID_FORMAT ("Unexpected element type %s", item.type_name ());
                    }

                    last = obj.get_string_member ("lastName");
                    break;

                default:
                    throw new MyError.INVALID_FORMAT ("Unexpected element '%s'", name);
                }
            }
            
            if (first == null || last == null) {
                throw new MyError.INVALID_FORMAT ("Expected: firstName, lastName");
            }

            stdout.printf ("\t%s %s\n", first, last);
        }*/

        /**
         * [start_process description]
         * 
         * @return {[type]} [description]
         */
        public static RequireCommand start_process (string arg) {
            return new RequireCommand (arg);
        }
    }
}