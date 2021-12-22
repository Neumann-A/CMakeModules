

include(FindPackageHandleStandardArgs)
include(SelectLibraryConfigurations)

find_package(qwt QUIET CONFIG)
if(qwt_FOUND)
    find_package_handle_standard_args(qwt CONFIG_MODE)
    return()
endif()

find_package(Qt6 REQUIRED COMPONENTS Svg Widgets Gui Concurrent PrintSupport OpenGL)

find_path(qwt_INCLUDE_DIR NAMES "qwt.h" PATH_SUFFIXES "include")
find_library(qwt_LIBRARY_RELEASE NAMES qwt NAMES_PER_DIR)
find_library(qwt_LIBRARY_DEBUG NAMES qwt_debug qwtd qwt NAMES_PER_DIR)
select_library_configurations(qwt)

set(qwt_FOUND FALSE)
if(qwt_LIBRARIES AND NOT TARGET qwt::qwt)
    add_library(qwt::qwt UNKNOWN IMPORTED)

    target_include_directories(qwt::qwt INTERFACE "${qwt_INCLUDE_DIR}")
    target_link_libraries(qwt::qwt INTERFACE "Qt6::Gui;Qt6::Svg;Qt6::Widgets;Qt6::Concurrent;Qt6::PrintSupport;Qt6::OpenGL")

    if(qwt_LIBRARY_RELEASE)
        set_property(TARGET qwt::qwt APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
        set_target_properties(qwt::qwt PROPERTIES
            IMPORTED_LOCATION_RELEASE "${qwt_LIBRARY_RELEASE}"
        )
    endif()
    if(qwt_LIBRARY_DEBUG)
        set_property(TARGET qwt::qwt APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(qwt::qwt PROPERTIES
            IMPORTED_LOCATION_DEBUG "${qwt_LIBRARY_DEBUG}"
        )
    endif()
endif()

find_package_handle_standard_args(qwt REQUIRED_VARS qwt_LIBRARIES qwt_INCLUDE_DIR)