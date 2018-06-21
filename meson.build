project('vanat', ['vala', 'c'],
    version : '0.1.0',
    license: 'MIT'
)

add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')], language: 'vala')

subdir('src')

executable(
    meson.project_name(),
    src_files,
    dependencies: [
        dependency('gobject-2.0'),
        dependency('glib-2.0'),
        dependency('gee-0.8'),
        dependency('gio-2.0'),
        dependency('libarchive'),
        dependency('libsoup-2.4'),
        dependency('json-glib-1.0'),
    ],
    vala_args: [
        '--vapidir=' + meson.source_root() + '/vapi/',
    ],
    install : true
)