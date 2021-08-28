/*
 * MIT License
 *
 * Copyright (c) 2018-2021 Vanat 
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

namespace Vanat.Utils {

    /**
     * The {@code GitConfigUtil} class
     *
     * @author Robert San
     * @since 0.1.0
     */
    public class GitConfigUtil {

        public static void initGitConfigUtil () {
            stdout.printf("global_config_file");
            var global_config_file = Ggit.Config.find_global();

            if (global_config_file == null)
            {
                ConsoleUtil.write("erro 1.1");
            } else {
                ConsoleUtil.write("erro 1.2");
            }

            // Ggit.Config? global_config;

            //  stdout.printf("global_config");
            // try
            // {
            //     global_config = new Ggit.Config.from_file(global_config_file);
            // }
            // catch
            // {
            //     stdout.printf("erro 2");
            // }
        }

        //read_config_string(config, "user.name").chomp();

        // private bool config_is_local(string name)
        //    {
        //        try
        //        {
        //            var entry = d_config.get_entry(name);
        //            return entry.get_level() == Ggit.ConfigLevel.LOCAL;
        //        }
        //        catch
        //        {
        //            return false;
        //        }
        //    }

        private string read_config_string(Ggit.Config config, string name)
        {
            string defval = "";
            string? ret = null;

            try
            {
                ret = config.snapshot().get_string(name);
            } catch {}

            return ret != null ? ret : defval;
        }

    }
}
