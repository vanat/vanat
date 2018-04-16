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

using Vanat.Library.Commands;
using Vanat.Library.Collections;

namespace Vanat.Library.Utils {

    /**
     * The {@code ConsoleUtil} class handles data to be displayed on the console
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class ConsoleUtil {
     
        /**
         * Responsible for printing on the console of the information
         * message passed by the parameter.
         *
         * Exemple:
         * > ConsoleUtil.info("test info");
         * 
         * @param  {@code string} s
         * @return {@code void}
         */
        public static void info (string s) {
            stderr.printf (@"$s\n");
        }

        /**
         * Responsible for printing on the console of the error
         * message passed by the parameter.
         *
         * Exemple:
         * > ConsoleUtil.error("test error");
         * 
         * @param  {@code string} s
         * @return {@code void}
         */
        public static void error (string s) {
            stderr.printf (@"\x1b[31m$s\x1b[0m\n");
        }

        /**
         * Responsible for printing on the console of the information
         * message passed by the parameter.
         *
         * Exemple:
         * > ConsoleUtil.write_custom_color("test info");
         * 
         * @param  {@code string} s
         * @return {@code void}
         */
        public static void write_custom_color (LinkedHashMap<string, string> list) {
            foreach (string key in list.keys) {
                string text_to_be_printed =  TextColorUtil.custom_color (key, list.get(key));
                stderr.printf ("%s" , text_to_be_printed);                
            }

            stderr.printf("\n");
        }
    }
}