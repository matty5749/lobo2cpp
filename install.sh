#! /bin/bash

	echo ""
	echo "Installation de lobo2cpp ..."
	echo ""
	mkdir build
	cd build
	cmake ../ -G "Unix Makefiles"
	make
	echo ""
	echo "Fin de l'installation , tapez cd build et ./lobo2cpp pour lancer l'application."
	echo ""
		
exit
