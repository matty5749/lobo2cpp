project(lobo2cpp)

cmake_minimum_required(VERSION 2.6)

#Generation de la documentation doxygen
FIND_PACKAGE(Doxygen)
IF (DOXYGEN_FOUND)
add_custom_target (doxygen ${DOXYGEN_EXECUTABLE} ../doxygen/Doxyfile)
ELSE ()
MESSAGE(STATUS " Doxygen introuvable , pas de generation de documentation possible")
ENDIF (DOXYGEN_FOUND)

IF(UNIX OR MINGW OR MSYS OR CYGWIN)
ADD_DEFINITIONS("-Wall")
ENDIF(UNIX OR MINGW OR MSYS OR CYGWIN)

file(
	GLOB
	sources		#La variable sources contiendra tout les .cpp
	./*.cpp
)

add_executable(
	lobo2cpp
	${sources}
)

#Configuration de l'édition de liens
#target_link_libraries(
#	${lobo2cpp}
#)
