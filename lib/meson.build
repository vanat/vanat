lib_files = files(
    'collections/LinkedHashMap.vala',   
    'commands/CreateProjectCommand.vala',
    'commands/HelpCommand.vala',
    'commands/InitCommand.vala',
    'commands/InstallCommand.vala',
    'commands/RemoveCommand.vala',
    'commands/UpdateCommand.vala',
    'commands/VersionCommand.vala',
    'utils/ConsoleUtil.vala',
    'utils/TextColorUtil.vala'
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

