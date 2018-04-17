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
            ConsoleUtil.write_custom_color("Welcome to the Vanat config generator", true, false, "white", "blue");
            ConsoleUtil.write_custom_color("                                     ", true, false, "white", "blue");
            
            ConsoleUtil.write(StringUtil.BREAK_LINE);
            ConsoleUtil.write_custom_color("This command will guide you through creating your vanat.json config.", true, false);

            ConsoleUtil.write(StringUtil.BREAK_LINE);


            /*File file = File.new_for_path ("vanat.json");
            try {
                FileOutputStream os = file.create (FileCreateFlags.NONE);
                os.write ("My first line\n".data);
                stdout.printf ("Created.\n");
            } catch (Error e) {
                stdout.printf ("Error: %s\n", e.message);
            }*/
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