lib_files = files(
    
)

dependencies = [
    gobject_dep,
    glib_dep,
    gee_dep,
    gio_dep
]

libraries = shared_library(
    'vanat-0.1.0',
    lib_files,
    dependencies : dependencies,
    install : true
)

lib_dependencies = declare_dependency(
    dependencies: dependencies,
    link_with : libraries,
    include_directories: include_directories('.')
)
