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

namespace Vanat.Library.Utils {

    /**
     * The {@code TextColorUtil} class handles data to be displayed on the console
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class StringUtil {

    	/**
    	 * [SPACE description]
    	 * @type {String}
    	 */
    	public abstract const string SPACE = " ";

        /**
         * [SPACE description]
         * @type {String}
         */
        public abstract const string EMPTY = "";

    	/**
    	 * [BREAK_LINE description]
    	 * @type {String}
    	 */
    	public abstract const string BREAK_LINE = "\n";

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
        public static string format (string caracter, string value, int max_length, bool init = false) {

        	int count = 0;
        	string text = "";

        	while (count < max_length) {
        		text += caracter;
        		count++;

        		if((value + text).length > max_length) {
        			break;
        		}
        	}

        	if (init) {
        		return text + value;
        	} else {
        		return value + text;
        	}
        }
    }
}
