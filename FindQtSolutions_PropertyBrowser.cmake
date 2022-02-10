
include(FindPackageHandleStandardArgs)
include(SelectLibraryConfigurations)


set(target_name "QtSolutions::PropertyBrowser")
set(name_prefix "QtSolutions_PropertyBrowser")
set(${name_prefix}_FOUND FALSE)

find_path(${name_prefix}_INCLUDE_DIR
            NAMES 
                "qtvariantproperty.h" 
                "qtpropertybrowser.h"
            PATH_SUFFIXES 
                include 
                include/qtpropertybrowser
        )
find_library(${name_prefix}_LIBRARY_RELEASE 
                NAMES 
                ${name_prefix} 
                NAMES_PER_DIR
            )
find_library(${name_prefix}_LIBRARY_DEBUG 
                NAMES 
                    ${name_prefix}_debug 
                    ${name_prefix}d 
                    ${name_prefix} 
                NAMES_PER_DIR
            )
select_library_configurations(${name_prefix})

if(QtSolutions_PropertyBrowser_LIBRARIES AND NOT TARGET ${target_name})
    add_library(${target_name} UNKNOWN IMPORTED)
    target_include_directories(${target_name} INTERFACE "${${name_prefix}_INCLUDE_DIR}")
    if(${name_prefix}_LIBRARY_RELEASE)
        set_property(TARGET ${target_name} APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
        set_target_properties(${target_name} PROPERTIES
            IMPORTED_LOCATION_RELEASE "${${name_prefix}_LIBRARY_RELEASE}"
        )
    endif()
    if(${name_prefix}_LIBRARY_DEBUG)
        set_property(TARGET ${target_name} APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(${target_name} PROPERTIES
            IMPORTED_LOCATION_DEBUG "${${name_prefix}_LIBRARY_DEBUG}"
        )
    endif()
endif()
find_package_handle_standard_args(${name_prefix} REQUIRED_VARS ${name_prefix}_INCLUDE_DIR ${name_prefix}_LIBRARIES)
unset(target_name)
unset(lib_prefix_name)
