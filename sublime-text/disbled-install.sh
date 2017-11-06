#!/usr/bin/env php
<?php
/**
 * Installs Sublime package manager
 * Symlinks config files
 */

// Setup directories
if (exec('echo `uname`') == 'Darwin') {
    $sublPrefsDir = $_SERVER['HOME'] . "/Library/Application Support/Sublime Text 3";
} else {
    die("ERROR ... TODO configure for linux.");
}

$dirs = [
    $sublPrefsDir . "/Installed Packages",
    $sublPrefsDir . "/Packages/User"
];

foreach ($dirs as $dir) {
    if (!file_exists($dir)) mkdir($dir, 0700, true);
}


// Symlink files
symlinkFilesRecursively($_SERVER['HOME'] . "/.dotfiles/sublime-text", $sublPrefsDir);



function symlinkFilesRecursively($src, $dest) {
    foreach (new DirectoryIterator($src) as $fileInfo) {
        if ($fileInfo->isDot()) continue;

        if (is_dir($fileInfo->getPathName())) {
            symlinkFilesRecursively($fileInfo->getPathName(), $dest . '/' . $fileInfo->getFileName());
        }

        if (preg_match('/\.symlink$/', $fileInfo->getPathName())) {
            // symlink(target, link)
            $target = $fileInfo->getPathName();
            $link= $dest . '/' . substr($fileInfo->getFileName(), 0, -8);
            if (is_link($link)) unlink($link);
            symlink($target, $link);
        }
    }
}


// Install the Sublime package manager
$dest = $sublPrefsDir . "/Installed Packages/Package Control.sublime-package";
if (!file_exists($dest)) {
    $cmd = 'curl -o "'.$dest.'" http://sublime.wbond.net/Package%20Control.sublime-package';
    return exec($cmd);
}
# if [[ ! -f ${DIR}/Installed\ Packages/Package\ Control.sublime-package ]]; then
#     curl -o "${DIR}/Installed Packages/Package Control.sublime-package" http://sublime.wbond.net/Package%20Control.sublime-package
# else
#     exit 0
# fi
