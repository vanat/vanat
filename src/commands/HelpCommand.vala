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
using Vanat.Collections;

namespace Vanat.Commands {

    /**
     * The {@code HelpCommand} class
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class HelpCommand {
     
        /**
         * [start_process description]
         * 
         * @return {[type]} [description]
         */
        public HelpCommand () {
            LinkedHashMap<string, string> options = new LinkedHashMap<string, string>();
            options.set("-h, --help", "Display this help message");
            options.set("-v, --version", "Display this application version");

            LinkedHashMap<string, string> available_commands = new LinkedHashMap<string, string>();
            available_commands.set("about", "Short information about Vanat");
            //available_commands.set("create-project", "Create new project from a package into given directory.");
            available_commands.set("help", "Display this help message");
            available_commands.set("init", "Creates a basic vanat.json file in current directory.");
            //available_commands.set("install", "Installs the project dependencies from the vanat.lock file if present, or falls back on the vanat.json.");
            available_commands.set("install", "Installs the project dependencies from the vanat.json.");
            available_commands.set("list", "Lists commands");
            //available_commands.set("remove", "Removes a package from the require.");
            //available_commands.set("require", "Adds required packages to your vanat.json and installs them");
            //available_commands.set("update", "Updates your dependencies to the latest version according to vanat.json, and updates the vanat.lock file.");

            ConsoleUtil.write_title_custom_color("Usage:");
            ConsoleUtil.write_custom_color("command [options] [arguments]", true, true, "white");

            ConsoleUtil.write_title_custom_color("Options:");
            ConsoleUtil.write_options_custom_color(options);

            ConsoleUtil.write_title_custom_color("Available commands:");
            ConsoleUtil.write_options_custom_color(available_commands);
        }

        /**
         * [start_process description]
         * 
         * @return {[type]} [description]
         */
        public static HelpCommand start_process () {
            return new HelpCommand ();
        }
    }
}