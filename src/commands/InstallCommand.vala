/*
 * MIT License
 *
 * Copyright (c) 2019 Vanat 
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
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR O  THER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

using Vanat.Collections;
using Vanat.Configs;
using Vanat.Exceptions;
using Vanat.Utils;
using Vanat.VJson;

namespace Vanat.Commands {

    public class InstallCommand {
     
        public InstallCommand () {
            try {
                File vanat_json_file = File.new_for_path (Environment.get_current_dir ().concat ("/vanat.json"));                                
                if (!vanat_json_file.query_exists()) {               
                    throw new FileOrDirectoryNotFoundException.MESSAGE("File doesn't exists\n");
                }

                ConsoleUtil.write_custom_color ("Loading json that are in the package", true, false, "yellow");
                DataInputStream data_stream = new DataInputStream(vanat_json_file.read());
                
                size_t length;
                string data = data_stream.read_upto (StringUtil.EMPTY, 1, out length);

                VanatJson vanat_json = new VanatJson(data);
                this.setting_vendor (vanat_json);
            } catch (Error e) {
                GLib.error("%s", e.message);
            }
        }

        private void setting_vendor (VanatJson vanat_json) throws Error {

            if(vanat_json.require.size == 0) {
                ConsoleUtil.write_custom_color ("> No packages for installation", true, false, "cyan");
                return;
            }

            File vendor_dir = File.new_for_path (Environment.get_current_dir ().concat("/vendor"));
            if (!vendor_dir.query_exists ()) {
                vendor_dir.make_directory ();
            }

            File vanat_dir = File.new_for_path (Environment.get_current_dir ().concat("/vendor/vanat"));
            if (!vanat_dir.query_exists ()) {
                vanat_dir.make_directory ();    
            }

            File installed_json_file = File.new_for_path(Environment.get_current_dir ().concat("/vendor/vanat/LICENCE.md"));
            if (!installed_json_file.query_exists ()) {
                FileOutputStream os = installed_json_file.create (FileCreateFlags.NONE);
                os.write (Constants.MIT_LICENSE.data);
            }
            
            File meson_build_file = File.new_for_path(Environment.get_current_dir ().concat("/vendor/meson.build"));
            if (!meson_build_file.query_exists ()) {
                FileOutputStream os = meson_build_file.create (FileCreateFlags.NONE);
                os.write ("# This file is @generated automatically by Vanat \n\nvendor = files(\n\n)\n".data);
            }
            
            this.download_package_recursive (vanat_json);
            ConsoleUtil.write_custom_color ("✓ Completed", true, false, "cyan");
        }

        private void download_package_recursive (VanatJson vanat_json) throws Error {

            int count = 0;

            foreach (string key in vanat_json.require.keys) {
                if (key.contains ("/")) {
                    string[] indexes = key.split("/");
                    string user_name = indexes[0];
                    string package_name = indexes[1];

                    File package_dir = File.new_for_path (Environment.get_current_dir ().concat("/vendor/").concat(package_name));
                    
                    if (package_dir.query_exists ()) {
                        ConsoleUtil.write_action (package_name, vanat_json.require.get(key), "Package already installed");
                        continue;
                    } else {
                        this.download_package(vanat_json, key, user_name, package_name);
                        count++;

                        if (count > 1) {
                            ConsoleUtil.write ("\n");
                        }
                    }
                } else {
                    throw new JsonException.INVALID_FORMAT ("'require' structure in Json is in invalid format");
                }
            }
        }

        private void download_package (VanatJson vanat_json, string key, string user_name, string package_name) throws Error {
            string repository = "com.github.".concat(user_name +  "." + package_name);
            string url = "https://raw.githubusercontent.com/vpackagist/".concat(repository).concat("/master/").concat(repository).concat(".json");
           
            File json = File.new_for_uri (url);
            if (!json.query_exists()) {               
                throw new FileOrDirectoryNotFoundException.MESSAGE("The json file of the url does not exist\n");
            }
                               
            File target = File.new_for_uri ("https://github.com/".concat(key).concat("/archive/").concat(vanat_json.require.get(key)).concat(".zip"));
            if (!target.query_exists()) {               
                throw new FileOrDirectoryNotFoundException.MESSAGE("Release ".concat(vanat_json.require.get(key)).concat(" of the ").concat(key).concat(" package does not exist\n"));
            }

            ConsoleUtil.write_action (package_name, vanat_json.require.get(key), "Installing");

            message(Environment.get_current_dir ().concat("/vendor/").concat(package_name + "-master.zip"));

            File destination_zip = File.new_for_path (Path.build_filename (Environment.get_current_dir ().concat("/vendor/").concat(package_name + "-master.zip")));
            target.copy (destination_zip, FileCopyFlags.OVERWRITE, null, null);

            FileUtil.decompress (destination_zip, package_name, true);
        }

        public static InstallCommand start_process () {
            return new InstallCommand ();
        }
    }
}