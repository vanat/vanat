<p align="center">
    <img width="100" height="100" src="https://raw.githubusercontent.com/vanat/brand/master/logo.png">
    <h1 align="center">Vanat</h1>
    <h3 align="center">Dependency Manager for Vala</h3>
</p>



<p align="center">
    <img src="https://img.shields.io/badge/vala-v0.36.12-yellow.svg">
    <img src="https://img.shields.io/badge/meson-v0.40-brightgreen.svg">
    <img src="https://img.shields.io/badge/stable-v0.1.0-blue.svg">
    <img src="https://img.shields.io/github/license/mashape/apistatus.svg">
</p>

### About Vanat

`Vanat` is a tool for dependency management in Vala. It allows you to declare the libraries your project depends on and it will manage (install/update) them for you. We believe development must be an enjoyable and creative experience to be truly fulfilling.

### Building, Testing, and Installation
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

### Reporting issues

Found a bug? We'd love to know about it!

Please report all issues on the github [issue tracker][issues].

[issues]: https://github.com/vanat/vanat/issues

### Contributing

Thank you for considering contributing to the Vanat! The contribution guide can be found in the [Vanat documentation](https://vanat.github.io/docs/contributions).

### License

vanat is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details
