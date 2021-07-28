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

using Vanat.Commands;

namespace Vanat.Utils {

    /**
     * The {@code TextColorUtil} class handles data to be displayed on the console
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class TextColorUtil {

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
         * > TextColorUtil.custom_color();
         * 
         * 
         * @param  {@code string} s
         * @return {@code void}
         */
        public static string custom_color (string value, string text_color = "", string background_color = "") {
        	string SPACE = " ";
            string text_temp = "";

            switch (text_color) {
                case "black":
                    text_temp = text_temp.concat(@"\x1b[30m$value\x1b[0m").concat(SPACE);
                    break;
                case "red":
                    text_temp = text_temp.concat(@"\x1b[31m$value\x1b[0m").concat(SPACE);
                    break;
                case "green":
                    text_temp = text_temp.concat(@"\x1b[32m$value\x1b[0m").concat(SPACE);
                    break;
                case "yellow":
                    text_temp = text_temp.concat(@"\x1b[33m$value\x1b[0m").concat(SPACE);
                    break;
                case "blue":
                    text_temp = text_temp.concat(@"\x1b[34m$value\x1b[0m").concat(SPACE);
                    break;
                case "magenta":
                    text_temp = text_temp.concat(@"\x1b[35m$value\x1b[0m").concat(SPACE);
                    break;
                case "cyan":
                    text_temp = text_temp.concat(@"\x1b[36m$value\x1b[0m").concat(SPACE);
                    break;
                case "white":
                    text_temp = text_temp.concat(@"\x1b[37m$value\x1b[0m").concat(SPACE);
                    break;
                default:
                    text_temp = text_temp.concat(@"$value").concat(SPACE);
                    break;
            }

            switch (background_color) {
                case "black":
                    text_temp = @"\x1b[40m$text_temp\x1b[0m";
                    break;
                case "red":
                    text_temp = @"\x1b[41m$text_temp\x1b[0m";
                    break;
                case "green":
                    text_temp = @"\x1b[42m$text_temp\x1b[0m";
                    break;
                case "yellow":
                    text_temp = @"\x1b[43m$text_temp\x1b[0m";
                    break;
                case "blue":
                    text_temp = @"\x1b[44m$text_temp\x1b[0m";
                    break;
                case "magenta":
                    text_temp = @"\x1b[45m$text_temp\x1b[0m";
                    break;
                case "cyan":
                    text_temp = @"\x1b[46m$text_temp\x1b[0m";
                    break;
                case "white":
                    text_temp = @"\x1b[47m$text_temp\x1b[0m";
                    break;
                default:
                    text_temp = @"$text_temp";
                    break;
            }

            return text_temp;
        }
    }
}
