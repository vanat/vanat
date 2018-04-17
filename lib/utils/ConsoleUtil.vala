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
        public static void write (string s) {
            stdout.printf (@"$s\n");
        }
    
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
            stdout.printf (@"$s\n");
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
         * [write_custom_color description]
         * @param  {[type]}  string key           [description]
         * @param  {[type]}  string value         [description]
         * @param  {Boolean} bool   break_line    [description]
         * @param  {Boolean} bool   space_init    [description]
         * @return {[type]}         [description]
         */
        public static void write_custom_color (string key, string value, bool break_line = false, bool space_init = false) {
            string text_to_be_printed =  TextColorUtil.custom_color (key, value);

            if (break_line) {
                if (space_init) {
                    stdout.printf("  " + text_to_be_printed + "\n");
                } else {
                    stdout.printf(text_to_be_printed + "\n");
                }
            }else {
                if (space_init) {
                    stdout.printf("  " + text_to_be_printed);
                } else {
                    stdout.printf(text_to_be_printed);
                }    
            }            
        }

        /**
         * [write_custom_color_map description]
         * @param  {[type]} LinkedHashMap<string, string>       list [description]
         * @return {[type]}                       [description]
         */
        public static void write_custom_color_map (LinkedHashMap<string, string> list) {
            foreach (string key in list.keys) {
                string text_to_be_printed =  TextColorUtil.custom_color (key, list.get(key));
                stdout.printf (text_to_be_printed);                
            }

            stdout.printf(StringUtil.BREAK_LINE);
        }

        /**
         * [write_title_custom_color description]
         * @param  {[type]} string value         [description]
         * @return {[type]}        [description]
         */
        public static void write_title_custom_color (string value) {
            string text_to_be_printed =  TextColorUtil.custom_color ("yellow", value);
            stdout.printf(StringUtil.BREAK_LINE + text_to_be_printed + StringUtil.BREAK_LINE);
        }

        /**
         * [write_option_custom_color description]
         * @param  {[type]} LinkedHashMap<K,V> list          [description]
         * @return {[type]}                    [description]
         */
        public static void write_options_custom_color (LinkedHashMap<string,string> list) {

            int max_value_length = 0;

            foreach (string option in list.keys) {
                if(option.length > max_value_length) {
                    max_value_length = option.length;
                }
            }

            foreach (string option in list.keys) {
                write_custom_color("green", StringUtil.format(StringUtil.SPACE, option, max_value_length), false, true);
                write_custom_color("white", list.get(option), true, false);
            }
        }
    }
}