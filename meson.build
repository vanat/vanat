project('vanat', ['vala', 'c'],
    version : '0.1.0',
    license: 'MIT'
)

add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')], language: 'vala')

dependencies = [
    dependency('gobject-2.0'),
    dependency('glib-2.0'),
    dependency('gee-0.8'),
    dependency('gio-2.0'),
    dependency('libarchive')
]

subdir('lib')
subdir('src')

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

executable(
    meson.project_name(),
    src_files,
    dependencies: [
        lib_dependencies,
        meson.get_compiler('vala').find_library('posix'),
    ],
    vala_args: [
        '--vapidir=' + meson.source_root() + '/vapi/',
    ],
    install : true
)