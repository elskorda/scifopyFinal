#!/usr/bin/env python

import os, sys, subprocess, platform, shutil

pydistutils_cfg_template = """[build]
compiler=mingw32"""

def cmd(cmd):
    cp = subprocess.run(cmd, shell=True, capture_output=True)
    if platform.system() == "Windows":
        return cp.stdout.split("\r\n")
    else:
        return cp.stdout.split("\n")

def cmd_l(cmd):
    cp = subprocess.run(cmd, shell=True)

def create_build_dir(build_dir="build"):
    if os.path.exists(build_dir):
        print("Removing existing build directory")
        shutil.rmtree("./%s" % build_dir)
    
    os.mkdir(build_dir)

    return os.path.abspath(build_dir)

def check_build_dir(build_dir="build"):
    if not os.path.exists(build_dir):
        print("No build directory. Please configure first.")
        return ""
    else:
        return os.path.abspath(build_dir)

def setup_pydistutils_win():
    user_profile_path = os.environ["USERPROFILE"]

    with open(os.path.join(user_profile_path, "pydistutils.cfg"), "w") as f:
        f.write(pydistutils_cfg_template)

def configure_and_build(build_dir="build"):
     
    curr_cwd = os.getcwd()
    os.chdir(build_dir)

    if platform.system() == "Windows":
        setup_pydistutils_win()
        cmd_l('cmake -G"MinGW Makefiles" ..')
        cmd_l('mingw32-make')
    else:
        cmd_l('cmake ..')
        cmd_l('make')

    os.chdir(curr_cwd)

def build(build_dir="build"):

    curr_cwd = os.getcwd()
    os.chdir(build_dir)

    if platform.system() == "Windows":
        cmd_l('mingw32-make')
    else:
        cmd_l('make')

    os.chdir(curr_cwd)

def setup_run_dir(run_dir="bin"):
    if os.path.exists(run_dir):
        print("Removing existing run directory")
        shutil.rmtree("./%s" % run_dir)
    
    os.mkdir(run_dir)

    return os.path.abspath(run_dir)

def copy_runtime_files(build_dir, run_dir):
    if platform.system() == "Windows":
        cmd_l("copy %s\\*.pyd %s" % (build_dir, run_dir))
        cmd_l("copy %s\\*.dll %s" % (build_dir, run_dir))
        cmd_l("copy %s\\*.exe %s" % (build_dir, run_dir))
    else:
        cmd_l("cp %s/*.so %s" % (build_dir, run_dir))
        cmd_l("cp %s/particles %s" % (build_dir, run_dir))


if __name__ == "__main__":

    if len(sys.argv)==1:
        print("Configuring and building application...")
        build_dir = create_build_dir()
        print("Builddir:", build_dir)
        configure_and_build(build_dir)
        run_dir = setup_run_dir()
        copy_runtime_files(build_dir, run_dir)
    elif sys.argv[1]=="build":
        print("Building application...")
        build_dir = check_build_dir()
        if build_dir == "":
            sys.exit(-1)
        
        print("Builddir:", build_dir)
        build(build_dir)
        run_dir = setup_run_dir()
        copy_runtime_files(build_dir, run_dir)


