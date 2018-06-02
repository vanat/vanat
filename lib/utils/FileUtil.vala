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
    }
}
