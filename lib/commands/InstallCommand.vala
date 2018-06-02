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

using Vanat.Library.Collections;
using Vanat.Library.Exceptions;
using Vanat.Library.Utils;
using Vanat.Library.VJson;

namespace Vanat.Library.Commands {

    /**
     * The {@code InstallCommand} class
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class InstallCommand {
     
        /**
         * Constructs a new {@code InstallCommand} object 
         * and sets the default exit folder.
         */
        public InstallCommand () {
            ConsoleUtil.write_title_custom_color("InstallCommand");

            //@"https://gitlab.com/robertsanseries/com.github.robertsanseries.ffmpeg-cli-wrapper.json/raw/master/com.github.robertsanseries.ffmpeg-cli-wrapper.json"

            try {
                var file = File.new_for_path (Environment.get_current_dir ()  + "/vanat.json");

                if (!file.query_exists()) {               
                    throw new FileOrDirectoryNotFoundException.MESSAGE("File '%s' doesn't exists\n", file.get_path());
                }

                var data_stream = new DataInputStream(file.read());
                string data = data_stream.read_until (StringUtil.EMPTY, null);
                VanatJson vanat_json = new VanatJson(data);

                foreach (string key in vanat_json.require.keys) {
                    string package;
                    string repository;

                    if (key.contains ("/")) {
                        string[] indexes = key.split("/");
                        package = indexes[0] +  "." + indexes[1];

                        repository = "com.github.".concat(package);
                        string url = "https://gitlab.com/".concat(indexes[0])
                                        .concat("/")
                                        .concat(repository)
                                        .concat(".json/raw/master/")
                                        .concat(repository)
                                        .concat(".json");

                        ConsoleUtil.write_custom_color ("Loading json dependencies that are in vpackage", true, false, "while");
                        

                        var json = File.new_for_uri (url);

                        if (!json.query_exists()) {               
                            throw new FileOrDirectoryNotFoundException.MESSAGE("File '%s' doesn't exists\n", json.get_path());
                        }

                        var data_stream_repository = new DataInputStream(json.read());
                        string data_repository = data_stream_repository.read_until (StringUtil.EMPTY, null);                     

                        File vendor_dir = File.new_for_path (Environment.get_current_dir ().concat("/vendor/").concat(indexes[1]));

                        if (vendor_dir.query_exists()) {
                            ConsoleUtil.write_action (indexes[1], vanat_json.require.get(key), "Deleting");
                            FileUtil.delete_directory_with_parents(vendor_dir);
                        }

                        vendor_dir.make_directory_with_parents ();

                        ConsoleUtil.write_action (indexes[1], vanat_json.require.get(key), "Installing");
                    }
                }
            }catch(Error e) {
                error("%s", e.message);
            }
        }

        /**
         * [start_process description]
         * 
         * @return {[type]} [description]
         */
        public static InstallCommand start_process () {
            return new InstallCommand ();
        }
    }
}