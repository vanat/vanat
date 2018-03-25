# Valet

`Valet` is a dependency management tool for Vala.

## Building, Testing, and Installation
You'll need the following dependencies:

    vala (>=0.36)
    meson (>=0.40)
    gobject-2.0
    glib-2.0
    gee-0.8


Run meson build to configure the build environment. Change to the build directory and run ninja test to build and run automated tests

    meson build --prefix=/usr
    cd build
    ninja test

To install, use ninja install, then execute with `valet`

    sudo ninja install
    valet

## Reporting issues

Found a bug? We'd love to know about it!

Please report all issues on the github [issue tracker][issues].

[issues]: https://github.com/valet-dependency-manager/valet/issues

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). You may also find the arhitecture
documentation useful ([ARCHITECTURE.md](ARCHITECTURE.md)).

## License

Composer is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details