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

using Vanat.Commands;
using Vanat.Collections;
using Vanat.Exceptions;

namespace Vanat.Utils {

    /**
     * The {@code TextColorUtil} class handles data to be displayed on the console
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class FileUtil {

        public static void delete_directory_with_parents (GLib.File directory)  throws GLib.Error {
        	GLib.FileEnumerator enumerator = directory.enumerate_children ("standard::*", GLib.FileQueryInfoFlags.NOFOLLOW_SYMLINKS);

            GLib.FileInfo info = null;
            while ((info = enumerator.next_file ()) != null) {
                
                File child = directory.resolve_relative_path (info.get_name ());

                if (info.get_file_type () == GLib.FileType.DIRECTORY) {
                    delete_directory_with_parents (child);
                } else {
                    child.delete ();
                }
            }

            directory.delete();
        }

        public static bool copy_recursive (GLib.File src, GLib.File dest, GLib.FileCopyFlags flags = GLib.FileCopyFlags.ALL_METADATA, GLib.Cancellable? cancellable = null) throws GLib.Error {
          GLib.FileType src_type = src.query_file_type (GLib.FileQueryInfoFlags.NONE, cancellable);
          if ( src_type == GLib.FileType.DIRECTORY ) {
            dest.make_directory (cancellable);
            src.copy_attributes (dest, flags, cancellable);

            string src_path = src.get_path ();
            string dest_path = dest.get_path ();
            GLib.FileEnumerator enumerator = src.enumerate_children (GLib.FileAttribute.STANDARD_NAME, GLib.FileQueryInfoFlags.NONE, cancellable);
            for ( GLib.FileInfo? info = enumerator.next_file (cancellable) ; info != null ; info = enumerator.next_file (cancellable) ) {
              copy_recursive (
                GLib.File.new_for_path (GLib.Path.build_filename (src_path, info.get_name ())),
                GLib.File.new_for_path (GLib.Path.build_filename (dest_path, info.get_name ())),
                flags,
                cancellable);
            }
          } else if ( src_type == GLib.FileType.REGULAR ) {
            src.copy (dest, flags, cancellable);
            //message(dest.get_path ());
          }

          //permission files
          //GLib.FileUtils.chmod(dest.get_path (), 0777);

          return true;
        }

        public static void decompress (GLib.File src, string? name_folder = null,  bool delete_original = false) throws GLib.Error {
            var reader = new Archive.Read ();
            reader.support_filter_bzip2 ();
            reader.support_format_all ();

            var disk = new Archive.WriteDisk ();
            disk.set_standard_lookup ();

            reader.open_filename (src.get_path (), 4096);
            unowned Archive.Entry entry;

            var vendor_dir = Path.build_filename (Environment.get_current_dir ().concat("/vendor/"));
            var name_extracted_folder = "";

            while (reader.next_header (out entry) == Archive.Result.OK) {
                entry.set_pathname (vendor_dir.concat(entry.pathname ()));

                if (StringUtil.is_blank(name_extracted_folder)) {
                     name_extracted_folder = entry.pathname ();
                }

                if(disk.write_header (entry) != Archive.Result.OK) {
                    continue;
                };

                void* buffer = null;
                size_t buffer_length;
                Posix.off_t offset;

                if (entry.size () > 0) {
                    while (reader.read_data_block(out buffer, out offset) != Archive.Result.EOF) {
                        disk.write_data_block((uint8[]) buffer, offset);
                    }
                }
            }

            if (!StringUtil.is_blank(name_folder)) {
                File extracted_folder = File.new_for_path (name_extracted_folder);
                File new_folder = File.new_for_path (vendor_dir.concat(name_folder));
                FileUtil.copy_recursive(extracted_folder, new_folder);
                FileUtil.delete_directory_with_parents (extracted_folder);
            }

            if (delete_original) {
                src.delete();
            }
        }

        public static bool file_ends_with(File file, string extension) {
            string str = file.get_basename ();
            int i = str.last_index_of (".");
            
            if (str.substring (i + 1) == extension) {
                return true;
            } else if (str.substring (i + 1) == extension.substring (1)) {
                return true;
            }

            return false;
        }

        public string? get_checksum256 (string uri) {
            File file = File.new_for_uri(uri);
            if (!file.query_exists()) {               
                error("The json file of the url does not exist\n");
            }

            Checksum checksum = new Checksum (ChecksumType.SHA256);
            FileStream stream = FileStream.open (file.get_path (), "r");
            uint8 fbuf[100];
            size_t size;

            while ((size = stream.read (fbuf)) > 0) {
                checksum.update (fbuf, size);
            }
            
            return checksum.get_string ();
        }
    }
}
