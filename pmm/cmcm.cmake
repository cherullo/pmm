function(_pmm_cmcm)
    _pmm_parse_args(
        . ROLLING
        - FROM
        )
    if(NOT ARG_FROM)
        if(NOT ARG_ROLLING)
            message(FATAL_ERROR "You must specify either ROLLING or FROM <url> for CMakeCM")
        endif()
        set(ARG_FROM "https://AnotherFoxGuy.com/CMakeCM")
    else()
        if(ARG_ROLLING)
            message(FATAL_ERROR "Cannot specify both ROLLING and FROM for CMakeCM")
        endif()
    endif()
    string(MD5 hash "${ARG_FROM}")
    string(SUBSTRING "${hash}" 0 6 hash)
    get_filename_component(_cmcm_index_cmake "${_PMM_USER_DATA_DIR}/${hash}-CMakeCM.cmake" ABSOLUTE)
    _pmm_log(VERBOSE "CMakeCM index is ${_cmcm_index_cmake}")
    set(download_index FALSE)
    set(have_file FALSE)
    if(NOT EXISTS "${_cmcm_index_cmake}")
        set(download_index TRUE)
    else()
        set(have_file TRUE)
        file(TIMESTAMP "${_cmcm_index_cmake}" mtime "%s")
        string(TIMESTAMP now "%s")
        math(EXPR age "${now} - ${mtime}")
        if(age GREATER 180)
            set(download_index TRUE)
        endif()
    endif()
    if(download_index)
        _pmm_download(
            "${ARG_FROM}/CMakeCM.cmake"
            "${_cmcm_index_cmake}"
            NO_CHECK
            RESULT_VARIABLE
            did_download
            )
        if(NOT did_download)
            if(have_file)
                _pmm_log(WARNING "Didn't download the CMakeCM index. Using already-downloaded version")
            else()
                message(SEND_ERROR "Failed to download CMakeCM index")
            endif()
        endif()
    endif()
    set(CMCM_LOCAL_RESOLVE_URL "${ARG_FROM}")
    set(CMCM_MODULE_DIR "${_PMM_USER_DATA_DIR}/cmcm-${hash}/modules")
    include("${_cmcm_index_cmake}")
    list(APPEND CMAKE_MODULE_PATH "${CMCM_MODULE_DIR}")
    _pmm_lift(CMAKE_MODULE_PATH)
endfunction()
