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

using Vanat.Library.Commands;
using Vanat.Library.Collections;

namespace Vanat.Library.Utils {

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

        public static bool copy_recursive (GLib.File src, GLib.File dest, GLib.FileCopyFlags flags = GLib.FileCopyFlags.NONE, GLib.Cancellable? cancellable = null) throws GLib.Error {
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
          }

          return true;
        }
    }
}
