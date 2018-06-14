include(PropertiesReader)
include(BoardPropertiesReader)
include(PlatformFlags)

if (NOT DEFINED ARDUINO_CMAKE_PLATFORM_NAME OR NOT DEFINED ARDUINO_CMAKE_PLATFORM_PATH)
    if (USE_DEFAULT_PLATFORM_IF_NONE_EXISTING)
        set(ARDUINO_CMAKE_PLATFORM_NAME "arduino" CACHE STRING "")
        set(ARDUINO_CMAKE_PLATFORM_ARCHITECTURE "avr" CACHE STRING "")
        set(ARDUINO_CMAKE_PLATFORM_PATH "${ARDUINO_SDK_PATH}/hardware/${ARDUINO_CMAKE_PLATFORM_NAME}/${ARDUINO_CMAKE_PLATFORM_ARCHITECTURE}" CACHE PATH "")
    else ()
        message(FATAL_ERROR "Arduino Platform must be defined through name and path")
    endif ()
elseif (NOT DEFINED ARDUINO_CMAKE_PLATFORM_ARCHITECTURE) # Platform defined without architecture
    set(ARDUINO_CMAKE_PLATFORM_ARCHITECTURE "avr" CACHE STRING "")
endif ()

# Required by compiler recipes
set(build_arch "${ARDUINO_CMAKE_PLATFORM_ARCHITECTURE}" CACHE STRING "")

# Find all platform elements
include(FindPlatformElements)

read_properties(${ARDUINO_CMAKE_PLATFORM_PROPERTIES_FILE_PATH})
read_properties(${ARDUINO_CMAKE_PLATFORM_PROGRAMMERS_PATH})
read_boards_properties(${ARDUINO_CMAKE_PLATFORM_BOARDS_PATH})

setup_remaining_platform_flags()