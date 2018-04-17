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
using Vanat.Library.Commands;

namespace Vanat {

    /**
     * This {@code Application} class is for working on command line.
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class Application : GLib.Application {

        /**
         * Constructs a new {@code Application} object 
         * and sets the default exit folder.
         */
        public Application () {
            Object (
                application_id: "com.github.vanat",
                flags: ApplicationFlags.HANDLES_COMMAND_LINE
            );
        }

        /**
         * The command_line signal is issued immediately after the object 
         * is created to process the typed arguments.
         *
         * @see Vanat.Library.Commands.ConsoleUtil#error
         * @see Vanat.Library.Commands.ConsoleUtil#info
         * @param  {@code ApplicationCommandLine} command_line
         * @return {@code int}
         */
        public override int command_line (GLib.ApplicationCommandLine command_line) {
            // Gets the arguments entered by the user
            string[] args = command_line.get_arguments ();

            // If the user does not enter any arguments, the message is displayed.
            if (args.length < 2) {
                VanatCommand.start_process (args[0]);
                return 0;
            }
               
            this.typed_option (args[1]);
            return 0;
        }

        /**
         * Responsible for performing the action depending
         * on the option entered by the user.
         *
         * @see Vanat.Library.Commands.CreateProjectCommand
         * @see Vanat.Library.Commands.InitCommand
         * @see Vanat.Library.Commands.InstallCommand
         * @see Vanat.Library.Commands.UpdateCommand
         * @see Vanat.Library.Commands.RemoveCommand
         * @see Vanat.Library.Commands.HelpCommand
         * @see Vanat.Library.Commands.VersionCommand
         * @return {@code void}
         */
        private void typed_option (string arg) {
            switch (arg) {
                case "about":
                    AboutCommand.start_process ();
                    break;
                case "create-project":
                    CreateProjectCommand.start_process ();
                    break;
                case "init":
                    InitCommand.start_process ();
                    break;
                case "install":
                    InstallCommand.start_process (); 
                    break;
                case "update":
                    UpdateCommand.start_process ();
                    break;
                case "remove":
                    RemoveCommand.start_process ();
                    break;
                case "require":
                    RequireCommand.start_process ();
                    break;
                case "-h":
                case "--help":
                case "list":
                    HelpCommand.start_process ();
                    break;
                case "-v":
                case "--version":
                    VersionCommand.start_process ();
                    break;
                default:
                    HelpCommand.start_process ();
                    break;
            }
        }
    }
}