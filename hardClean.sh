#! /bin/bash

	echo ""
	echo "Nettoyage du projet ..."
	echo ""
	rm -R build
	rm lobo2cpp.kdev4
	rm -R .kdev4
	rm *.*~
	rm -R doxygen/html
	echo ""
	echo "Fin du nettoyage"
	echo ""
exit
