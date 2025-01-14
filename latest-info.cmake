function(_pmm_changes version)
    if (PMM_VERSION VERSION_LESS version)
        message(STATUS "[pmm]  - Changes in ${version}:")
        foreach (change IN LISTS ARGN)
            message(STATUS "[pmm]     - ${change}")
        endforeach ()
    endif ()
endfunction()

set(PMM_LATEST_VERSION 1.6.0)

if (PMM_VERSION VERSION_LESS PMM_LATEST_VERSION AND NOT PMM_IGNORE_NEW_VERSION)
    message(STATUS "[pmm] You are using PMM version ${PMM_VERSION}. The latest is ${PMM_LATEST_VERSION}.")
    message(STATUS "[pmm] Changes since ${PMM_VERSION} include the following:")
    _pmm_changes(0.2.0
            "Automatic update checks"
            "CONAN uses the `cmake` generator and automatically defines imported targets"
            "SETTINGS for Conan"
            "OPTIONS for Conan"
            "BUILD for setting the Conan install '--build' option"
            )
    _pmm_changes(0.3.0
            "MSVC Support and Fixes"
            )
    _pmm_changes(0.3.1
            "Install virtualenv in a user-local path"
            )
    _pmm_changes(0.4.0
            "Some utilities when running as `cmake -P pmm.cmake`"
            "Pass `build_type` setting to Conan"
            "[Windows] Install to Local AppData instead of Roaming"
            )
    _pmm_changes(1.0.0
            "Support for vcpkg"
            )
    _pmm_changes(1.0.1
            "Fixes for building a CMake project inside of the Conan local cache"
            )
    _pmm_changes(1.0.2
            "DEBUG and VERBOSE logging options."
            )
    _pmm_changes(1.0.3
            "Fix using Conan with a too-new GCC version: Only use the major version on GCC 5 and later"
            )
    _pmm_changes(1.1.0
            "Support a REMOTES argument in Conan mode to add remotes before performing installation"
            )
    _pmm_changes(1.1.1
            "[experimental] Preliminary support for libman"
            "Now installs latest supported version of Conan rather than a specific version"
            )
    _pmm_changes(1.2.0
            "Fix issues with finding Python in some Windows setups"
            "CMakeCM support"
            )
    _pmm_changes(1.3.0
            "/Install, /Upgrade, and /Uninstall arguments to the script to support controlling PMM's Conan installation"
            "pmm(CONAN) args: BINCRAFTERS and COMMUNITY to enable the Bincrafters and conan-community repositories, respectively"
            "Generate a Conan profile file in the build directory for use by the user, instead of passing all command line args"
            "Don't try to re-download already obtained files"
            "Respect PYENV_ROOT when looking for Python"
            "PMM DEBUG mode now prints all external commands that it executes"
            "PMM DEBUG prints debugging information from vcpkg bootstrap"
            )
    _pmm_changes(1.3.1
            "Fix changes to build settings and options not triggering a Conan installation"
            )
    _pmm_changes(1.4.0
            "Fixed missing os_build && arch_build from conan profile"
            "Added support for VS 2019"
            "Fixed finding python on AppVeyor"
            "Added VCPKG PORTS for copying custom ports"
            )
    _pmm_changes(1.4.1
            "Added Clean helper command"
            )
    _pmm_changes(1.4.2
            "Upgrade to Conan 1.16"
            )
    _pmm_changes(1.4.3
            "Upgrade to Conan 1.17"
            "Fixed latest version"
            )
    _pmm_changes(1.5.0
            "Upgrade to Conan 1.18"
            "Added support for Conan cmake_multi generator"
            )
    _pmm_changes(1.5.1
            "Fixed vcpkg not reporting package install status"
            )
    _pmm_changes(1.6.0
            "Fixed PMM continuing if one of the cmake_multi builds failed"
            "Added support for custom Conan profiles"
            )
    message(STATUS "[pmm] To update, simply change the value of PMM_VERSION_INIT in pmm.cmake")
    message(STATUS "[pmm] You can disable these messages by setting PMM_IGNORE_NEW_VERSION to TRUE before including pmm.cmake")
endif ()

if (NOT DEFINED _PMM_BOOTSTRAP_VERSION OR _PMM_BOOTSTRAP_VERSION LESS 1)
    message(STATUS "[pmm] NOTE: pmm.cmake has changed! Please download a new pmm.cmake from the PMM repository.")
endif ()
