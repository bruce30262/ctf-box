#!/usr/bin/env ruby

# bunch of setup functions

$CUR_DIR = File.expand_path(File.dirname(__FILE__))

module Myutil

    def install(package)
        system("sudo apt-get install -y #{package}")
    end

    def set_symlink(lnk, real_file)
        system("ln -sf #{real_file} #{lnk}")
    end

    def is_this_installed(cmd)
        resp = `bash -c 'type -P #{cmd}'`
        if resp.empty?
            return false
        else
            puts "#{cmd} already installed."
            return true
        end
    end

    def is_dir_exist(dir)
        return Dir.exist?(dir)
    end

    def is_file_exist(f)
        return File.file?(f)
    end

    def curl_download_to(url, to)
        puts "downloading #{url} to #{to}..."
        system("curl -fsSL #{url} -o #{to}")
    end

end
