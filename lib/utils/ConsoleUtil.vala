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
         * /
        public static void write_custom_color (LinkedHashMap<string, string> list) {
            string text_to_be_printed = custom_color(list);
            stderr.printf (@"$text_to_be_printed\n");
        }

        /**
         * Custom text color
         *
         * Escape sequence - Foreground colors
         * \x1b[30m    Black
         * \x1b[31m    Red
         * \x1b[32m    Green
         * \x1b[33m    Yellow
         * \x1b[34m    Blue
         * \x1b[35m    Magenta
         * \x1b[36m    Cyan
         * \x1b[37m    White
         * \x1b[39m    Default(foreground color at startup)
         *
         * Exemple:
         * > ConsoleUtil.custom_color();
         * 
         * 
         * @param  {@code string} s
         * @return {@code void}
         * /
        private static string custom_color (LinkedHashMap<string, string> list) {
            string text_temp = "";

            foreach (var item in list.entries) {
                switch (item.key) {
                    case "black":
                        var t = item.value;
                        text_temp = text_temp.concat(@"\x1b[30m$t\x1b[0m").concat(" ");
                        break;
                    case "red":
                        var t = item.value;
                        text_temp = text_temp.concat(@"\x1b[31m$t\x1b[0m").concat(" ");
                        break;
                    case "green":
                        var t = item.value;
                        text_temp = text_temp.concat(@"\x1b[32m$t\x1b[0m").concat(" ");
                        break;
                    case "yellow":
                        var t = item.value;
                        text_temp = text_temp.concat(@"\x1b[33m$t\x1b[0m").concat(" ");
                        break;
                    case "blue":
                        var t = item.value;
                        text_temp = text_temp.concat(@"\x1b[34m$t\x1b[0m").concat(" ");
                        break;
                    case "magenta":
                        var t = item.value;
                        text_temp = text_temp.concat(@"\x1b[35m$t\x1b[0m").concat(" ");
                        break;
                    case "cyan":
                        var t = item.value;
                        text_temp = text_temp.concat(@"\x1b[36m$t\x1b[0m").concat(" ");
                        break;
                    case "white":
                        var t = item.value;
                        text_temp = text_temp.concat(@"\x1b[37m$t\x1b[0m").concat(" ");
                        break;
                    default:
                        var t = item.value;
                        text_temp = text_temp.concat(@"\x1b[39m$t\x1b[0m").concat(" ");
                        break;
                }
            }

            return text_temp;
        }
        */
    }
}