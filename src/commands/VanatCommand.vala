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
    public class VanatCommand {
     
        /**
         * [start_process description]
         * 
         * @return {[type]} [description]
         */
        public VanatCommand (string arg = "") {
            ConsoleUtil.write_custom_color("                *  |*\\                            ", true, false, "white");
            ConsoleUtil.write_custom_color("                   ||_\\                 *         ", true, false, "white");
            ConsoleUtil.write_custom_color("       *           ||__\\      *                   ", true, false, "white");
            ConsoleUtil.write_custom_color("                   ||___\\                         ", true, false, "white");
            ConsoleUtil.write_custom_color("             *     ||____\\                        ", true, false, "white");
            ConsoleUtil.write_custom_color("                   ||_____\\  *                    ", true, false, "white");
            ConsoleUtil.write_custom_color("   *               ||______\\          *           ", true, false, "white");
            ConsoleUtil.write_custom_color("     ______________||__________________________    ", true, false, "white");
            ConsoleUtil.write_custom_color("     \\                                       /    ", true, false, "white");
            ConsoleUtil.write_custom_color("~´¨¯´~\\ " + TextColorUtil.custom_color ("Vanat ~ Dependency Manager for vala", "yellow") + "/*·~-~*", true, false, "white");
            ConsoleUtil.write_custom_color("-~*´¯¨`\\___________________________________/*´¨`*·~-", true, false, "white");
            ConsoleUtil.write_custom_color(",.-~*´¨¯¨`*·~-.¸,.-~*´¨¯¨`*·~-¸,.-~*´¨¯¨`*·~-´¨¯¨`*¨¯", true, false, "white");
            ConsoleUtil.write_custom_color(".¸,.`*·~-.¸,.-~*´¨¯¨`*·~-~*´¨¯¨`*·~-´¨¯¨`*·~-~-`*·~-", true, false, "white");

            ConsoleUtil.write(StringUtil.BREAK_LINE);
            VersionCommand.start_process ();
        }

        /**
         * [start_process description]
         * 
         * @return {[type]} [description]
         */
        public static VanatCommand start_process (string arg = "") {
            return new VanatCommand (arg);
        }
    }
}