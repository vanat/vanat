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

namespace Vanat {

    /**
     * This {@code Application} class is for working on command line.
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class Application : GLib.Application {

        /**
         * This property will be true if the option entered 
         * by user is to create a new project.
         * Variable static of type {@code bool} as declared.
         */
        private static bool is_create_project;

        /**
         * This property is true if the option entered 
         * by the user is `init`.
         * Variable static of type {@code bool} as declared.
         */
        private static bool is_init;

        /**
         * This property is true if the option entered 
         * by the user is `install`.
         * Variable static of type {@code bool} as declared.
         */
        private static bool is_install;      

        /**
         * This property is true if the option entered 
         * by the user is `update`.
         * Variable static of type {@code bool} as declared.
         */
        private static bool is_update;

        /**
         * This property is true if the option entered 
         * by the user is `remove`.
         * Variable static of type {@code bool} as declared.
         */
        private static bool is_remove;

        /**
         * This property is true if the option entered 
         * by the user is `help`.
         * Variable static of type {@code bool} as declared.
         */
        private static bool is_help;

        /**
         * This property is true if the option entered 
         * by the user is `version`.
         * Variable static of type {@code bool} as declared.
         */
        private static bool is_version;

        /**
         * Defines which options are accepted by the commandline option parser.
         * @type {OptionEntry}
         */
        private const OptionEntry[] options = {            
            { "create-project" , 0   , 0 , OptionArg.NONE , ref is_create_project , "Create new project from a package into given directory."                                                   , null },
            { "init"           , 0   , 0 , OptionArg.NONE , ref is_init           , "Creates a basic vanat.json file in current directory."                                                     , null },
            { "install"        , 0   , 0 , OptionArg.NONE , ref is_install        , "Installs the project dependencies from the vanat.lock file if present, or falls back on the vanat.json."   , null },
            { "update"         , 0   , 0 , OptionArg.NONE , ref is_update         , "Updates your dependencies to the latest version according to vanat.json, and updates the vanat.lock file." , null },
            { "remove"         , 0   , 0 , OptionArg.NONE , ref is_remove         , "Removes a package from the require."                                                                       , null },
            { "help"           , 'h' , 0 , OptionArg.NONE , ref is_help           , "Display version number"                                                                                    , null },
            { "version"        , 'v' , 0 , OptionArg.NONE , ref is_version        , "Display version number"                                                                                    , null },
            { null }
        };

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
         * @param  {@code ApplicationCommandLine} command_line
         * @return {@code int}
         */
        public override int command_line (GLib.ApplicationCommandLine command_line) {
            // We have to make an extra copy of the array, since .parse assumes
            // that it can remove strings from the array without freeing them.
            string[] args = command_line.get_arguments ();
            string*[] _args = new string[args.length];

            for (int i = 0; i < args.length; i++) {
                _args[i] = args[i];
            }

            try {
                // Structure that will define which options are supported
                // by the command line options parser.
                var option_context = new OptionContext ("- Dependency Manager for Vala");
                
                // Enables or disables automatic generation of `--help` output.
                option_context.set_help_enabled (true); 

                // A convenience function which creates a main group.
                option_context.add_main_entries (options, null);

                // Parses the command line arguments, recognizing options 
                // which have been added to this. If the parsing is successful, 
                // any parsed arguments are removed from the array and argv.length
                // and argv are updated accordingly
                unowned string[] tmp = _args;
                option_context.parse (ref tmp);
            } catch (OptionError e) {
                command_line.print (_("Error: %s") + "\n", e.message);
                command_line.print (_("Run '%s --help' to see a full list of available command line options.") + "\n", args[0]);
                return 0;
            }

            // Validate the option entered by the user
            this.typed_option ();

            return 0;
        }

        /**
         * Responsible for performing the action depending
         * on the option entered by the user.
         * 
         * @return {@code void}
         */
        private void typed_option () {
            if (is_create_project) {
                string s = "is_create_project";
                stderr.printf (@"$s\n");
            }

            if (is_init) {
               string s = "is_init";
                stderr.printf (@"$s\n");
            }

            if (is_install) {
                string s = "is_install";
                stderr.printf (@"$s\n");
            }

            if (is_update) {
                string s = "is_update";
                stderr.printf (@"$s\n");
            }

            if (is_remove) {
                string s = "is_remove";
                stderr.printf (@"$s\n");
            }

            if (is_help) {
                string s = "is_help";
                stderr.printf (@"$s\n");
            }

            if (is_version) {
                string s = "is_version";
                stderr.printf (@"$s\n");
            }
        }
    }
}