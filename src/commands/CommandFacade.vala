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

namespace Vanat.Commands {

    /**
     * The {@code CommandFacade} class
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class CommandFacade {

        public void start_command_vanat (string arg = "") {
            VanatCommand.start_process (arg); 
        }

        public void start_command_about () {
            AboutCommand.start_process (); 
        }

        public void start_command_create_project () {
            CreateProjectCommand.start_process (); 
        }

        public void start_command_init () {
            InitCommand.start_process ();
        }

        public void start_command_install () {
            InstallCommand.start_process ();  
        }

        public void start_command_update () {
            UpdateCommand.start_process (); 
        }

        public void start_command_remove () {
            RemoveCommand.start_process ();
        }

        public void start_command_require (string arg = "") {
            RequireCommand.start_process (arg);
        }

        public void start_command_help () {
            HelpCommand.start_process ();
        }

        public void start_command_version () {
            VersionCommand.start_process ();
        }
    }
}