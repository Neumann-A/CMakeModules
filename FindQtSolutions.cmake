
include(FindPackageHandleStandardArgs)
include(SelectLibraryConfigurations)

if("PropertyBrowser" IN_LIST QtSolutions_FIND_COMPONENTS)
    find_package(QtSolutions_PropertyBrowser)
endif()

set(QtSolutions_FOUND FALSE)
find_package_handle_standard_args(QtSolutions HANDLE_COMPONENTS)