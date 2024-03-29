

include(FindPackageHandleStandardArgs)
include(SelectLibraryConfigurations)


find_package(qcustomplot QUIET CONFIG)
if(qcustomplot_FOUND)
    find_package_handle_standard_args(qcustomplot CONFIG_MODE)
    return()
endif()

find_package(Qt6 REQUIRED COMPONENTS Widgets Gui PrintSupport)
find_package(OpenGL COMPONENTS OpenGL REQUIRED)

find_path(qcustomplot_INCLUDE_DIR NAMES "qcustomplot.h" PATH_SUFFIXES "include")
find_library(qcustomplot_LIBRARY_RELEASE NAMES qcustomplot NAMES_PER_DIR)
find_library(qcustomplot_LIBRARY_DEBUG NAMES qcustomplot_debug qcustomplotd qcustomplot NAMES_PER_DIR)
select_library_configurations(qcustomplot)

set(qcustomplot_FOUND FALSE)
if(qcustomplot_LIBRARIES AND NOT TARGET qcustomplot::qcustomplot)
    add_library(qcustomplot::qcustomplot UNKNOWN IMPORTED)

    target_include_directories(qcustomplot::qcustomplot INTERFACE "${qcustomplot_INCLUDE_DIR}")
    target_link_libraries(qcustomplot::qcustomplot INTERFACE "Qt6::Gui;Qt6::Widgets;Qt6::PrintSupport")

    if(qcustomplot_LIBRARY_RELEASE)
        set_property(TARGET qcustomplot::qcustomplot APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
        set_target_properties(qcustomplot::qcustomplot PROPERTIES
            IMPORTED_LOCATION_RELEASE "${qcustomplot_LIBRARY_RELEASE}"
        )
    endif()
    if(qcustomplot_LIBRARY_DEBUG)
        set_property(TARGET qcustomplot::qcustomplot APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(qcustomplot::qcustomplot PROPERTIES
            IMPORTED_LOCATION_DEBUG "${qcustomplot_LIBRARY_DEBUG}"
        )
    endif()
endif()

target_link_libraries(qcustomplot::qcustomplot INTERFACE OpenGL::GL Qt6::Gui Qt6::Widgets Qt6::PrintSupport)
find_package_handle_standard_args(qcustomplot REQUIRED_VARS qcustomplot_LIBRARIES qcustomplot_INCLUDE_DIR)