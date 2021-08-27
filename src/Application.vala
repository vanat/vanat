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
using Vanat.Commands;

namespace Vanat {

    /**
     * This {@code Application} class is for working on command line.
     *
     * @see Vanat.Commands.CommandFacade
     * @author Robert San
     * @since 0.1.0
     */
    public class Application : GLib.Application {

        private CommandFacade commands;

        /**
         * Constructs a new {@code Application} object.
         */
        public Application (CommandFacade command_facade) {
            Object (
                application_id: "com.github.vanat",
                flags: ApplicationFlags.HANDLES_COMMAND_LINE
            );

            this.commands = command_facade;
        }

        /**
         * The command_line signal is issued immediately after the object 
         * is created to process the typed arguments.
         *
         * @param  {@code ApplicationCommandLine} command_line
         * @return {@code int}
         */
        public override int command_line (GLib.ApplicationCommandLine command_line) {
            string[] args = command_line.get_arguments ();

            if (args.length < 2) {
                this.commands.start_command_vanat (args[0]);
                this.commands.start_command_help ();
                return 0;
            }
               
            this.typed_option (args);
            return 0;
        }

        /**
         * Responsible for performing the action depending
         * on the option entered by the user.
         *
         * @return {@code void}
         */
        private void typed_option (string[] args) {
            switch (args[1]) {
                case "about":
                    this.commands.start_command_about ();
                    break;
                case "create-project":
                    this.commands.start_command_create_project ();
                    break;
                case "init":
                    this.commands.start_command_init ();
                    break;
                case "install":
                    this.commands.start_command_install ();
                    break;
                case "update":
                    this.commands.start_command_update ();
                    break;
                case "remove":
                    this.commands.start_command_remove ();
                    break;
                case "require":
                    if (args[2] != null) {
                        this.commands.start_command_require (args[2]);
                    } else {
                        ConsoleUtil.write_custom_color("Ops! You forgot to enter the package name to be added!", true, false, "red");
                    }                    
                    break;
                case "-h":
                case "help":
                case "--help":
                case "list":
                    this.commands.start_command_help ();
                    break;
                case "-v":
                case "--version":
                    this.commands.start_command_version ();
                    break;
                default:
                    this.commands.start_command_help ();
                    break;
            }
        }
    }
}