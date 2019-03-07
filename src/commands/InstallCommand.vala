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

using Vanat.Collections;
using Vanat.Exceptions;
using Vanat.Utils;
using Vanat.VJson;

namespace Vanat.Commands {

    /**
     * The {@code InstallCommand} class
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class InstallCommand {
     
        public InstallCommand () {
            try {
                File vanat_json_file = File.new_for_path (Environment.get_current_dir ().concat ("/vanat.json"));
                if (!vanat_json_file.query_exists()) {               
                    throw new FileOrDirectoryNotFoundException.MESSAGE("File doesn't exists\n");
                }

                var meson_file = File.new_for_path (Environment.get_current_dir ().concat("/meson.build"));
                if (!meson_file.query_exists ()) {
                    throw new FileOrDirectoryNotFoundException.MESSAGE("File meson.build doesn't exists\n");
                }

                ConsoleUtil.write_custom_color ("Loading json that are in the package", true, false, "yellow");
                
                DataInputStream data_stream = new DataInputStream(vanat_json_file.read());
                
                size_t length;
                string data = data_stream.read_upto (StringUtil.EMPTY, 1, out length);

                VanatJson vanat_json = new VanatJson(data);
                this.setting_vendor (vanat_json);
            } catch (Error e) {
                error("%s", e.message);
            }
        }

        private void setting_vendor (VanatJson vanat_json) throws Error {
            int count = 0;           

            File vendor_dir = File.new_for_path (Environment.get_current_dir ().concat("/vendor"));
            if (!vendor_dir.query_exists ()) {
                vendor_dir.make_directory ();

                File vanat_dir = File.new_for_path (Environment.get_current_dir ().concat("/vendor/vanat"));
                if (!vanat_dir.query_exists ()) {
                    vanat_dir.make_directory ();
                    
                    File installed_json_file = File.new_for_path(Environment.get_current_dir ().concat("/vendor/vanat/installed.json"));
                    installed_json_file.create (FileCreateFlags.NONE);
                }
                
                File meson_build_file = File.new_for_path(Environment.get_current_dir ().concat("/vendor/meson.build"));
                FileOutputStream os = meson_build_file.create (FileCreateFlags.NONE);
                os.write ("vendor = files(\n\n)\n".data);
            }

            foreach (string key in vanat_json.require.keys) {
                if (key.contains ("/")) {
                    string[] indexes = key.split("/");
                    string user_name = indexes[0];
                    string package_name = indexes[1];

                    this.download_package(vanat_json, key, user_name, package_name, ref count);                    
                } else {
                    throw new JsonException.INVALID_FORMAT ("'require' structure in Json is in invalid format");
                }
            }

            if (count == 0) {
                ConsoleUtil.write_custom_color ("> Nothing to install or update", true, false, "while");
            } else {
                ConsoleUtil.write_custom_color ("✓ Completed", true, false, "cyan");
            }
        }

        private void download_package (VanatJson vanat_json, string key, string user_name, string package_name, ref int count) throws Error {
            string repository = "com.github.".concat(user_name +  "." + package_name);
            string url = "https://raw.githubusercontent.com/vpackagist/".concat(repository).concat("/master/").concat(repository).concat(".json");
           
            File json = File.new_for_uri (url);
            if (!json.query_exists()) {               
                throw new FileOrDirectoryNotFoundException.MESSAGE("The json file of the url does not exist\n");
            }

            File package_dir = File.new_for_path (Environment.get_current_dir ().concat("/vendor/").concat(package_name));
            if (package_dir.query_exists ()) {
                return;
            } else {
                count++;
            }
                                
            File target = File.new_for_uri ("https://github.com/".concat(key).concat("/archive/").concat(vanat_json.require.get(key)).concat(".zip"));
            if (!target.query_exists()) {               
                throw new FileOrDirectoryNotFoundException.MESSAGE("Release ".concat(vanat_json.require.get(key)).concat(" of the ").concat(key).concat(" package does not exist\n"));
            }

            if (count > 1) {
                ConsoleUtil.write ("\n");
            }

            ConsoleUtil.write_action (package_name, vanat_json.require.get(key), "Installing");

            File destination_zip = File.new_for_path (Path.build_filename (Environment.get_current_dir ().concat("/vendor/").concat(package_name + "-master.zip")));
            target.copy (destination_zip, FileCopyFlags.OVERWRITE, null, null);

            FileUtil.decompress (destination_zip, package_name, true);
        }

        /*private void add_package_meson_file () throws Error {

        }*/

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