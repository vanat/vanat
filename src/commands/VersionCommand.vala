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
     * The {@code VersionCommand} class
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class VersionCommand {

        /**
         * Constructs a new {@code VersionCommand} object 
         * and sets the default exit folder.
         */
        public VersionCommand () {
            LinkedHashMap<string, string> msg = new LinkedHashMap<string, string>();
            msg.set("Vanat", "green");
            msg.set("version", "white");
            msg.set("0.1.0", "yellow");
            msg.set("2021-08-26 16:17:23", "cyan");
            ConsoleUtil.write_custom_color_map(msg);
        }
     
        /**
         * [start_process description]
         * 
         * @return {[type]} [description]
         */
        public static VersionCommand start_process () {
            return new VersionCommand ();
        }
    }
}