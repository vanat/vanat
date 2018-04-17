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

using Vanat.Library.Utils;

namespace Vanat.Library.Commands {

    /**
     * The {@code InitCommand} class
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class InitCommand {
     
        /**
         * Constructs a new {@code InitCommand} object 
         * and sets the default exit folder.
         */
        public InitCommand () {

            ConsoleUtil.write(StringUtil.BREAK_LINE);
            ConsoleUtil.write_custom_color("                                     ", true, false, "white", "blue");
            ConsoleUtil.write_custom_color("Welcome to the Vanat config generator", true, false, "black", "blue");
            ConsoleUtil.write_custom_color("                                     ", true, false, "white", "blue");
            
            ConsoleUtil.write(StringUtil.BREAK_LINE);
            ConsoleUtil.write_custom_color("This command will guide you through creating your vanat.json config.", true, false);

            ConsoleUtil.write(StringUtil.BREAK_LINE);
            ConsoleUtil.write("Package name (<user>/<name>): ");
            string package = stdin.read_line ();

            ConsoleUtil.write("Description: ");
            string description = stdin.read_line ();

            ConsoleUtil.write("Version: ");
            string version = stdin.read_line ();

            ConsoleUtil.write("Author (user <xxxxx@email.com>): ");
            string author = stdin.read_line ();

            ConsoleUtil.write("Package Type (project or library or plugin): ");
            string type = stdin.read_line ();

            ConsoleUtil.write("License: ");
            string license = stdin.read_line ();

            string vanat_json = mount_file_data_vanat_json (package, description, version, author, type, license);
            ConsoleUtil.write(StringUtil.BREAK_LINE);
            
            ConsoleUtil.write(vanat_json);
            ConsoleUtil.write(StringUtil.BREAK_LINE);

            ConsoleUtil.write(StringUtil.BREAK_LINE);
            ConsoleUtil.write("Do you confirm generation [yes]? ");
            string confirm = stdin.read_line ();

            if (confirm == "yes" || confirm == "y") {
                File file = File.new_for_path ("vanat.json");
                try {
                    FileOutputStream os = file.create (FileCreateFlags.NONE);
                    os.write (vanat_json.data);
                    ConsoleUtil.write_custom_color("File created.", true, false, "black", "cyan");
                } catch (Error e) {
                    ConsoleUtil.error(e.message);
                }
            } else {
                ConsoleUtil.write_custom_color("Command aborted", true, false, "white", "red");
            }
        }

        /**
         * [mount_file_data_vanat_json description]
         * @return {[type]} [description]
         */
        private string mount_file_data_vanat_json (string package, string description, string version, string author, string type, string license) {
            string file_data_vanat_json = StringUtil.EMPTY;
            file_data_vanat_json += "{\n";
            
            if (package.length > 0) {
                file_data_vanat_json += StringUtil.format(StringUtil.SPACE, StringUtil.EMPTY, 4, true) + "\"name\": \"" + package + "\"" + StringUtil.BREAK_LINE;    
            }
            
            if (description.length > 0) {
                file_data_vanat_json += StringUtil.format(StringUtil.SPACE, StringUtil.EMPTY, 4, true) + "\"description\": \"" + description + "\"" + StringUtil.BREAK_LINE;
            }

            if (version.length > 0) {
                file_data_vanat_json += StringUtil.format(StringUtil.SPACE, StringUtil.EMPTY, 4, true) + "\"version\": \"" + version + "\"" + StringUtil.BREAK_LINE;
            }

            if (author.length > 0) {
                file_data_vanat_json += StringUtil.format(StringUtil.SPACE, StringUtil.EMPTY, 4, true) + "\"author\": \"" + author + "\"" + StringUtil.BREAK_LINE;
            }

            file_data_vanat_json += StringUtil.format(StringUtil.SPACE, StringUtil.EMPTY, 4, true) + "\"require\": {}";
            file_data_vanat_json += "\n}";

            return file_data_vanat_json;
        }

        /**
         * [start_process description]
         * 
         * @return {[type]} [description]
         */
        public static InitCommand start_process () {
            return new InitCommand ();
        }
    }
}