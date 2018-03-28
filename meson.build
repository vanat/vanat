project('vanat', ['vala', 'c'],
    version : '0.1.0',
    license: 'MIT'
)

add_project_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

gobject_dep = dependency('gobject-2.0')
glib_dep    = dependency('glib-2.0')
gee_dep     = dependency('gee-0.8')
gio_dep     = dependency('gio-2.0')
posix_dep   = meson.get_compiler('vala').find_library('posix')

subdir('lib')
subdir('src')


executable(
    meson.project_name(),
    src_files,
    dependencies: [
        lib_dependencies,
        posix_dep
    ],
    install : true
)
